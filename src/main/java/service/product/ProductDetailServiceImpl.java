package service.product;

import java.util.List;

import dao.product.ProductDetailDAO;
import dao.product.ProductDetailDAOImpl;
import dto.product.Product;
import dto.product.ProductStock;
import dto.user.Review;
import dto.user.Inquiry;

public class ProductDetailServiceImpl implements ProductDetailService {

    private ProductDetailDAO dao = new ProductDetailDAOImpl();

    @Override
    public Product getProduct(int productId) throws Exception{
        return dao.selectProductById(productId);
    }

    @Override
    public List<ProductStock> getProductStockList(int productId) throws Exception{
        return dao.selectProductStockByProductId(productId);
    }

    @Override
    public int getLikeCount(int productId) throws Exception{
        return dao.countLikesByProductId(productId);
    }

    @Override
    public double getAvgRating(int productId) throws Exception{
        return dao.getAvgRatingByProductId(productId);
    }

    @Override
    public List<Review> getReviews(int productId) throws Exception{
        return dao.selectReviewsByProductId(productId);
    }

    @Override
    public List<Inquiry> getInquiries(int productId) throws Exception{
        return dao.selectInquiriesByProductId(productId);
    }
}
