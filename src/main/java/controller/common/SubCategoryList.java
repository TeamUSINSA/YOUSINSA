package controller.common;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import dto.product.SubCategory;
import service.product.CategoryService;
import service.product.CategoryServiceImpl;

/**
 * Servlet implementation class SubCategoryList
 */
@WebServlet("/subCategoryList")
public class SubCategoryList extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SubCategoryList() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setCharacterEncoding("utf-8");
		Integer categoryId = Integer.parseInt(request.getParameter("categoryId"));
		try {
			CategoryService service = new CategoryServiceImpl();
			List<SubCategory> subCategoryList = service.selectSubCategoriesByCategoryId(categoryId);
			String json = new Gson().toJson(subCategoryList);
			response.getWriter().write(json);
		} catch(Exception e) {
			e.printStackTrace();
			response.getWriter().write("error");
		}
	}

}
