package controller.user;

import java.io.IOException;
import java.util.stream.Collectors;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dto.order.OrderItem;
import dto.order.OrderList;
import dto.order.Return;
import service.order.OrderService;
import service.order.OrderServiceImpl;
import service.order.ReturnService;
import service.order.ReturnServiceImpl;

/**
 * Servlet implementation class MyReturnDetail
 */
@WebServlet("/myReturnDetail")
public class MyReturnDetail extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public MyReturnDetail() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		ReturnService returnService = new ReturnServiceImpl();
	    OrderService orderService = new OrderServiceImpl();
	    
	    
	 // --- 1) 로그인 체크 ---
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        // --- 2) 파라미터 읽기 ---
        String sReturnId = request.getParameter("returnId");
        if (sReturnId == null) {
            response.sendRedirect(request.getContextPath() + "/myOrders");
            return;
        }
        int returnId = Integer.parseInt(sReturnId);

        try {
            // --- 3) 반품 정보 가져오기 ---
            Return ret = returnService.getReturnById(returnId);
            if (ret == null) {
                throw new ServletException("해당 반품 내역을 찾을 수 없습니다. returnId=" + returnId);
            }

            // --- 4) 실제 order_id 찾기 (orderItemId → orderId) ---
            OrderItem oi = orderService.findOrderItemById(ret.getOrderItemId());
            if (oi == null) {
                throw new ServletException("반품 대상 주문 아이템을 찾을 수 없습니다. orderItemId=" 
                                           + ret.getOrderItemId());
            }
            int orderId = oi.getOrderId();

            // --- 5) 주문 상세 조회 ---
            OrderList order = orderService.getOrderDetail(orderId);
            if (order == null) {
                throw new ServletException("해당 주문을 찾을 수 없습니다. orderId=" + orderId);
            }

            // --- 6) 상세 페이지에는 ‘이 반품 아이템’ 만 보여주기 위해 필터링 ---
            order.setItems(
              order.getItems().stream()
                   .filter(i -> i.getOrderItemId() == ret.getOrderItemId())
                   .collect(Collectors.toList())
            );

            // --- 7) JSP 로 전달 ---
            request.setAttribute("ret", ret);
            request.setAttribute("order", order);
            request.getRequestDispatcher("/user/myReturnDetail.jsp")
                   .forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            throw new ServletException("반품 상세조회 중 오류 발생", e);
        }
    }

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
