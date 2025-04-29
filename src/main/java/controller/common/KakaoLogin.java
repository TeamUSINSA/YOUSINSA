package controller.common;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import dto.user.User;
import service.user.KakaoService;
import service.user.KakaoServiceImpl;

@WebServlet("/kakao")
public class KakaoLogin extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private static final String CLIENT_ID = "888443c6b67363c2f04b7ea5408a3a95";
    private static final String REDIRECT_URI = "http://localhost:8080/yousinsa/kakao"; // 콜백 URL

    public KakaoLogin() {
        super();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        String code = request.getParameter("code"); // 카카오 인가코드

        if (code == null || code.isEmpty()) {
            // code가 없으면 → 카카오 로그인 URL로 리다이렉트
            String kakaoAuthUrl = "https://kauth.kakao.com/oauth/authorize"
                    + "?client_id=" + CLIENT_ID
                    + "&redirect_uri=" + REDIRECT_URI
                    + "&response_type=code";

            response.sendRedirect(kakaoAuthUrl);
            return;
        }

        // code가 있으면 → 카카오 토큰 요청 + 사용자 정보 조회
        KakaoService service = new KakaoServiceImpl();
        try {
            User user = service.kakaoLogin(code);

            // 로그인 성공 → 세션 저장
            HttpSession session = request.getSession();
            session.setAttribute("userId", user.getUserId());
            session.setAttribute("name", user.getName());
            session.setAttribute("isSeller", user.getIsSeller());

            // 메인 페이지로 이동
            response.sendRedirect(request.getContextPath() + "/loginSuccess");
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errMsg", "카카오 로그인 실패: " + e.getMessage());
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        }
    }
}
