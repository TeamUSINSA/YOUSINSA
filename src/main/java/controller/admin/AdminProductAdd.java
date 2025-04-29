package controller.admin;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import dto.product.Category;
import dto.product.Product;
import dto.product.ProductStock;
import service.admin.ProductService;
import service.admin.ProductServiceImpl;
import service.product.CategoryService;
import service.product.CategoryServiceImpl;

/**
 * Servlet implementation class AdminProductAdd
 */
@WebServlet("/adminProductAdd")
public class AdminProductAdd extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AdminProductAdd() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		CategoryService service = new CategoryServiceImpl();
		try {
			List<Category> categoryList = service.selectCategoryList();
			request.setAttribute("categoryList", categoryList);
			request.setAttribute("subCategoryList", service.selectSubCategoriesByCategoryId(categoryList.get(0).getCategoryId()));
			request.getRequestDispatcher("admin/adminProductAdd.jsp").forward(request, response);
		} catch(Exception e) {
			e.printStackTrace();
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	    try {
	        ProductService service = new ProductServiceImpl();
	        Integer productId = service.regProduct(request); // 상품 등록
	        response.sendRedirect(request.getContextPath() + "/admin/adminProductDetail.jsp?productId=" + productId);
	    } catch (Exception e) {
	        e.printStackTrace();
	        request.setAttribute("errorMessage", "상품 등록 중 오류가 발생했습니다.");
	        request.getRequestDispatcher("error.jsp").forward(request, response); // 에러 페이지로 포워딩
	    }
	}

}
