package dao.product;

import java.util.List;
import dto.product.Product;
import dto.product.ProductStock;
import dto.user.Review;
import dto.user.Inquiry;

public interface ProductDetailDAO {
    Product selectProductById(int productId) throws Exception;
    List<ProductStock> selectProductStockByProductId(int productId) throws Exception;
    int countLikesByProductId(int productId) throws Exception;
    double getAvgRatingByProductId(int productId) throws Exception;
    List<Review> selectReviewsByProductId(int productId) throws Exception;
    List<Inquiry> selectInquiriesByProductId(int productId) throws Exception;
}
