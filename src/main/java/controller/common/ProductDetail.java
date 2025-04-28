package controller.common;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

// OrderItem DTO: productId, color, size, quantity 필드가 있다고 가정
import dto.order.OrderItem;
import dto.product.Product;
import dto.product.ProductStock;
import dto.user.Inquiry;
import dto.user.Review;
import service.product.ProductDetailService;
import service.product.ProductDetailServiceImpl;
import service.user.InquiryService;
import service.user.InquiryServiceImpl;
import service.user.LikeService;
import service.user.LikeServiceImpl;

@WebServlet("/productDetail")
public class ProductDetail extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private ProductDetailService productService = new ProductDetailServiceImpl();
    private LikeService likeService = new LikeServiceImpl();
    private InquiryService inquiryService     = new InquiryServiceImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int productId = Integer.parseInt(request.getParameter("productId"));

            Product product                = productService.getProduct(productId);
            List<ProductStock> stockList   = productService.getProductStockList(productId);
            int likeCount                  = productService.getLikeCount(productId);
            double avgRating               = productService.getAvgRating(productId);
            List<Review> reviewList        = productService.getReviews(productId);

            // ↓ 기존 productService.getInquiries → inquiryService.getByProductId 로 변경
            List<Inquiry> inquiryList      = inquiryService.getByProductId(productId);

            HttpSession session = request.getSession(false);
            String userId = (session != null) ? (String) session.getAttribute("userId") : null;

            boolean likedByUser = false;
            if (userId != null) {
                likedByUser = likeService.existsLike(userId, productId);
            }

            request.setAttribute("product",       product);
            request.setAttribute("stockList",     stockList);
            request.setAttribute("likeCount",     likeCount);
            request.setAttribute("avgRating",     avgRating);
            request.setAttribute("reviewList",    reviewList);
            request.setAttribute("inquiryList",   inquiryList);
            request.setAttribute("likedByUser",   likedByUser);

            request.getRequestDispatcher("/common/productDetail.jsp")
                   .forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("err", "상품 상세 정보를 불러오는 중 오류 발생");
            request.getRequestDispatcher("/error.jsp")
                   .forward(request, response);
        }
    }
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession(false);
        String userId = (session != null) ? (String) session.getAttribute("userId") : null;
        if (userId == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        try {
            int productId = Integer.parseInt(request.getParameter("productId"));
            String[] colors    = request.getParameterValues("color");
            String[] sizes     = request.getParameterValues("size");
            String[] quantities= request.getParameterValues("quantity");

            List<OrderItem> orderList = new ArrayList<>();
            if (colors != null) {
                for (int i = 0; i < colors.length; i++) {
                    OrderItem item = new OrderItem();
                    item.setProductId(productId);
                    item.setColor(colors[i]);
                    item.setSize(sizes[i]);
                    item.setQuantity(Integer.parseInt(quantities[i]));
                    orderList.add(item);
                }
            }

            request.setAttribute("orderList", orderList);
            request.getRequestDispatcher("/order")
                   .forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("err", "주문 데이터 처리 중 오류 발생");
            request.getRequestDispatcher("/error.jsp")
                   .forward(request, response);
        }
    }
}
