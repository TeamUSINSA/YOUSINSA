package controller.admin;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import service.product.CategoryService;
import service.product.CategoryServiceImpl;

@WebServlet("/adminSubcategoryDelete")
public class AdminSubcategoryDelete extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public AdminSubcategoryDelete() {
        super();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/plain; charset=UTF-8");

        try {
        	 CategoryService service = new CategoryServiceImpl();
        	 
            int subCategoryId = Integer.parseInt(request.getParameter("subCategoryId"));
            service.deleteSubCategoryById(subCategoryId);
            response.getWriter().write("success");
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().write("fail");
        }
    }
}
