package controller.admin;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import dao.order.OrderDAO;
import dao.order.OrderDAOImpl;
import dto.order.OrderList;

@WebServlet("/adminOrderDetail")
public class AdminOrderDetail extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public AdminOrderDetail() {
        super();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String orderIdParam = request.getParameter("orderId");

        if (orderIdParam == null || orderIdParam.trim().isEmpty()) {
            response.sendRedirect("adminSearchMember.jsp?error=잘못된 요청입니다");
            return;
        }

        try {
            int orderId = Integer.parseInt(orderIdParam);
            OrderDAO orderDao = new OrderDAOImpl();

            // ✅ 올바른 메서드로 호출
            OrderList order = orderDao.findOrderListById(orderId); 

            if (order != null) {
                request.setAttribute("order", order);
            } else {
                request.setAttribute("error", "해당 주문 정보를 찾을 수 없습니다.");
            }

            // ✅ forward는 한 번만 호출
            request.getRequestDispatcher("/admin/adminOrderDetail.jsp").forward(request, response);

        } catch (NumberFormatException e) {
            response.sendRedirect("adminSearchMember.jsp?error=잘못된 주문 ID 형식입니다");
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "주문 조회 중 오류가 발생했습니다.");
            request.getRequestDispatcher("/admin/adminOrderDetail.jsp").forward(request, response);
        }
    }
}
