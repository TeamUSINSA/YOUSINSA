package controller.user;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dto.order.OrderItem;
import dto.order.OrderList;
import service.order.OrderService;
import service.order.OrderServiceImpl;

/**
 * Servlet implementation class MyOrderDetail
 */
@WebServlet("/myOrderDetail")
public class MyOrderDetail extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private final OrderService orderService = new OrderServiceImpl();
       
  
    public MyOrderDetail() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 1. 세션에서 userId 확인
        HttpSession session = request.getSession();
        String userId = (String) session.getAttribute("userId");

        if (userId == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        // 2. orderId 파라미터로 받기
        String noParam = request.getParameter("no");
        if (noParam == null || noParam.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/myOrders");
            return;
        }

        int orderId;
        try {
            orderId = Integer.parseInt(noParam);
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/myOrders");
            return;
        }

        try {
            // 3. 서비스에서 상세 정보 조회
            OrderList order = orderService.getOrderDetail(orderId);

            // 4. 유저 본인의 주문이 아닌 경우 예외 처리
            if (!userId.equals(order.getUserId())) {
                response.sendRedirect(request.getContextPath() + "/myOrders");
                return;
            }

            // 5. JSP에 전달
            request.setAttribute("order", order);
            request.getRequestDispatcher("/user/myOrderDetail.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "주문 정보를 불러오는 데 실패했습니다.");
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        }
    }



	

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
