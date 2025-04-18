package controller.common;

import dto.product.Product;

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
import service.product.ProductService;
import service.product.ProductServiceImpl;

@WebServlet("/productList")
public class ProductList extends HttpServlet {

    private CategoryService categoryService = new CategoryServiceImpl();
    private ProductService productService = new ProductServiceImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String categoryIdParam = request.getParameter("categoryId");
        String subCategoryIdParam = request.getParameter("subCategoryId");

        List<Category> categoryList = categoryService.selectCategoryList();
        List<SubCategory> subCategoryList = categoryService.selectSubCategoryList();
        List<Product> productList = null;

        try {
            if (subCategoryIdParam != null) {
                int subCategoryId = Integer.parseInt(subCategoryIdParam);
                productList = productService.getProductsBySubCategory(subCategoryId);
            } else if (categoryIdParam != null) {
                int categoryId = Integer.parseInt(categoryIdParam);
                productList = productService.getProductsByCategory(categoryId);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        System.out.println("productList size = " + (productList != null ? productList.size() : "null"));

        request.setAttribute("categoryList", categoryList);
        request.setAttribute("subCategoryList", subCategoryList);
        request.setAttribute("productList", productList);
        request.setAttribute("categoryId", categoryIdParam);
        request.setAttribute("subCategoryId", subCategoryIdParam);

        request.getRequestDispatcher("/common/product.jsp").forward(request, response);
    }
}
