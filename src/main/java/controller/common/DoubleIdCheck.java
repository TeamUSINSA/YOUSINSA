package controller.common;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import service.user.UserService;
import service.user.UserServiceImpl;

/**
 * Servlet implementation class DoubleIdCheck
 */
@WebServlet("/doubleIdCheck")
public class DoubleIdCheck extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private UserService userService = new UserServiceImpl();

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String userId = request.getParameter("userId");
		boolean isDuplicate = false;

		try {
			isDuplicate = userService.isDuplicateId(userId);
		} catch (Exception e) {
			e.printStackTrace();
		}

		response.setContentType("text/plain");
		response.getWriter().write(Boolean.toString(isDuplicate));
	}
}