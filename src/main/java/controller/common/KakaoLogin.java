package controller.common;

import java.io.IOException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.UUID;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dto.user.User;
import service.user.KakaoService;
import service.user.KakaoServiceImpl;

@WebServlet("/kakao")
public class KakaoLogin extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private static final String CLIENT_ID = "888443c6b67363c2f04b7ea5408a3a95";
    private static final String REDIRECT_URI = "http://localhost:8080/yousinsa/kakao"; // 콜백 URL
    private static final String PROMPT       = "select_account";

    public KakaoLogin() {
        super();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession();

        String code = request.getParameter("code"); // 카카오 인가코드
        String state = request.getParameter("state");

        if (code == null || code.isEmpty()) {
            // CSRF 방지용 임의 토큰 생성
            String csrfToken = UUID.randomUUID().toString();
            session.setAttribute("oauth_state", csrfToken);

            String kakaoAuthUrl =
                    "https://kauth.kakao.com/oauth/authorize"
                  + "?client_id="      + CLIENT_ID
                  + "&redirect_uri="   + URLEncoder.encode(REDIRECT_URI, StandardCharsets.UTF_8)
                  + "&response_type=code"
                  + "&prompt="         + PROMPT            // ← 계정 선택
                  + "&state="          + csrfToken;        // ← 세션에 저장한 토큰

            response.sendRedirect(kakaoAuthUrl);
            return;
        }

        /* 2) 인가 코드가 있으면 → state 검증 후 토큰 교환·로그인 */
        String savedState = (String) session.getAttribute("oauth_state");
        if (savedState == null || !savedState.equals(state)) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "잘못된 state 값입니다.");
            return;
        }
        session.removeAttribute("oauth_state"); // 재사용 방지

        // code가 있으면 → 카카오 토큰 요청 + 사용자 정보 조회
        KakaoService service = new KakaoServiceImpl();
        try {
            User user = service.kakaoLogin(code);

            // 로그인 성공 → 세션 저장

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
