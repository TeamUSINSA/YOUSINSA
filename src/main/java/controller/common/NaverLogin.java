package controller.common;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import dto.user.User;
import service.user.NaverService;
import service.user.NaverServiceImpl;

@WebServlet("/naver")
public class NaverLogin extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private static final String CLIENT_ID = "Utlybg3qZ9sYs5XgHxgv";
	private static final String REDIRECT_URI = "http://localhost:8080/yousinsa/naver";
	private static final String STATE = "1234"; // CSRF 방지용 임의 문자열

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String code = request.getParameter("code");

		if (code == null || code.isEmpty()) {
			// 로그인 요청 단계 → 네이버 인증 URL로 리다이렉트
			String naverAuthUrl = "https://nid.naver.com/oauth2.0/authorize"
					+ "?response_type=code"
					+ "&client_id=" + CLIENT_ID
					+ "&redirect_uri=" + REDIRECT_URI
					+ "&state=" + STATE;
			response.sendRedirect(naverAuthUrl);
			return;
		}

		// 로그인 성공 후 code 수신 단계
		NaverService service = new NaverServiceImpl();
		try {
			User user = service.naverLogin(code);


			HttpSession session = request.getSession();
			session.setAttribute("userId", user.getUserId());
			session.setAttribute("name", user.getName());
			session.setAttribute("isSeller", user.getIsSeller());

			response.sendRedirect(request.getContextPath() + "/loginSuccess");
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("errMsg", "네이버 로그인 실패: " + e.getMessage());
			request.getRequestDispatcher("/error.jsp").forward(request, response);
		}
	}
}
