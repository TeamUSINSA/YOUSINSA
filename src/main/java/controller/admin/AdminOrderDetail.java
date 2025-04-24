package controller.admin;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import dao.order.OrderDAO;
import dao.order.OrderDAOImpl;
import dto.order.OrderList;

@WebServlet("/adminorderdetail")
public class AdminOrderDetail extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public AdminOrderDetail() {
        super();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String orderIdParam = request.getParameter("orderId");

        if (orderIdParam == null) {
            response.sendRedirect("adminSearchMember.jsp?error=잘못된 요청입니다");
            return;
        }

        try {
            int orderId = Integer.parseInt(orderIdParam);
            OrderDAO orderDao = new OrderDAOImpl();
            OrderList order = orderDao.findOrderById(orderId); // 이 메서드는 DAO에 구현되어 있어야 함

            if (order != null) {
                request.setAttribute("order", order);
                request.getRequestDispatcher("/admin/adminOrderDetail.jsp").forward(request, response);
            } else {
                request.setAttribute("error", "해당 주문 정보를 찾을 수 없습니다.");
                request.getRequestDispatcher("/admin/adminOrderDetail.jsp").forward(request, response);
            }

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "주문 조회 중 오류가 발생했습니다.");
            request.getRequestDispatcher("/admin/adminOrderDetail.jsp").forward(request, response);
        }
    }
}
