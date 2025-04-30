package controller.admin;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dto.product.Category;
import dto.product.ProductAndOption;
import dto.product.SubCategory;
import service.admin.ProductService;
import service.admin.ProductServiceImpl;
import service.product.CategoryService;
import service.product.CategoryServiceImpl;

/**
 * Servlet implementation class AdminProductModify
 */
@WebServlet("/adminProductModify")
public class AdminProductModify extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AdminProductModify() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");
        Integer productId = Integer.parseInt(request.getParameter("productId"));
        ProductService productService = new ProductServiceImpl();
        CategoryService categoryService = new CategoryServiceImpl();
        try {
            ProductAndOption pao = productService.getProductAndOption(productId);
            System.out.println(pao);
            int subCategoryId = pao.getProduct().getSubCategoryId();
            SubCategory subCategory = categoryService.selectSubCategoryById(subCategoryId); // ✅ 수정
            int categoryId = subCategory.getCategoryId();

            List<Category> categoryList = categoryService.selectCategoryList();
            List<SubCategory> subCategoryList = categoryService.selectSubCategoriesByCategoryId(categoryId); // ✅ 여기 타입도 정확히

            request.setAttribute("categoryList", categoryList);
            request.setAttribute("subCategoryList", subCategoryList);
            request.setAttribute("pao", pao);
            request.getRequestDispatcher("admin/adminProductModify.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }


	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		try {
	    	ProductService service = new ProductServiceImpl();
	    	Integer productId = service.modifyProduct(request);
	    	request.setAttribute("productId", productId);
	    	request.getRequestDispatcher("/adminProductSearch").forward(request, response);

			
		} catch(Exception e) {
			e.printStackTrace();
		}
	}

}
