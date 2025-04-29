package controller.admin;

import dao.product.ProductDAO;
import dao.product.ProductDAOImpl;
import dto.product.Product;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.*;

@WebServlet("/adminSales")
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

            // 3. 차트용 라벨 + 데이터 조회 (List<Map<String, Object>> 형태)
            List<Map<String, Object>> rawChartData = dao.getSalesChartData(startDate, endDate);
            List<String> chartLabels = new ArrayList<>();
            List<Integer> chartValues = new ArrayList<>();

            for (Map<String, Object> row : rawChartData) {
                Object labelObj = row.get("label");
                Object valueObj = row.get("value");

                if (labelObj != null && valueObj != null) {
                    chartLabels.add(labelObj.toString());
                    chartValues.add(Integer.parseInt(valueObj.toString()));
                }
            }

            request.setAttribute("chartLabels", chartLabels);
            request.setAttribute("chartData", chartValues);

            // 4. 카테고리 리스트를 DB에서 동적으로 조회
            List<String> mainCategories = dao.getAllMainCategories();
            List<String> subCategories = dao.getAllSubCategories();
            request.setAttribute("mainCategoryList", mainCategories);
            request.setAttribute("subCategoryList", subCategories);

            // 5. 상위 10개 상품 리스트
            List<Product> topProducts = dao.getTop10Products(startDate, endDate);
            request.setAttribute("topProducts", topProducts);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "매출 조회 중 오류가 발생했습니다.");
        } finally {
            ((ProductDAOImpl) dao).closeSession(); // 커넥션 닫기
        }

        // 6. 포워딩
        request.getRequestDispatcher("/admin/adminSales.jsp").forward(request, response);
    }
}
