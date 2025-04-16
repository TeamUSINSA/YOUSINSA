package controller.admin;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dto.admin.Category;
import dto.admin.SubCategory;
import service.admin.CategoryService;
import service.admin.CategoryServiceImpl;

@WebServlet("/adminCategory")
public class AdminCategoryList extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public AdminCategoryList() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		CategoryService service = new CategoryServiceImpl();

		try {
			List<Category> categoryList = service.selectCategoryList();
			List<SubCategory> subCategoryList = service.selectSubCategoryList();
			

			request.setAttribute("categoryList", categoryList);
			request.setAttribute("subCategoryList", subCategoryList);

			request.getRequestDispatcher("admin/adminCategory.jsp").forward(request, response);

		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("err", "카테고리 불러오기 실패");
			request.getRequestDispatcher("admin/adminCategory.jsp").forward(request, response);
		}
	}
}
