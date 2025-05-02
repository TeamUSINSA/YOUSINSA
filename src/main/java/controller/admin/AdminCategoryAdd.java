package controller.admin;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dto.product.Category;
import dto.product.SubCategory;
import service.product.CategoryService;
import service.product.CategoryServiceImpl;

@WebServlet("/adminCategoryAdd")
public class AdminCategoryAdd extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public AdminCategoryAdd() {
		super();
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		request.setCharacterEncoding("utf-8");

		try {

			CategoryService service = new CategoryServiceImpl();
			request.setCharacterEncoding("UTF-8");
			response.setContentType("text/plain; charset=UTF-8");
			
			
			// ✅ 카테고리 목록 추가
            dao.product.CategoryDAO categoryDAO = new dao.product.CategoryDAOImpl();
            List<dto.product.Category> categoryList = categoryDAO.selectAllCategories(); // 이름은 너가 실제 쓰는 걸로 맞춰줘
            request.setAttribute("categoryList", categoryList);

			String name = request.getParameter("categoryName");

			Category category = new Category();
			category.setCategoryName(name);

			service.insertCategory(category);

			int id = category.getCategoryId();
			response.getWriter().write("success," + id + "," + name);

		} catch (Exception e) {
			e.printStackTrace();
			response.getWriter().write("fail");
		}
	}
}
