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

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");
        CategoryService categoryService = new CategoryServiceImpl();
        ProductService  productService  = new ProductServiceImpl();
        OrderItemService orderItemService = new OrderItemServiceImpl();

        try {
            // ■ 공통 분류 데이터
            List<Category>    categoryList    = categoryService.selectCategoryList();
            List<SubCategory> subCategoryList = categoryService.selectSubCategoryList();
            req.setAttribute("categoryList",    categoryList);
            req.setAttribute("subCategoryList", subCategoryList);

            // ■ 페이징 파라미터
            final int size = 40;
            int page = 1;
            try {
                page = Integer.parseInt(req.getParameter("page"));
            } catch (Exception ignored) {}
            int total = 0;

            // ■ 조건 파라미터
            String name  = req.getParameter("name");
            String pop   = req.getParameter("popular");
            String news  = req.getParameter("new");
            String subId = req.getParameter("subCategoryId");
            String catId = req.getParameter("categoryId");

            List<Product> productList;

            if (name != null && !name.isBlank()) { // ① 이름 검색
                productList = productService.findByNamePaged(name.trim(), page, size);
                total       = productService.countByName(name.trim());

            } else if (subId != null) { // ② 서브카테고리
                int sid      = Integer.parseInt(subId);
                productList  = productService.getProductsBySubCategoryPaged(sid, page, size);
                total        = productService.countBySubCategory(sid);

            } else if (catId != null) { // ③ 카테고리
                int cid      = Integer.parseInt(catId);
                productList  = productService.getProductsByCategoryPaged(cid, page, size);
                total        = productService.countByCategory(cid);

            } else if (pop != null) { // ④ 베스트
                productList = orderItemService.getTopSellingProducts(size);
                total       = size;   // 고정 40

            } else if (news != null) { // ⑤ 신상품
                productList = productService.getLatestProducts(size);
                total       = size;   // 고정 40

            } else { // ⑥ 조건 없음
                productList = List.of();
            }

            int last = (int)Math.ceil(total / (double)size);

            // ★ 10개씩 끊는 페이징 처리 추가
            int pageBlockSize = 10;
            int startPage = ((page - 1) / pageBlockSize) * pageBlockSize + 1;
            int endPage = startPage + pageBlockSize - 1;
            if (endPage > last) endPage = last;

            // ■ 뷰 전달
            req.setAttribute("productList", productList);
            req.setAttribute("page", page);
            req.setAttribute("last", last);
            req.setAttribute("startPage", startPage);
            req.setAttribute("endPage", endPage);
            req.setAttribute("pageBlockSize", pageBlockSize);
            req.setAttribute("selectedCategoryId",
                             catId == null ? null : Integer.valueOf(catId));

            req.getRequestDispatcher("/common/product.jsp").forward(req, resp);

        } catch (Exception e) {
            e.printStackTrace();
            resp.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR,
                           "상품 목록 로딩 실패");
        }
    }
}
