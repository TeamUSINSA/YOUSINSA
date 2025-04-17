package controller.common;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import dto.user.User;
import service.user.UserService;
import service.user.UserServiceImpl;

@WebServlet("/findPassword")
public class FindPassword extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public FindPassword() {
		super();
	}

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.getRequestDispatcher("/common/findPassword.jsp").forward(request, response);
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		request.setCharacterEncoding("UTF-8");

		String name = request.getParameter("name");
		String userId = request.getParameter("userId");
		String email = request.getParameter("email");

		UserService userService = new UserServiceImpl();
		User foundUser = userService.findUserForPasswordReset(name, userId, email);

		if (foundUser != null) {
			// 사용자 ID를 세션에 저장하고 비밀번호 변경 페이지로 이동
			HttpSession session = request.getSession();
			session.setAttribute("resetUserId", foundUser.getUserId());

			response.sendRedirect("/yousinsa/changePassword");
		} else {
			// 일치하는 사용자 없음 → 다시 입력 폼으로
			response.sendRedirect("/yousinsa/findPassword");
		}
	}
}
