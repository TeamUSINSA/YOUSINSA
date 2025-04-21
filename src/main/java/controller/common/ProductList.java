package controller.common;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dto.product.Category;
import dto.product.Product;
import dto.product.SubCategory;
import service.product.CategoryService;
import service.product.CategoryServiceImpl;
import service.product.ProductService;
import service.product.ProductServiceImpl;

@WebServlet("/productList")
public class ProductList extends HttpServlet {

    private CategoryService categoryService;
    private ProductService productService = new ProductServiceImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            categoryService = new CategoryServiceImpl();

            String categoryIdParam = request.getParameter("categoryId");
            String subCategoryIdParam = request.getParameter("subCategoryId");

            List<Category> categoryList = categoryService.selectCategoryList();
            List<SubCategory> subCategoryList = categoryService.selectSubCategoryList();
            List<Product> productList = null;

            if (subCategoryIdParam != null) {
                int subCategoryId = Integer.parseInt(subCategoryIdParam);
                productList = productService.getProductsBySubCategory(subCategoryId);
            } else if (categoryIdParam != null) {
                int categoryId = Integer.parseInt(categoryIdParam);
                productList = productService.getProductsByCategory(categoryId);
            }

            request.setAttribute("categoryList", categoryList);
            request.setAttribute("subCategoryList", subCategoryList);
            request.setAttribute("productList", productList);
            request.setAttribute("categoryId", categoryIdParam);
            request.setAttribute("subCategoryId", subCategoryIdParam);

            request.getRequestDispatcher("/common/product.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("err", "상품 목록 불러오는 중 오류 발생");
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        }
    }
}
