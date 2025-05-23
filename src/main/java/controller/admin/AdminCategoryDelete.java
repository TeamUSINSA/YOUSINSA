package controller.admin;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import service.product.CategoryService;
import service.product.CategoryServiceImpl;

@WebServlet("/adminCategoryDelete")
public class AdminCategoryDelete extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public AdminCategoryDelete() {
		super();
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/plain; charset=UTF-8");

		try {
			CategoryService service = new CategoryServiceImpl();

			int id = Integer.parseInt(request.getParameter("categoryId"));

			// ✅ ID 기준으로 삭제
			service.deleteCategoryById(id);

			response.getWriter().write("success");
		} catch (Exception e) {
			e.printStackTrace();
			response.getWriter().write("fail");
		}
	}
}
