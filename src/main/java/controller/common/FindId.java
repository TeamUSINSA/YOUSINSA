package controller.common;

import service.user.UserService;
import service.user.UserServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/findId")
public class FindId extends HttpServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.getRequestDispatcher("/common/findId.jsp").forward(request, response);
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		request.setCharacterEncoding("UTF-8");
		UserService userService = new UserServiceImpl();
		String name = request.getParameter("name");
		String email = request.getParameter("email");
		String phone = request.getParameter("phone");
		System.out.println("입력값 디버깅 → name: " + name + ", email: " + email + ", phone: " + phone);

		

		try {
			String foundId = userService.findUserId(name, email, phone);

			// 아이디를 URL 파라미터로 redirect
			if (foundId != null) {
				response.sendRedirect(request.getContextPath() + "/afterFindId?id=" + foundId);
			} else {
				response.sendRedirect(request.getContextPath() + "/afterFindId?id=notfound");
			}

		} catch (Exception e) {
			e.printStackTrace();
			response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "아이디 찾기 실패");
		}
	}
}
