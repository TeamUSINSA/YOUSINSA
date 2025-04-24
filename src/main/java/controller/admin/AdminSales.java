package controller.admin;

import dao.product.ProductDAO;
import dao.product.ProductDAOImpl;
import dto.product.Product;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;
import java.util.Map;

@WebServlet("/adminsales")
public class AdminSales extends HttpServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		// 1. 파라미터 받기
		String startDate = request.getParameter("startDate");
		String endDate = request.getParameter("endDate");
		String mainCategory = request.getParameter("mainCategory");
		String subCategory = request.getParameter("subCategory");

		ProductDAO dao = new ProductDAOImpl();

		try {
			// 2. 총 매출 조회
			int totalSales = dao.getTotalSales(startDate, endDate, mainCategory, subCategory);
			request.setAttribute("totalSales", totalSales);

			// 3. 차트용 라벨 + 데이터 조회
			Map<String, List<Integer>> chartData = dao.getSalesChartData(startDate, endDate);
			request.setAttribute("chartLabels", chartData.keySet()); // 라벨 (예: 날짜)
			request.setAttribute("chartData", chartData); // 실제 차트용 데이터

			// 4. 카테고리 리스트 조회 (현재는 하드코딩 → 나중에 DB 조회로 확장 가능)
			request.setAttribute("mainCategoryList", List.of("상의", "하의", "신발"));
			request.setAttribute("subCategoryList", List.of("반팔", "긴팔", "청바지"));

			// 5. 상위 10개 상품 리스트
			List<Product> topProducts = dao.getTop10Products(startDate, endDate);
			request.setAttribute("topProducts", topProducts);

		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("error", "매출 조회 중 오류가 발생했습니다.");
		} finally {
			((ProductDAOImpl) dao).closeSession(); // 커넥션 반환
		}

		request.getRequestDispatcher("/admin/adminSales.jsp").forward(request, response);
	}
}
