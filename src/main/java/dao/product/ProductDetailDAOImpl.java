package dao.product;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import dto.product.Product;
import dto.product.ProductStock;
import dto.user.Review;
import dto.user.Inquiry;
import utils.MybatisSqlSessionFactory;

public class ProductDetailDAOImpl implements ProductDetailDAO {

    private SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession(true);
    private final String namespace = "mapper.productdetail";

    @Override
    public Product selectProductById(int productId) throws Exception{
        return sqlSession.selectOne(namespace + ".selectProductById", productId);
    }

    @Override
    public List<ProductStock> selectProductStockByProductId(int productId) throws Exception{
        return sqlSession.selectList(namespace + ".selectProductStockByProductId", productId);
    }

    @Override
    public int countLikesByProductId(int productId) throws Exception{
        return sqlSession.selectOne(namespace + ".countLikesByProductId", productId);
    }

    @Override
    public double getAvgRatingByProductId(int productId) throws Exception{
        return sqlSession.selectOne(namespace + ".getAvgRatingByProductId", productId);
    }

    @Override
    public List<Review> selectReviewsByProductId(int productId) throws Exception{
        return sqlSession.selectList(namespace + ".selectReviewsByProductId", productId);
    }

    @Override
    public List<Inquiry> selectInquiriesByProductId(int productId) throws Exception{
        return sqlSession.selectList(namespace + ".selectInquiriesByProductId", productId);
    }
}
