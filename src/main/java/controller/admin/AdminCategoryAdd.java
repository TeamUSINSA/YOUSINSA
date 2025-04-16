package controller.admin;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dto.admin.Category;
import service.admin.CategoryService;
import service.admin.CategoryServiceImpl;

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

            service.insertCategory(category); // useGeneratedKeys로 categoryId가 자동 주입됨

            int id = category.getCategoryId(); // 여기서 확인 가능
            response.getWriter().write("success," + id + "," + name);

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().write("fail");
        }
    }
}
