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

    private static final String CLIENT_ID    = "888443c6b67363c2f04b7ea5408a3a95";
    private static final String REDIRECT_URI = "http://localhost:8080/yousinsa/kakao";
    private static final String PROMPT       = "select_account";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession();

        String code  = request.getParameter("code");
        String state = request.getParameter("state");

        if (code == null || code.isEmpty()) {
            String csrfToken = UUID.randomUUID().toString();
            session.setAttribute("oauth_state", csrfToken);

            String kakaoAuthUrl = "https://kauth.kakao.com/oauth/authorize"
                    + "?client_id=" + CLIENT_ID
                    + "&redirect_uri=" + URLEncoder.encode(REDIRECT_URI, StandardCharsets.UTF_8)
                    + "&response_type=code"
                    + "&prompt=" + PROMPT
                    + "&state=" + csrfToken;

            response.sendRedirect(kakaoAuthUrl);
            return;
        }

        String savedState = (String) session.getAttribute("oauth_state");
        if (savedState == null || !savedState.equals(state)) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "잘못된 state 값입니다.");
            return;
        }
        session.removeAttribute("oauth_state");

        try {
            KakaoService service = new KakaoServiceImpl();
            User user = service.kakaoLogin(code);

            session.setAttribute("userId",   user.getUserId());
            session.setAttribute("name",     user.getName());
            session.setAttribute("isSeller", user.getIsSeller());

            response.sendRedirect(request.getContextPath() + "/loginSuccess");
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errMsg", "카카오 로그인 실패: " + e.getMessage());
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        }
    }
}
