package controller.admin;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dto.product.Product;
import service.admin.ProductService;
import service.admin.ProductServiceImpl;

/**
 * Servlet implementation class AdminProductSearch
 */
@WebServlet("/adminProductSearch")
public class AdminProductSearch extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AdminProductSearch() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            dao.product.CategoryDAO categoryDAO = new dao.product.CategoryDAOImpl();
            List<dto.product.Category> categoryList = categoryDAO.selectAllCategories();
            request.setAttribute("categoryList", categoryList);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("categoryList", null);
        }

        request.getRequestDispatcher("admin/adminProductSearch.jsp").forward(request, response);
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	    request.setCharacterEncoding("utf-8");
	    String searchType = request.getParameter("searchType");
	    String keyword = request.getParameter("keyword");

	    // 1. 페이지 파라미터 처리
	    int currentPage = 1;
	    String pageParam = request.getParameter("page");
	    if (pageParam != null) {
	        currentPage = Integer.parseInt(pageParam);
	    }

	    int itemsPerPage = 10;  // 한 페이지당 보여줄 항목 수
	    int offset = (currentPage - 1) * itemsPerPage;

	    try {
	        ProductService service = new ProductServiceImpl();

	        // 2. 페이징 적용된 목록 조회
	        List<Product> productList = service.searchProduct(searchType, keyword, offset, itemsPerPage);

	        // 3. 총 개수 조회해서 페이지 수 계산
	        int totalCount = service.countProduct(searchType, keyword);
	        int totalPages = (int) Math.ceil((double) totalCount / itemsPerPage);
	        
	     // ✅ 카테고리 목록 추가
            dao.product.CategoryDAO categoryDAO = new dao.product.CategoryDAOImpl();
            List<dto.product.Category> categoryList = categoryDAO.selectAllCategories(); // 이름은 너가 실제 쓰는 걸로 맞춰줘
            request.setAttribute("categoryList", categoryList);
	        

	        // 4. JSP로 전달
	        request.setAttribute("searchType", searchType);
	        request.setAttribute("keyword", keyword);
	        request.setAttribute("productList", productList);
	        request.setAttribute("currentPage", currentPage);
	        request.setAttribute("totalPages", totalPages);

	        request.getRequestDispatcher("/admin/adminProductSearch.jsp").forward(request, response);
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	}


}
