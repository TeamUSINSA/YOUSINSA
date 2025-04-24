package controller.admin;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dto.product.SubCategory;
import service.product.CategoryService;
import service.product.CategoryServiceImpl;

@WebServlet("/adminSubcategoryAdd")
public class AdminSubcategoryAdd extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public AdminSubcategoryAdd() {
        super();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/plain; charset=UTF-8");


        try {
        	CategoryService service = new CategoryServiceImpl();
            String subCategoryName = request.getParameter("subCategoryName");
            int categoryId = Integer.parseInt(request.getParameter("categoryId"));

            SubCategory subCategory = new SubCategory();
            subCategory.setSubCategoryName(subCategoryName);
            subCategory.setCategoryId(categoryId);

            service.insertSubCategory(subCategory); // 이 시점에 subCategoryId 자동 채워짐

            int subCategoryId = subCategory.getSubCategoryId(); // MyBatis useGeneratedKeys로 자동 주입

            response.getWriter().write("success," + subCategoryId + "," + subCategoryName);
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().write("fail");
        }
    }
}
