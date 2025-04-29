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
import service.order.OrderItemService;
import service.order.OrderItemServiceImpl;
import service.product.CategoryService;
import service.product.CategoryServiceImpl;
import service.product.ProductService;
import service.product.ProductServiceImpl;

@WebServlet("/productList")
public class ProductList extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // 필드에서 바로 초기화
    private CategoryService categoryService = new CategoryServiceImpl();
    private ProductService productService   = new ProductServiceImpl();
    private OrderItemService orderItemService = new OrderItemServiceImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // 1) 카테고리 리스트 무조건 가져오기
            List<Category> categoryList       = categoryService.selectCategoryList();
            List<SubCategory> subCategoryList = categoryService.selectSubCategoryList();
            request.setAttribute("categoryList",     categoryList);
            request.setAttribute("subCategoryList",  subCategoryList);

            // 2) 파라미터에 따라 productList 결정
            String popular = request.getParameter("popular");
            String news    = request.getParameter("new");
            String subId   = request.getParameter("subCategoryId");
            String catId   = request.getParameter("categoryId");

            List<Product> productList = null;
            if (popular != null) {
                productList = orderItemService.getTopSellingProducts(40);
            } else if (news != null) {
                productList = productService.getLatestProducts(40);
            } else if (subId != null) {
                productList = productService.getProductsBySubCategory(Integer.parseInt(subId));
            } else if (catId != null) {
                productList = productService.getProductsByCategory(Integer.parseInt(catId));
            }
            
            Integer selectedCategoryId = null;
            if (request.getParameter("categoryId") != null) {
                selectedCategoryId = Integer.valueOf(request.getParameter("categoryId"));
            }
            request.setAttribute("selectedCategoryId", selectedCategoryId);


            request.setAttribute("productList", productList);
            request.setAttribute("subCategoryList", subCategoryList);
            request.getRequestDispatcher("/common/product.jsp")
                   .forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "상품 목록 로딩 실패");
        }
    }
}

