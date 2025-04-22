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
@WebServlet("/adminproductsearch")
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
		// TODO Auto-generated method stub
		request.getRequestDispatcher("admin/adminProductSearch.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		String searchType = request.getParameter("searchType");
		String keyword = request.getParameter("keyword");
		
		try {
			ProductService service = new ProductServiceImpl();
			List<Product> productList = service.searchProduct(searchType, keyword);
			request.setAttribute("searchType", searchType);
			request.setAttribute("keyword", keyword);
			request.setAttribute("productList", productList);
			request.getRequestDispatcher("admin/adminProductSearch.jsp").forward(request, response);
		} catch(Exception e) {
			e.printStackTrace();
		}
		
	}

}
