package controller.user;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import service.user.MyCancelService;
import service.user.MyCancelServiceImpl;
import dto.order.OrderList;
import service.order.OrderListService;
import service.order.OrderListServiceImpl;

@WebServlet("/myCancelApply")
public class MyCancelApply extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private final OrderListService orderService = new OrderListServiceImpl();
    private final MyCancelService cancelService = new MyCancelServiceImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // 로그인 체크
        HttpSession session = request.getSession(false);
        String userId = session != null ? (String) session.getAttribute("userId") : null;
        if (userId == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        // orderId 파라미터
        String sOrderId = request.getParameter("orderId");
        if (sOrderId == null) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "orderId 누락");
            return;
        }
        int orderId = Integer.parseInt(sOrderId);

        try {
            // 주문 정보 조회
            OrderList order = orderService.getOrder(orderId);
            if (!userId.equals(order.getUserId())) {
                response.sendError(HttpServletResponse.SC_FORBIDDEN, "권한 없음");
                return;
            }
            request.setAttribute("order", order);
            request.getRequestDispatcher("/user/myCancelApply.jsp")
                   .forward(request, response);
        } catch (Exception e) {
            throw new ServletException("취소신청 페이지 로딩 실패", e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession(false);
        String userId = session != null ? (String) session.getAttribute("userId") : null;
        if (userId == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        // 폼 파라미터
        int orderId   = Integer.parseInt(request.getParameter("orderId"));
        String reason = request.getParameter("reason");
        String etc    = request.getParameter("reasonEtc");
        if ("기타".equals(reason) && etc != null && !etc.isBlank()) {
            reason = etc.trim();
        }

        try {
            // 1) cancel 테이블 INSERT
            // 2) orderlist.delivery_status = '취소완료'
            cancelService.requestCancel(orderId, userId, reason);
        } catch (Exception e) {
            throw new ServletException("취소신청 처리 실패", e);
        }

        // 취소/반품 내역 페이지로 이동
        response.sendRedirect(request.getContextPath() + "/myCancelList");
    }
}
