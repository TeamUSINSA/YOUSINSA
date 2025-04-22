package controller.common;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.google.gson.JsonObject;
import service.user.LikeService;
import service.user.LikeServiceImpl;

@WebServlet("/likeProduct")
public class LikeProduct extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private final LikeService likeService = new LikeServiceImpl();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // 세션에서 로그인된 사용자 ID 조회
        HttpSession session = request.getSession(false);
        String userId = (session != null) ? (String) session.getAttribute("userId") : null;

        if (userId == null) {
            // 로그인하지 않은 경우 401 반환
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            return;
        }

        // productId 파싱
        int productId;
        try {
            productId = Integer.parseInt(request.getParameter("productId"));
        } catch (NumberFormatException e) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            return;
        }

        boolean liked;
        int count;
        try {
            // 좋아요 토글 및 총 좋아요 수 조회
            liked = likeService.toggleLike(userId, productId);
            count = likeService.countLikes(productId);
        } catch (Exception e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            return;
        }

        // JSON 응답
        response.setContentType("application/json; charset=UTF-8");
        JsonObject json = new JsonObject();
        json.addProperty("liked", liked);
        json.addProperty("count", count);
        response.getWriter().write(json.toString());
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // GET 요청은 허용하지 않음 (405)
        response.sendError(HttpServletResponse.SC_METHOD_NOT_ALLOWED);
    }
}
