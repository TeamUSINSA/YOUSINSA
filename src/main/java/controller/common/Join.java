package controller.common;

import java.io.IOException;
import java.sql.Date;
import java.text.SimpleDateFormat;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dto.user.User;
import service.user.UserService;
import service.user.UserServiceImpl;


/**
 * Servlet implementation class Join
 */
@WebServlet("/join")
public class Join extends HttpServlet {
	
	
	
	 @Override
	    protected void doGet(HttpServletRequest request, HttpServletResponse response)
	            throws ServletException, IOException {
	        request.getRequestDispatcher("/common/join.jsp").forward(request, response);
	    }
	
	
	

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    	 UserService service = new UserServiceImpl();
    	 
        request.setCharacterEncoding("UTF-8");

        String userId = request.getParameter("userId");
        String password = request.getParameter("password");
        String name = request.getParameter("name");
        String phone = request.getParameter("phone_num");
        String email = request.getParameter("email_id") + "@" + request.getParameter("email_domain");
       
        
        Date birth = null;
        try {
            birth = new Date(new SimpleDateFormat("yyyyMMdd").parse(request.getParameter("birth")).getTime());
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        User user = new User();
        user.setUserId(userId);
        user.setPassword(password);
        user.setName(name);
        user.setPhone(phone);
        user.setEmail(email);
        user.setBirth(birth);

        try {
            service.join(user);
            response.sendRedirect(request.getContextPath() + "/common/Afterlogin.jsp");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }
    }
}