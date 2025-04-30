package controller.common;

import java.io.IOException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.UUID;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import dto.user.User;
import service.user.NaverService;
import service.user.NaverServiceImpl;

@WebServlet("/naver")
public class NaverLogin extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private static final String CLIENT_ID     = "Utlybg3qZ9sYs5XgHxgv";
    private static final String REDIRECT_URI  = "http://localhost:8080/yousinsa/naver";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        String code  = request.getParameter("code");
        String state = request.getParameter("state");

        /* ───────── 1. 인가 코드가 없으면 네이버 로그인 페이지로 이동 ───────── */
        if (code == null || code.isEmpty()) {
            // CSRF 방어용 토큰 생성
            String csrfToken = UUID.randomUUID().toString();
            session.setAttribute("oauth_state", csrfToken);

            String naverAuthUrl = "https://nid.naver.com/oauth2.0/authorize"
                    + "?response_type=code"
                    + "&client_id="    + CLIENT_ID
                    + "&redirect_uri=" + URLEncoder.encode(REDIRECT_URI, StandardCharsets.UTF_8)
                    + "&state="        + csrfToken
                    + "&auth_type=reauthenticate";   // 다른 계정 선택

            response.sendRedirect(naverAuthUrl);
            return;
        }

        /* ───────── 2. 콜백 단계 → state 값 검증 ───────── */
        String savedState = (String) session.getAttribute("oauth_state");
        if (savedState == null || !savedState.equals(state)) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "잘못된 state 값입니다.");
            return;
        }
        session.removeAttribute("oauth_state"); // 재사용 방지

        /* ───────── 3. 토큰 교환 + 사용자 정보 조회 ───────── */
        try {
            NaverService service = new NaverServiceImpl();
            User user = service.naverLogin(code);

            session.setAttribute("userId",   user.getUserId());
            session.setAttribute("name",     user.getName());
            session.setAttribute("isSeller", user.getIsSeller());

            response.sendRedirect(request.getContextPath() + "/loginSuccess");
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errMsg", "네이버 로그인 실패: " + e.getMessage());
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        }
    }
}
