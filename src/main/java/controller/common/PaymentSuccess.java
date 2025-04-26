package controller.common;

import java.io.IOException;
import java.net.URI;
import java.net.URLEncoder;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.nio.charset.StandardCharsets;
import java.time.Instant;
import java.time.OffsetDateTime;
import java.util.Base64;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;

import dto.order.OrderItem;
import dto.order.OrderList;
import dto.user.Point;
import service.order.CartService;
import service.order.CartServiceImpl;
import service.order.CouponService;
import service.order.CouponServiceImpl;
import service.order.OrderItemService;
import service.order.OrderItemServiceImpl;
import service.order.OrderListService;
import service.order.OrderListServiceImpl;
import service.product.ProductStockService;
import service.product.ProductStockServiceImpl;
import service.user.PointService;
import service.user.PointServiceImpl;
import service.user.UserService;
import service.user.UserServiceImpl;

@WebServlet("/paymentSuccess")
public class PaymentSuccess extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static final String SECRET_KEY = "test_gsk_docs_OaPz8L5KdmQXkzRz3y47BMw6";

	private final OrderListService orderListService = new OrderListServiceImpl();
	private final OrderItemService orderItemService = new OrderItemServiceImpl();
	private final ProductStockService productStockService = new ProductStockServiceImpl();
	private final CouponService couponService = new CouponServiceImpl();
	private final UserService userService = new UserServiceImpl();
	private final PointService pointService = new PointServiceImpl();
	  private final CartService cartService = new CartServiceImpl();

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		String rawOrderId = req.getParameter("orderId"); // "ORDER_11"
		String paymentKey = req.getParameter("paymentKey");
		int amountParam = Integer.parseInt(req.getParameter("amount"));
		int orderId = Integer.parseInt(rawOrderId.replaceAll("\\D", ""));

		HttpClient client = HttpClient.newHttpClient();
		String auth = Base64.getEncoder().encodeToString((SECRET_KEY + ":").getBytes(StandardCharsets.UTF_8));

		try {
			// 1) 결제 확정
			JSONObject confirmBody = new JSONObject();
			confirmBody.put("paymentKey", paymentKey);
			confirmBody.put("orderId", rawOrderId);
			confirmBody.put("amount", amountParam);

			HttpRequest confirmReq = HttpRequest.newBuilder()
					.uri(URI.create("https://api.tosspayments.com/v1/payments/confirm"))
					.header("Authorization", "Basic " + auth).header("Content-Type", "application/json")
					.POST(HttpRequest.BodyPublishers.ofString(confirmBody.toString())).build();

			HttpResponse<String> confirmRes = client.send(confirmReq, HttpResponse.BodyHandlers.ofString());
			if (confirmRes.statusCode() != 200) {
				resp.sendRedirect(
						String.format("%s/paymentFail?orderId=%s&code=CONFIRM_FAILED&message=%s", req.getContextPath(),
								URLEncoder.encode(rawOrderId, "UTF-8"), URLEncoder.encode("결제 확정 실패", "UTF-8")));
				return;
			}

			// 2) 상태 검증
			JSONObject json = (JSONObject) new JSONParser().parse(confirmRes.body());
			String status = (String) json.get("status");
			if (!"DONE".equals(status) || json.get("approvedAt") == null) {
				resp.sendRedirect(String.format("%s/paymentFail?orderId=%s&code=NOT_COMPLETED&message=%s",
						req.getContextPath(), URLEncoder.encode(rawOrderId, "UTF-8"),
						URLEncoder.encode("아직 결제가 완료되지 않았습니다.", "UTF-8")));
				return;
			}

			// 3) 금액 검증
			long paidTotal = ((Number) json.get("totalAmount")).longValue();
			if (paidTotal != amountParam) {
				resp.sendRedirect(String.format("%s/paymentFail?orderId=%s&code=VERIFICATION_FAILED&message=%s",
						req.getContextPath(), URLEncoder.encode(rawOrderId, "UTF-8"),
						URLEncoder.encode("결제 검증 실패", "UTF-8")));
				return;
			}
			
			

			// 4) metadata 파싱
			JSONObject meta          = (JSONObject) json.get("metadata");
			String     orderInfoJson = (String)    meta.get("order_info");
			String     pointJson     = (String)    meta.get("point");
			String     itemsJson     = (String)    meta.get("order_items");

			String cartIdsJson = (String) meta.get("cart_ids");
			JSONArray cartArr  = (JSONArray) new JSONParser().parse(cartIdsJson);
			System.out.println(cartIdsJson);
			for(Object o : cartArr){
			    cartService.removeCartById(Integer.parseInt(o.toString()));
			}
			
			
			JSONObject info  = (JSONObject)new JSONParser().parse(orderInfoJson);
			JSONObject pInfo  = (JSONObject)new JSONParser().parse(pointJson);
			JSONArray  arr    = (JSONArray) new JSONParser().parse(itemsJson);

			int usedPoints   = ((Number)pInfo.get("used")).intValue();
			int earnedPoints = ((Number)pInfo.get("earned")).intValue();

			int totalPrice     = ((Number)info.get("total_price")).intValue();
			int usedPoint      = ((Number)info.get("used_point")).intValue();
			int couponDiscount = ((Number)info.get("coupon_discount")).intValue();
			
			OffsetDateTime odt = OffsetDateTime.parse(json.get("approvedAt").toString());
			Instant inst       = odt.toInstant();

			// java.sql.Date 를 풀네임으로
			java.sql.Date sqlDate = new java.sql.Date(inst.toEpochMilli());

			// ── orderlist 업데이트
			OrderList ol = new OrderList();
			ol.setOrderId(orderId);
			ol.setPaymentStatus("PAID");
			ol.setPaymentKey(paymentKey);
			ol.setApprovedAt(sqlDate);
			ol.setTotalPrice(totalPrice);
			ol.setDeliveryRequest((String)info.get("delivery_request"));
			ol.setPaymentMethod((String)info.get("payment_method"));
			ol.setUserId((String)info.get("user_id"));
			ol.setReceiverName((String)info.get("receiver_name"));
			ol.setReceiverPhone((String)info.get("receiver_phone"));
			ol.setReceiverAddress((String)info.get("receiver_address"));
			ol.setUsedPoint(usedPoint);
			ol.setCouponDiscount(couponDiscount);
			orderListService.markPaid(ol);

			// ── 포인트 저장
			Point pUsed = new Point(orderId, ol.getUserId(), usedPoints);
			Point pEarn = new Point(orderId, ol.getUserId(), earnedPoints);
			pointService.savePoint(pUsed);
			pointService.savePoint(pEarn);

			// ── order_items 반복 처리
			for (Object o : arr) {
			    JSONObject oi = (JSONObject)o;
			    System.out.println(">>> JSON 객체: " + oi.toJSONString());
			    System.out.println("… → quantity:" + oi.get("quantity")
			    + ", color:" + oi.get("color")
			    + ", size:" + oi.get("size")
			    + ", coupon_id:" + oi.get("coupon_id"));
			    OrderItem item = new OrderItem();
			    item.setOrderId(orderId);
			    item.setProductId(((Number)oi.get("product_id")).intValue());
			    item.setQuantity(((Number)oi.get("quantity")).intValue());
			    // coupon_id 는 null 또는 숫자 문자열이므로
			    String c = (String)oi.get("coupon_id");
			    item.setCouponId(c==null||c.isEmpty() ? 0 : Integer.parseInt(c));
			    item.setColor((String)oi.get("color"));
			    item.setSize((String)oi.get("size"));
			    orderItemService.addItem(item);

			    // 재고 차감
			    productStockService.decrementStock(
			        item.getProductId(),
			        item.getColor(),
			        item.getSize(),
			        item.getQuantity()
			    );

			    // 쿠폰 사용 처리
			    if (item.getCouponId() > 0) {
			        couponService.markCouponUsed(ol.getUserId(), item.getCouponId());
			    }
			}
			
			if (cartArr != null) {
			    for (Object o : cartArr) {
			        int cid = Integer.parseInt(o.toString());
			        cartService.removeCartById(cid);
			    }
			}
			

			// 8) 성공 페이지 포워드
			req.setAttribute("paymentInfo", json);
			req.getRequestDispatcher("/common/paymentSuccess.jsp").forward(req, resp);

		} catch (Exception e) {
			e.printStackTrace();
			req.setAttribute("err", "결제 처리 중 오류 발생");
			req.getRequestDispatcher("/error.jsp").forward(req, resp);
		}
	}
}
