package controller.user;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import service.user.UserService;
import service.user.UserServiceImpl;

/**
 * Servlet implementation class CheckDoubleId
 */
@WebServlet("/checkDoubleId")
public class CheckDoubleId extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String userId = request.getParameter("userId");
		UserService service = new UserServiceImpl();
		boolean result = false;

		try {
			result = service.checkDoubleId(userId); // 중복이면 true
		} catch (Exception e) {
			e.printStackTrace();
		}

		response.setContentType("text/plain; charset=UTF-8");
		response.getWriter().write(String.valueOf(result));
	}
}