package controller.user;

import java.io.IOException;
import java.util.List;
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
 * Servlet implementation class MyReturnApply
 */
@WebServlet("/myReturnApply")
public class MyReturnApply extends HttpServlet {
	private static final long serialVersionUID = 1L;
	

    public MyReturnApply() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		ReturnService returnService = new ReturnServiceImpl();
		OrderService orderService = new OrderServiceImpl();

		HttpSession httpSession = request.getSession(false);
        if (httpSession == null || httpSession.getAttribute("userId") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        String userId = (String) httpSession.getAttribute("userId");
     // 파라미터
        int orderId      = Integer.parseInt(request.getParameter("orderId"));
        int orderItemId  = Integer.parseInt(request.getParameter("orderItemId"));

        // ①  OrderService로부터 주문+아이템 전체를 불러온 뒤
        try {
            // ① 주문 상세 정보 로드
            OrderList order = orderService.getOrderDetail(orderId);

            // ② 단일 아이템만 필터
            order.setItems(
              order.getItems().stream()
                   .filter(i -> i.getOrderItemId() == orderItemId)
                   .collect(Collectors.toList())
            );

            // ③ 뷰에 데이터 전달
            request.setAttribute("order",       order);
            request.setAttribute("orderId",     orderId);
            request.setAttribute("orderItemId", orderItemId);

            // ④ JSP 포워드
            request.getRequestDispatcher("/user/myReturnApply.jsp")
                   .forward(request, response);

        } catch (Exception e) {
        	e.printStackTrace();
            // 서비스 호출 중 예외 발생 시 서블릿 예외로 포장
            throw new ServletException("반품 신청 페이지 로드 중 오류 발생", e);
        }
    }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		ReturnService returnService = new ReturnServiceImpl();
		
		request.setCharacterEncoding("UTF-8");

        String itemId   = request.getParameter("orderItemId");
        String orderId  = request.getParameter("orderId");
        String reason   = request.getParameter("reason");
        HttpSession session = request.getSession(false);
        String userId   = (String) session.getAttribute("userId");

        Return returnReq = new Return();
        returnReq.setOrderItemId(Integer.parseInt(itemId));
        returnReq.setOrderId(Integer.parseInt(orderId));
        returnReq.setReason(reason);
        returnReq.setUserId(userId);
        returnReq.setApproved(0);          // 초기 상태: 처리중
        returnReq.setRejectReason(null);

        try {
            returnService.requestReturn(returnReq);
            response.sendRedirect(request.getContextPath() + "/myOrders");
        } catch (Exception e) {
        	e.printStackTrace();
            throw new ServletException(e);
        }
    }
}