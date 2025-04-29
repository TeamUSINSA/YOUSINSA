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

        try {
            Integer productId = Integer.parseInt(request.getParameter("productId"));
            CategoryService categoryService = new CategoryServiceImpl();
            ProductService productService = new ProductServiceImpl();

            ProductAndOption pao = productService.getProductAndOption(productId);

            if (pao == null || pao.getProduct() == null) {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "상품을 찾을 수 없습니다.");
                return;
            }

            Integer subCategoryId = pao.getProduct().getSubCategoryId();
            List<Category> categoryList = categoryService.selectCategoryList();
            List<SubCategory> subCategoryList = (subCategoryId != null)
                    ? categoryService.selectSubCategoriesByCategoryId(subCategoryId)
                    : null;

            request.setAttribute("categoryList", categoryList);
            request.setAttribute("subCategoryList", subCategoryList);
            request.setAttribute("pao", pao);
            request.getRequestDispatcher("admin/adminProductModify.jsp").forward(request, response);

        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "상품 ID가 잘못되었습니다.");
        } catch (Exception e) {
            e.printStackTrace();
            throw new ServletException(e);
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
	    	request.getRequestDispatcher("productDetail").forward(request, response);
			
		} catch(Exception e) {
			e.printStackTrace();
		}
	}

}
