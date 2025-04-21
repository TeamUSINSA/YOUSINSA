package controller.common;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import dto.order.Cart;
import service.order.CartService;
import service.order.CartServiceImpl;

@WebServlet("/cartAdd")
public class CartAdd extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private CartService service = new CartServiceImpl();

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		request.setCharacterEncoding("UTF-8");

		// 로그인된 사용자 세션에서 ID 확인
		HttpSession session = request.getSession();
		String userId = (String) session.getAttribute("userId");

		if (userId == null) {
			response.sendRedirect(request.getContextPath() + "/common/login.jsp");
			return;
		}

		try {
			int productId = Integer.parseInt(request.getParameter("productId"));
			String color = request.getParameter("color");
			String size = request.getParameter("size");
			int quantity = Integer.parseInt(request.getParameter("quantity"));

			Cart cart = new Cart();
			cart.setUserId(userId);
			cart.setProductId(productId);
			cart.setColor(color);
			cart.setSize(size);
			cart.setQuantity(quantity);

			// 중복된 항목이 있으면 수량만 업데이트, 없으면 새로 추가
			Cart existingItem = service.getCartItem(cart);
			if (existingItem != null) {
				// 수량 누적
				cart.setCartId(existingItem.getCartId());
				cart.setQuantity(existingItem.getQuantity() + quantity);
				service.updateQuantity(cart);
			} else {
				service.addCart(cart);
			}

			response.sendRedirect(request.getContextPath() + "/cart");

		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("err", "장바구니 추가 중 오류가 발생했습니다.");
			request.getRequestDispatcher("/error.jsp").forward(request, response);
		}
	}
}
