package controller.common;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dto.order.Cart;
import dto.user.User;
import service.order.CartService;
import service.order.CartServiceImpl;
import service.user.UserService;
import service.user.UserServiceImpl;

@WebServlet("/orderList")
public class OrderListServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private CartService cartService = new CartServiceImpl();
    private UserService userService = new UserServiceImpl();
    private static final int SHIPPING_FEE = 3000;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // 1) 로그인 체크
        HttpSession session = request.getSession(false);
        String userId = (session != null) ? (String) session.getAttribute("userId") : null;
        if (userId == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        try {
            // 2) 장바구니 목록 조회
            List<Cart> productList = cartService.selectCartListByUser(userId);

            // 3) 총 상품 금액 계산 (쿠폰 할인은 JSP에서 적용)
            int totalPrice = 0;
            for (Cart c : productList) {
                totalPrice += c.getPrice() * c.getQuantity();
            }

            // 4) 사용자 정보 조회
            User user = userService.getUserById(userId);

            // 5) 모델 바인딩
            request.setAttribute("productList", productList);
            request.setAttribute("totalPrice", totalPrice);
            request.setAttribute("shippingFee", SHIPPING_FEE);
            request.setAttribute("user", user);

            // 6) JSP 포워드
            request.getRequestDispatcher("/common/orderList.jsp")
                   .forward(request, response);

        } catch (Exception e) {
            throw new ServletException("주문 페이지 로드 중 오류 발생", e);
        }
    }
}
