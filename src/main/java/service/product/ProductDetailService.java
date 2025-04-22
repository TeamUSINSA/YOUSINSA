package service.product;

import java.util.List;

import dto.product.Product;
import dto.product.ProductStock;
import dto.user.Review;
import dto.user.Inquiry;

public interface ProductDetailService {
    Product getProduct(int productId) throws Exception;
    List<ProductStock> getProductStockList(int productId)throws Exception;
    int getLikeCount(int productId)throws Exception;
    double getAvgRating(int productId) throws Exception;
    List<Review> getReviews(int productId) throws Exception;
    List<Inquiry> getInquiries(int productId)throws Exception;
}
