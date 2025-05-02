package controller.common;

import dto.user.RestockRequest;
import service.user.MyRestockRequestService;
import service.user.MyRestockRequestServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/restockRequestAdd")
public class RestockRequestAdd extends HttpServlet {
    private static final long serialVersionUID = 1L;


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        MyRestockRequestService restockService = new MyRestockRequestServiceImpl();
        HttpSession session = request.getSession(false);
        String userId = session != null ? (String)session.getAttribute("userId") : null;
        if (userId == null) {
            response.sendError(HttpServletResponse.SC_UNAUTHORIZED);
            return;
        }

        // 파라미터
        int productId = Integer.parseInt(request.getParameter("productId"));
        String color  = request.getParameter("color");
        String size   = request.getParameter("size");

        // DTO 생성
        RestockRequest rr = new RestockRequest();
        rr.setUserId(userId);
        rr.setProductId(productId);
        rr.setColor(color);
        rr.setSize(size);

        try {
            // 새 메소드명으로 호출
            restockService.requestRestock(rr);
            response.setStatus(HttpServletResponse.SC_OK);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR,
                               "재입고 요청 저장 실패");
        }
    }
}
