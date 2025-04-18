package controller.common;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import dto.product.Category;
import service.product.CategoryService;
import service.product.CategoryServiceImpl;

@WebServlet("/header")
public class Header extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public Header() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		CategoryService service = new CategoryServiceImpl();
		List<Category> categoryList = service.selectCategoryWithSubList(); // 대분류 + 소분류 포함

		request.setAttribute("categoryList", categoryList);


		request.getRequestDispatcher("/common/header.jsp").include(request, response); 
	}
}
