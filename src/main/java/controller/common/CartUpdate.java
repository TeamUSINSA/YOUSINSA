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
	private final CartService service = new CartServiceImpl();

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
	        throws ServletException, IOException {
	    request.setCharacterEncoding("utf-8");

	    try {
	        String cartIdParam = request.getParameter("cartId");
	        String quantityParam = request.getParameter("quantity");
	        System.out.println("▶️ cartId: " + cartIdParam + ", quantity: " + quantityParam);

	        // 유효성 검사
	        if (cartIdParam == null || cartIdParam.trim().isEmpty() ||
	            quantityParam == null || quantityParam.trim().isEmpty()) {
	            throw new IllegalArgumentException("cartId 또는 quantity가 비어있음");
	        }

	        int cartId = Integer.parseInt(cartIdParam);
	        int quantity = Integer.parseInt(quantityParam);

	        Cart cart = new Cart();
	        cart.setCartId(cartId);
	        cart.setQuantity(quantity);

	        System.out.println("▶️ cartId: " + cartId + ", quantity: " + quantity);

	        service.updateQuantity(cart);

	        response.setContentType("text/plain; charset=utf-8");
	        response.getWriter().write("ok");

	    } catch (Exception e) {
	        e.printStackTrace();
	        response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
	        response.getWriter().write("fail");
	    }
	}

}
