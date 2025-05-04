package controller.common;

import java.io.IOException;
import java.sql.Date;
import java.text.SimpleDateFormat;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dto.user.Alert;
import dto.user.User;
import service.user.AlertService;
import service.user.AlertServiceImpl;
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
	     String phone = request.getParameter("phone1") + "-" +
	             request.getParameter("phone2") + "-" +
	             request.getParameter("phone3");

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

	         User loginUser = service.login(user);

	         if (loginUser != null) {
	             HttpSession session = request.getSession();
	             session.setAttribute("userId", loginUser.getUserId());
	             session.setAttribute("name", loginUser.getName());
	             session.setAttribute("isSeller", loginUser.getIsSeller());
	             
	             Alert welcomeAlert = new Alert();
	             welcomeAlert.setUserId(loginUser.getUserId());
	             welcomeAlert.setTitle("🎉 YOUSINSA에 오신 걸 환영합니다!");
	             welcomeAlert.setContent("첫 방문을 축하드려요. 다양한 혜택을 지금 만나보세요.");
	             welcomeAlert.setSenderId("system");
	             welcomeAlert.setSenderName("YOUSINSA");
	             welcomeAlert.setType("welcome");
	             welcomeAlert.setChecked(false);

	             AlertService alertService = new AlertServiceImpl();
	             alertService.insertAlert(welcomeAlert);

	             response.sendRedirect("afterJoin");
	         } else {
	             response.sendRedirect("login?error=1");
	         }
	     } catch (Exception e) {
	         e.printStackTrace();
	         response.sendRedirect("error.jsp");
	     }
	 }

}