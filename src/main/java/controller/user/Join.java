package controller.user;

import java.io.IOException;
import java.sql.Date;

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
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Join() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.getRequestDispatcher("/user/join.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		String id = request.getParameter("userId");
		String password = request.getParameter("password");
		String checkPassword = request.getParameter("checkPassword");
		String name = request.getParameter("name");
		String phoneNum = request.getParameter("phoneNum");
		String email = request.getParameter("email");
		String birthStr = request.getParameter("birth");

        Date birth = null;
        try {
            birth = Date.valueOf(birthStr); 
        } catch (IllegalArgumentException e) {
            request.setAttribute("err", "생년월일 형식이 잘못되었습니다.");
            request.getRequestDispatcher("/error.jsp").forward(request, response);
            return;
        }

        User user = new User(id, password, checkPassword, name, phoneNum, email, birth);
        UserService service = new UserServiceImpl();

        try {
            service.join(user);
            response.sendRedirect("login");
        } catch (Exception e) {
            e.printStackTrace(); 
            request.setAttribute("err", "회원가입에 실패했습니다.");
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        }
    }
}


