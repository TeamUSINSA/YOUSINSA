package controller.common;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import service.order.OrderListService;
import service.order.OrderListServiceImpl;

/**
 * Servlet implementation class PaymentFail
 */
@WebServlet("/paymentFail")
public class PaymentFail extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private OrderListService orderListService = new OrderListServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String rawOrderId = req.getParameter("orderId");   // ex: "ORD_9"
        String code       = req.getParameter("code");
        String message    = req.getParameter("message");

        // 1) 주문번호 정수 부분만 파싱
        int orderId = Integer.parseInt(rawOrderId.replaceAll("\\D", ""));

        // 2) PENDING → CANCELLED 처리
        try {
            orderListService.cancelOrder(orderId);
        } catch(Exception e) {
            e.printStackTrace();
            // 취소 처리 실패해도 넘어가도록
        }

        // 3) JSP에 전달
        req.setAttribute("rawOrderId", rawOrderId);
        req.setAttribute("code",       code);
        req.setAttribute("message",    message);

        req.getRequestDispatcher("/common/paymentFail.jsp")
           .forward(req, resp);
    }
}




