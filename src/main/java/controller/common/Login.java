package controller.common;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import dto.user.User;
import service.user.UserService;
import service.user.UserServiceImpl;

@WebServlet("/login")
public class Login extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public Login() {
		super();
	}

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String error = request.getParameter("error");
		if ("1".equals(error)) {
			request.setAttribute("errMsg", "아이디 또는 비밀번호가 일치하지 않습니다.");
		}
		if ("2".equals(error)) {
			request.setAttribute("errMsg", "삭제된 회원입니다. 관리자에게 문의하세요.");
		}
		request.getRequestDispatcher("/common/login.jsp").forward(request, response);
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		request.setCharacterEncoding("utf-8");

		String userId = request.getParameter("userId");
		String password = request.getParameter("password");
		String saveId = request.getParameter("saveId"); // 체크박스가 체크 안 되면 null

		UserService service = new UserServiceImpl();

		User user = new User();
		user.setUserId(userId);
		user.setPassword(password);

		try {
			User loginUser = service.login(user);

			if (loginUser != null) {
				// 로그인된 사용자가 삭제된 사용자일 경우 처리
				if (loginUser.getDeleted()) { // boolean 값으로 확인
					request.setAttribute("errMsg", "삭제된 회원입니다. 관리자에게 문의하세요.");
					response.sendRedirect("login?error=2");
					return;
				}

				// ✅ 세션 저장
				HttpSession session = request.getSession();
				session.setAttribute("userId", loginUser.getUserId());
				session.setAttribute("name", loginUser.getName());
				session.setAttribute("isSeller", loginUser.getIsSeller());

				// ✅ 아이디 저장 쿠키 처리
				Cookie saveIdCookie = new Cookie("saveId", "on".equals(saveId) ? userId : "");
				saveIdCookie.setMaxAge("on".equals(saveId) ? 60 * 60 * 24 * 30 : 0); // 30일 or 삭제
				saveIdCookie.setPath("/");
				response.addCookie(saveIdCookie);

				response.sendRedirect("loginSuccess");
			} else {
				request.setAttribute("errMsg", "아이디 또는 비밀번호가 일치하지 않습니다.");
				response.sendRedirect("login?error=1");
				return;
			}

		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("errMsg", "로그인 중 오류가 발생했습니다.");
			request.getRequestDispatcher("/error.jsp").forward(request, response);
		}
	}

}
