package controller.admin;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import service.order.OrderService;
import service.order.OrderServiceImpl;

@WebServlet("/adminOrderStatusUpdate")
public class AdminOrderStatusUpdate extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");
        
        try {
            Integer orderId = Integer.parseInt(request.getParameter("orderId"));
            String deliveryStatus = request.getParameter("deliveryStatus");

            OrderService service = new OrderServiceImpl();
            service.updateDeliveryStatus(orderId, deliveryStatus);

            response.getWriter().println("<script>");
            response.getWriter().println("alert('배송 상태가 변경되었습니다.');");
            response.getWriter().println("location.href='" + request.getContextPath() + "/adminOrderSearch';");
            response.getWriter().println("</script>");
        } catch(Exception e) {
            e.printStackTrace();
            response.getWriter().println("<script>");
            response.getWriter().println("alert('오류가 발생했습니다.');");
            response.getWriter().println("history.back();");
            response.getWriter().println("</script>");
        }
    }
}
