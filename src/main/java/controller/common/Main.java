package controller.common;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import dto.product.Product;
import dto.product.BannerProduct;
import service.product.ProductService;
import service.product.ProductServiceImpl;
import service.product.BannerProductService;
import service.product.BannerProductServiceImpl;

@WebServlet("/main")
public class Main extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public Main() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		ProductService productService = new ProductServiceImpl();
		BannerProductService bannerService = new BannerProductServiceImpl();

		try {
			// ✅ 배너 테이블에서 메인/서브 배너 조회
			List<BannerProduct> mainBannerList = bannerService.getMainBannerList();
			List<BannerProduct> subBannerList = bannerService.getSubBannerList();

			// ✅ 기존 인기상품, 추천상품은 product 테이블 기준 유지
			List<Product> popularList = productService.getRandomProductsByType("popular", 4);
			List<Product> recommendList = productService.getRandomProductsByType("recommend", 4);

			// request에 담기
			request.setAttribute("mainBannerList", mainBannerList);
			request.setAttribute("subBannerList", subBannerList);
			request.setAttribute("popularList", popularList);
			request.setAttribute("recommendList", recommendList);

			request.getRequestDispatcher("/common/main.jsp").forward(request, response);
		} catch (Exception e) {
			e.printStackTrace();
			response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "메인 페이지 로딩 실패");
		}
	}
}
