package controller.common;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dto.product.Product;
import dto.product.ProductStock;
import dto.user.Inquiry;
import dto.user.Review;
import service.product.ProductDetailService;
import service.product.ProductDetailServiceImpl;
// ★ LikeService import 추가
import service.user.LikeService;
import service.user.LikeServiceImpl;

@WebServlet("/productDetail")
public class ProductDetail extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // 기존 서비스
    private ProductDetailService productService = new ProductDetailServiceImpl();
    // 좋아요 토글/조회용 서비스
    private LikeService likeService = new LikeServiceImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            int productId = Integer.parseInt(request.getParameter("productId"));

            // 1) 상품 기본 정보
            Product product = productService.getProduct(productId);
            List<ProductStock> stockList = productService.getProductStockList(productId);
            int likeCount = productService.getLikeCount(productId);
            double avgRating = productService.getAvgRating(productId);
            List<Review> reviewList = productService.getReviews(productId);
            List<Inquiry> inquiryList = productService.getInquiries(productId);

            // 2) 로그인한 유저 ID 가져오기
            HttpSession session = request.getSession(false);
            String userId = (session != null) ? (String) session.getAttribute("userId") : null;

            // 3) 내가 좋아요 눌렀는지 여부
            boolean likedByUser = false;
            if (userId != null) {
                likedByUser = likeService.existsLike(userId, productId);
            }

            // 4) JSP로 속성 전달
            request.setAttribute("product", product);
            request.setAttribute("stockList", stockList);
            request.setAttribute("likeCount", likeCount);
            request.setAttribute("avgRating", avgRating);
            request.setAttribute("reviewList", reviewList);
            request.setAttribute("inquiryList", inquiryList);

            request.setAttribute("likedByUser", likedByUser);

            // 5) 포워드
            request.getRequestDispatcher("/common/productDetail.jsp")
                   .forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("err", "상품 상세 정보를 불러오는 중 오류 발생");
            request.getRequestDispatcher("/error.jsp")
                   .forward(request, response);
        }
    }
}
