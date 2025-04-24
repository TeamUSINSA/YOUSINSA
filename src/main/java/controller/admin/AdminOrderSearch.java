package controller.admin;

import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import dto.order.OrderList;
import service.order.OrderService;
import service.order.OrderServiceImpl;

@WebServlet("/adminOrderSearch")
public class AdminOrderSearch extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public AdminOrderSearch() {
        super();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            // 파라미터 받기
            String userId = request.getParameter("userId");
            String status = request.getParameter("status");
            String period = request.getParameter("period");

            // null 또는 'all' 값 처리
            if (userId == null || userId.trim().isEmpty()) {
                userId = "";
            }
            if (status == null || status.equals("all")) {
                status = "";
            }
            if (period == null || period.equals("all")) {
                period = "";
            }

            // 서비스 호출
            OrderService service = new OrderServiceImpl();
            List<OrderList> orderList = service.getFilteredOrders(userId, status, period);
            int totalPages = service.getTotalPages();

            // JSP로 전달
            request.setAttribute("orderList", orderList);
            request.setAttribute("totalPages", totalPages);
            request.setAttribute("userId", userId);       // JSP에 필터 유지용
            request.setAttribute("status", status);
            request.setAttribute("period", period);

            // 포워딩
            request.getRequestDispatcher("/admin/adminOrderSearch.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "주문 조회 중 오류가 발생했습니다.");
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        }
    }
}
