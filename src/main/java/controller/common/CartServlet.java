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

import service.order.CartService;
import service.order.CartServiceImpl;



@WebServlet("/cart")
public class CartServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		CartService service = new CartServiceImpl();
		HttpSession session = request.getSession();
		String userId = (String) session.getAttribute("userId");

		if (userId == null) {
			response.sendRedirect("login");
			return;
		}

		try {
			List<Cart> cartList = service.getCartList(userId); 
			request.setAttribute("cartList", cartList);
			request.getRequestDispatcher("/common/cart.jsp").forward(request, response);
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("err", "장바구니 정보를 불러오는 중 오류가 발생했습니다.");
			request.getRequestDispatcher("/error.jsp").forward(request, response);
		}
	}
}
