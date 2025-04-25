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
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;

import dto.order.OrderItem;
import dto.order.OrderList;
import service.order.CouponService;
import service.order.CouponServiceImpl;
import service.order.OrderItemService;
import service.order.OrderItemServiceImpl;
import service.order.OrderListService;
import service.order.OrderListServiceImpl;
import service.product.ProductStockService;
import service.product.ProductStockServiceImpl;
import service.user.UserService;
import service.user.UserServiceImpl;

@WebServlet("/paymentSuccess")
public class PaymentSuccess extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final String SECRET_KEY = "test_gsk_docs_OaPz8L5KdmQXkzRz3y47BMw6";

    private final OrderListService     orderListService    = new OrderListServiceImpl();
    private final OrderItemService     orderItemService    = new OrderItemServiceImpl();
    private final ProductStockService  productStockService = new ProductStockServiceImpl();
    private final CouponService        couponService       = new CouponServiceImpl();
    private final UserService          userService         = new UserServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String rawOrderId  = req.getParameter("orderId");       // "ORDER_11"
        String paymentKey  = req.getParameter("paymentKey");
        int    amountParam = Integer.parseInt(req.getParameter("amount"));
        int    orderId     = Integer.parseInt(rawOrderId.replaceAll("\\D",""));

        HttpClient client = HttpClient.newHttpClient();
        String auth = Base64.getEncoder()
            .encodeToString((SECRET_KEY + ":").getBytes(StandardCharsets.UTF_8));

        try {
            // 1) 결제 확정
            JSONObject confirmBody = new JSONObject();
            confirmBody.put("paymentKey", paymentKey);
            confirmBody.put("orderId", rawOrderId);
            confirmBody.put("amount", amountParam);

            HttpRequest confirmReq = HttpRequest.newBuilder()
                .uri(URI.create("https://api.tosspayments.com/v1/payments/confirm"))
                .header("Authorization", "Basic " + auth)
                .header("Content-Type", "application/json")
                .POST(HttpRequest.BodyPublishers.ofString(confirmBody.toString()))
                .build();

            HttpResponse<String> confirmRes = client.send(confirmReq, HttpResponse.BodyHandlers.ofString());
            if (confirmRes.statusCode() != 200) {
                resp.sendRedirect(String.format(
                    "%s/paymentFail?orderId=%s&code=CONFIRM_FAILED&message=%s",
                    req.getContextPath(),
                    URLEncoder.encode(rawOrderId,"UTF-8"),
                    URLEncoder.encode("결제 확정 실패","UTF-8")
                ));
                return;
            }

            // 2) 상태 검증
            JSONObject json = (JSONObject)new JSONParser().parse(confirmRes.body());
            String status = (String)json.get("status");
            if (!"DONE".equals(status) || json.get("approvedAt")==null) {
                resp.sendRedirect(String.format(
                    "%s/paymentFail?orderId=%s&code=NOT_COMPLETED&message=%s",
                    req.getContextPath(),
                    URLEncoder.encode(rawOrderId,"UTF-8"),
                    URLEncoder.encode("아직 결제가 완료되지 않았습니다.","UTF-8")
                ));
                return;
            }

            // 3) 금액 검증
            long paidTotal = ((Number)json.get("totalAmount")).longValue();
            if (paidTotal != amountParam) {
                resp.sendRedirect(String.format(
                    "%s/paymentFail?orderId=%s&code=VERIFICATION_FAILED&message=%s",
                    req.getContextPath(),
                    URLEncoder.encode(rawOrderId,"UTF-8"),
                    URLEncoder.encode("결제 검증 실패","UTF-8")
                ));
                return;
            }

            // 4) metadata의 order_info 파싱
            JSONObject meta = (JSONObject)json.get("metadata");
            String orderInfoJson = (String)meta.get("order_info");
            JSONObject info = (JSONObject)new JSONParser().parse(orderInfoJson);

            // 5) approvedAt 파싱
            OffsetDateTime odt = OffsetDateTime.parse(json.get("approvedAt").toString());
            Instant inst = odt.toInstant();
            java.sql.Date sqlDate = new java.sql.Date(inst.toEpochMilli());

            // 6) orderlist 업데이트
            OrderList ol = new OrderList();
            ol.setOrderId(orderId);
            ol.setPaymentStatus("PAID");
            ol.setPaymentKey(paymentKey);
            ol.setApprovedAt(sqlDate);
            ol.setTotalPrice(((Number)info.get("total_price")).intValue());
            ol.setDeliveryStatus("배송준비중");
            ol.setDeliveryRequest((String)info.get("delivery_request"));
            ol.setPaymentMethod((String)info.get("payment_method"));
            ol.setUserId((String)info.get("user_id"));
            ol.setReceiverName((String)info.get("receiver_name"));
            ol.setReceiverPhone((String)info.get("receiver_phone"));
            ol.setReceiverAddress((String)info.get("receiver_address"));
            ol.setUsedPoint(((Number)info.get("used_point")).intValue());
            ol.setCouponDiscount(((Number)info.get("coupon_discount")).intValue());
            orderListService.markPaid(ol);

            // 7) orderitem·재고·쿠폰 처리
            List<OrderItem> items = orderItemService.getItems(orderId);
            for (OrderItem item : items) {
                orderItemService.addItem(item);
                productStockService.decrementStock(
                    item.getProductId(), item.getColor(), item.getSize(), item.getQuantity()
                );
                if (item.getCouponId() > 0) {
                    couponService.markCouponUsed(ol.getUserId(), item.getCouponId());
                }
            }

            // 8) 성공 페이지 포워드
            req.setAttribute("paymentInfo", json);
            req.getRequestDispatcher("/common/paymentSuccess.jsp")
               .forward(req, resp);

        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("err", "결제 처리 중 오류 발생");
            req.getRequestDispatcher("/error.jsp").forward(req, resp);
        }
    }
}
