package controller.common;

import java.io.IOException;
import java.util.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import dto.order.Cart;
import service.order.CartService;
import service.order.CartServiceImpl;

@WebServlet("/cartOrder")
public class CartOrder extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private CartService service = new CartServiceImpl();

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		request.setCharacterEncoding("UTF-8");

		HttpSession session = request.getSession();
		String userId = (String) session.getAttribute("userId");

		if (userId == null) {
			response.sendRedirect("login");
			return;
		}

		try {
			String[] cartIds = request.getParameterValues("cartId");

			List<Cart> selectedItems = new ArrayList<>();

			if (cartIds != null) {
				for (String id : cartIds) {
					int cartId = Integer.parseInt(id);

					Cart cart = new Cart();
					cart.setCartId(cartId);
					cart.setUserId(userId); // 확인용

					Cart item = service.getCartItem(cart);
					if (item != null) {
						selectedItems.add(item);
					}
				}
			}

			request.setAttribute("orderList", selectedItems);
			request.getRequestDispatcher("/order/orderConfirm.jsp").forward(request, response);

		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("err", "주문 처리 중 오류 발생");
			request.getRequestDispatcher("/error.jsp").forward(request, response);
		}
	}
}
