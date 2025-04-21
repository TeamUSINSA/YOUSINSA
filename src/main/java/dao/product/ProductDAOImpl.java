package dao.product;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import dto.product.Product;
import utils.MybatisSqlSessionFactory;

public class ProductDAOImpl implements ProductDAO{
	
	private SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();

    @Override
    public List<Product> selectProductsByType(String type) throws Exception {
        return sqlSession.selectList("mapper.product.selectProductsByType", type);
    }

    @Override
    public List<Product> selectRandomProductsByType(String type) throws Exception {
        return sqlSession.selectList("mapper.product.selectRandomProductsByType", type);
    }
    

    @Override
    public List<Product> selectProductsBySubCategory(int subCategoryId) throws Exception{
        return sqlSession.selectList("mapper.product.selectProductsBySubCategory", subCategoryId);
    }

    @Override
    public List<Product> selectProductsByCategory(int categoryId) throws Exception{
        return sqlSession.selectList("mapper.product.selectProductsByCategory", categoryId);
    }

}
