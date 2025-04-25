package controller.common;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dto.order.Order;
import dto.order.OrderList;
import dto.user.User;
import dto.user.UserCoupon;
import service.order.OrderListService;
import service.order.OrderListServiceImpl;
import service.order.OrderService;
import service.order.OrderServiceImpl;
import service.product.ProductService;
import service.product.ProductServiceImpl;
import service.user.UserService;
import service.user.UserServiceImpl;

@WebServlet("/order")
public class OrderServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private ProductService productService = new ProductServiceImpl();
	private OrderService orderService = new OrderServiceImpl();
	private UserService userService = new UserServiceImpl();
	private OrderListService orderListService = new OrderListServiceImpl();

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		HttpSession session = req.getSession(false);
		String userId = session != null ? (String) session.getAttribute("userId") : null;
		if (userId == null) {
			resp.sendRedirect(req.getContextPath() + "/login");
			return;
		}

		try {
			// — 1) 파라미터로 넘어온 상품 목록 (바로구매 or 장바구니) 처리
			String[] productIds = req.getParameterValues("productId");
			String[] colors = req.getParameterValues("color");
			String[] sizes = req.getParameterValues("size");
			String[] qtys = req.getParameterValues("quantity");

			// 없으면 장바구니로
			if (productIds == null || productIds.length == 0) {
				resp.sendRedirect(req.getContextPath() + "/cart");
				return;
			}

			List<Order> orderList = new ArrayList<>();
			for (int i = 0; i < productIds.length; i++) {
				Order o = new Order();
				o.setUserId(userId);
				o.setProductId(Integer.parseInt(productIds[i]));
				o.setColor(colors[i]);
				o.setSize(sizes[i]);
				o.setQuantity(Integer.parseInt(qtys[i]));

				// 상품 이름·이미지·단가 세팅
				var p = productService.selectById(o.getProductId());
				o.setName(p.getName());
				o.setImage(p.getMainImage1());
				o.setUnitPrice(p.getPrice());

				orderList.add(o);
			}
			

			// — 2) 유저 정보
			User user = userService.getUserById(userId);

			// — 3) 사용 가능한 쿠폰 목록
			List<UserCoupon> couponList = userService.getUnusedCoupons(userId);

			int totalPrice = orderList.stream().mapToInt(o -> o.getUnitPrice() * o.getQuantity()).sum();


			OrderList pending = new OrderList();
			pending.setUserId(userId);
			pending.setTotalPrice(totalPrice);

			pending.setPaymentStatus("PENDING");
			orderListService.createPendingOrder(pending);
			


			req.setAttribute("productList", orderList);
			req.setAttribute("user", user);
			req.setAttribute("couponList", couponList);

			req.setAttribute("pendingOrderId", pending.getOrderId());

			req.getRequestDispatcher("/common/order.jsp").forward(req, resp);

		} catch (Exception e) {
			e.printStackTrace();
			req.setAttribute("err", "주문 정보 불러오기 실패");
			req.getRequestDispatcher("/error.jsp").forward(req, resp);
		}
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		HttpSession session = req.getSession();
		String userId = (String) session.getAttribute("userId");
		if (userId == null) {
			resp.sendRedirect("login");
			return;
		}

		try {
			System.out.println("===== [POST 주문 요청 시작] =====");

			String receiverName = req.getParameter("receiverName");
			String receiverPhone = req.getParameter("phone1") + "-" + req.getParameter("phone2") + "-"
					+ req.getParameter("phone3");
			String baseAddress = req.getParameter("baseAddress");
			String detailAddress = req.getParameter("detailAddress");
			int usedPoints = Integer
					.parseInt(req.getParameter("usedPoints") == null ? "0" : req.getParameter("usedPoints"));
			String paymentMethod = req.getParameter("paymentMethod");

			List<Order> orderList = new ArrayList<>();

			// 장바구니 주문
			String[] cartIds = req.getParameterValues("cartId");
			if (cartIds != null) {
				List<Integer> ids = new ArrayList<>();
				for (String id : cartIds) {
					if (id != null && !id.isEmpty()) {
						ids.add(Integer.parseInt(id));
					}
				}
				orderList = orderService.selectOrderItemsByCartIds(ids);

				// 바로 주문
			} else {
				String[] productIds = req.getParameterValues("productId");
				String[] colors = req.getParameterValues("color");
				String[] sizes = req.getParameterValues("size");
				String[] quantities = req.getParameterValues("quantity");
				String[] unitPrices = req.getParameterValues("unitPrice");
				String[] couponIds = req.getParameterValues("couponId");

				for (int i = 0; i < productIds.length; i++) {
					Order o = new Order();
					o.setProductId(Integer.parseInt(productIds[i]));
					o.setColor(colors[i]);
					o.setSize(sizes[i]);
					o.setQuantity(Integer.parseInt(quantities[i]));
					o.setUnitPrice(Integer.parseInt(unitPrices[i]));
					if (couponIds != null && couponIds.length > i && couponIds[i] != null && !couponIds[i].isEmpty()) {
						o.setCouponId(Integer.parseInt(couponIds[i]));
					}
					orderList.add(o);
				}
			}

			// 공통 배송 정보
			for (Order o : orderList) {
				o.setUserId(userId);
				o.setReceiverName(receiverName);
				o.setReceiverPhone(receiverPhone);
				o.setBaseAddress(baseAddress);
				o.setDetailAddress(detailAddress);
				o.setUsedPoints(usedPoints);
				o.setPaymentMethod(paymentMethod);
			}

			orderService.insertOrderList(orderList);
			resp.sendRedirect(req.getContextPath() + "/common/orderComplete.jsp");

		} catch (Exception e) {
			e.printStackTrace();
			req.setAttribute("err", "주문 처리 실패");
			req.getRequestDispatcher("/error.jsp").forward(req, resp);
		}
	}
}
