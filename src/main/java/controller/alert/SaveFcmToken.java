package controller.alert;

import java.io.IOException;
import java.util.stream.Collectors;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONObject;

import service.user.UserService;
import service.user.UserServiceImpl;

@WebServlet("/saveFcmToken")
public class SaveFcmToken extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        req.setCharacterEncoding("UTF-8");

        String body = req.getReader().lines().collect(Collectors.joining());
        JSONObject json = new JSONObject(body);
        String token = json.optString("token");

        HttpSession session = req.getSession(false);
        String userId = (session != null) ? (String) session.getAttribute("userId") : null;

        if (userId != null && token != null && !token.isEmpty()) {
            UserService service = new UserServiceImpl();
            try {
                service.updateFcmToken(userId, token);
                resp.setStatus(HttpServletResponse.SC_OK);
            } catch (Exception e) {
                resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                e.printStackTrace();
            }
        } else {
            resp.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            System.err.println("❌ 토큰 저장 실패: 로그인 또는 토큰 없음");
        }
    }
}
