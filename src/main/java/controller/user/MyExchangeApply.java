package controller.user;

import java.io.IOException;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.product.ProductStockDAO;
import dao.product.ProductStockDAOImpl;
import dto.order.Exchange;
import dto.order.OrderItem;
import dto.product.ProductStock;
import dto.user.User;
import service.order.ExchangeService;
import service.order.ExchangeServiceImpl;
import service.order.OrderService;
import service.order.OrderServiceImpl;
import service.user.UserService;
import service.user.UserServiceImpl;

@WebServlet("/myExchangeApply")
public class MyExchangeApply extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public MyExchangeApply() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		OrderService orderService = new OrderServiceImpl();
		ExchangeService exchangeService = new ExchangeServiceImpl();
		ProductStockDAO stockDAO     = new ProductStockDAOImpl();
		HttpSession session = request.getSession(false);
        String userId = (String) session.getAttribute("userId");
        if (userId == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        UserService userService = new UserServiceImpl();
        try {
            User user = userService.getUserById(userId);
            request.setAttribute("user", user);
        } catch (Exception e) {
        	e.printStackTrace();
            throw new ServletException("유저 정보 조회 실패", e);
        }

        int orderId = Integer.parseInt(request.getParameter("orderId"));
        int orderItemId = Integer.parseInt(request.getParameter("orderItemId"));

        // 1) 해당 주문의 배송완료된 아이템 중 요청한 하나만 조회
        List<OrderItem> items;
        try {
            items = exchangeService.getDeliveredItems(userId, orderId);
        } catch (Exception e) {
            throw new ServletException(e);
        }
        OrderItem selected = items.stream()
            .filter(i -> i.getOrderItemId() == orderItemId)
            .findFirst()
            .orElse(null);
        if (selected == null) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "유효하지 않은 교환 대상입니다.");
            return;
        }
        request.setAttribute("product", selected);

        // 2) 상품 재고에서 색상/사이즈 목록 가져오기 (재고 0은 제외)
        List<ProductStock> stocks;
        try {
            stocks = stockDAO.selectStockByProductId(selected.getProductId());
        } catch (Exception e) {
            throw new ServletException(e);
        }
        Set<String> colors = stocks.stream()
            .filter(s -> s.getQuantity() > 0)
            .map(ProductStock::getColor)
            .collect(Collectors.toCollection(LinkedHashSet::new));
        Set<String> sizes  = stocks.stream()
            .filter(s -> s.getQuantity() > 0)
            .map(ProductStock::getSize)
            .collect(Collectors.toCollection(LinkedHashSet::new));

        request.setAttribute("availableColors", colors);
        request.setAttribute("availableSizes", sizes);

        // 3) 사용자의 이전 교환 내역(해당 아이템 기준)
        List<Exchange> all;
        try {
            all = exchangeService.getAllExchanges();
        } catch (Exception e) {
            throw new ServletException(e);
        }
        List<Exchange> history = all.stream()
            .filter(x -> userId.equals(x.getUserId()) && x.getOrderItemId() == orderItemId)
            .collect(Collectors.toList());
        request.setAttribute("exchangeList", history);

        // 4) JSP로 포워드
        request.getRequestDispatcher("/user/myExchangeApply.jsp")
               .forward(request, response);
    }
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		ExchangeService exchangeService = new ExchangeServiceImpl();
		request.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession(false);
        String userId = (String) session.getAttribute("userId");
        if (userId == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
     // 디버그: 파라미터가 제대로 넘어오는지 확인
        String reason = request.getParameter("reason");
        String size   = request.getParameter("exchangeSize");
        String color  = request.getParameter("exchangeColor");
        String note   = request.getParameter("exchangeNote");
        System.out.println("▶▶ 교환신청 파라미터 ▶ reason=" + reason
            + ", size=" + size + ", color=" + color + ", note=" + note);

        int orderItemId = Integer.parseInt(request.getParameter("orderItemId"));

        Exchange ex = new Exchange();
        ex.setUserId(userId);
        ex.setOrderItemId(orderItemId);
        ex.setReason(reason);

     // 기타 선택 시 note를 reason 필드에 넣고 싶다면:
        if ("other".equals(reason) || "defect".equals(reason)) {
            ex.setReason(note != null && !note.isEmpty() ? note : reason);
        } else {
            ex.setReason(reason);
        }

        // 사이즈/색상은 null 허용
        ex.setSize(size);
        ex.setColor(color);

        try {
            exchangeService.applyExchange(ex);
        } catch (Exception e) {
            throw new ServletException(e);
        }

        response.sendRedirect(request.getContextPath() + "/myOrders");
    }
}
