package controller.admin;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dto.product.Category;
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

        CategoryService service = new CategoryServiceImpl();

        try {
            request.setCharacterEncoding("UTF-8");
            response.setContentType("text/plain; charset=UTF-8");

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
