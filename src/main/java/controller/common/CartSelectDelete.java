package controller.common;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import service.order.CartService;
import service.order.CartServiceImpl;

@WebServlet("/cartSelectDelete")
public class CartSelectDelete extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public CartSelectDelete() {
		super();
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");

		String[] cartIds = request.getParameterValues("cartIds");
		CartService service = new CartServiceImpl();

		try {
			if (cartIds != null) {
				for (String idStr : cartIds) {
					int cartId = Integer.parseInt(idStr);
					System.out.println("[선택삭제] cartId: " + cartId);
					service.removeCartById(cartId);
				}
			}
			response.sendRedirect(request.getContextPath() + "/cart");

		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("err", "장바구니 항목 삭제 중 오류가 발생했습니다.");
			request.getRequestDispatcher("/error.jsp").forward(request, response);
		}
	}
}
