package controller.common;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dto.product.Product;
import service.product.ProductService;
import service.product.ProductServiceImpl;

/**
 * Servlet implementation class Main
 */
@WebServlet("/main")
public class Main extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public Main() {
		super();
		// TODO Auto-generated constructor stub
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		ProductService productService = new ProductServiceImpl();

		try {
			List<Product> mainList = productService.getProductsByType("main");
			List<Product> subList = productService.getProductsByType("sub");
			List<Product> popularList = productService.getRandomProductsByType("popular", 4);
			List<Product> recommendList = productService.getRandomProductsByType("recommend", 4);

			request.setAttribute("mainList", mainList);
			request.setAttribute("subList", subList);
			request.setAttribute("popularList", popularList);
			request.setAttribute("recommendList", recommendList);

			request.getRequestDispatcher("/common/main.jsp").forward(request, response);
		} catch (Exception e) {
			e.printStackTrace();
			response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "상품 불러오기 실패");
		}

	}

}
