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

@WebServlet("/adminCategory")
public class AdminCategoryList extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public AdminCategoryList() {
		super();
	}

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");

		try {
			CategoryService service = new CategoryServiceImpl();
			// 카테고리 리스트 조회
			List<Category> categoryList = service.selectCategoryList();
			List<SubCategory> subCategoryList = service.selectSubCategoryList();

			// request 객체에 담기
			request.setAttribute("categoryList", categoryList);
			request.setAttribute("subCategoryList", subCategoryList);

			// JSP로 포워딩
			request.getRequestDispatcher("/admin/adminCategory.jsp").forward(request, response);

		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("err", "카테고리 목록 불러오기 실패");
			request.getRequestDispatcher("/admin/adminCategory.jsp").forward(request, response);
		}
	}
}
