package controller.common;

import dto.order.Cart;
import service.order.CartService;
import service.order.CartServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/cartUpdate")
public class CartUpdate extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // 한글 깨짐 방지
        request.setCharacterEncoding("utf-8");

        // 서비스 호출 전 로그
        System.out.println("[CartUpdate] doPost 호출");

        CartService service = new CartServiceImpl();

        try {
            String cartIdParam   = request.getParameter("cartId");
            String quantityParam = request.getParameter("quantity");
            System.out.println("[CartUpdate] 파라미터 → cartId: " + cartIdParam
                               + ", quantity: " + quantityParam);

            // 유효성 검사
            if (cartIdParam == null || cartIdParam.trim().isEmpty()
                    || quantityParam == null || quantityParam.trim().isEmpty()) {
                throw new IllegalArgumentException("cartId 또는 quantity가 비어있음");
            }

            int cartId   = Integer.parseInt(cartIdParam);
            int quantity = Integer.parseInt(quantityParam);
            System.out.println("[CartUpdate] 파싱 후 → cartId: " + cartId
                               + ", quantity: " + quantity);

            Cart cart = new Cart();
            cart.setCartId(cartId);
            cart.setQuantity(quantity);

            // 수량 업데이트 호출 전
            System.out.println("[CartUpdate] 서비스 호출: updateQuantity");
            service.updateQuantity(cart);
            System.out.println("[CartUpdate] 서비스 완료: updateQuantity 성공");

            response.setContentType("text/plain; charset=utf-8");
            response.getWriter().write("ok");

        } catch (Exception e) {
            // 에러 발생 로그
            System.err.println("[CartUpdate] 에러 발생: " + e.getMessage());
            e.printStackTrace();

            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("fail");
        }
    }
}
