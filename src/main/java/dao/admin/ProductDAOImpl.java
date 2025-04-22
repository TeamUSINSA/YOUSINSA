package dao.admin;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import dto.product.Product;
import utils.MybatisSqlSessionFactory;

public class ProductDAOImpl implements ProductDAO {

    private SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();

    @Override
    public void insertProduct(Product product) throws Exception {
    	sqlSession.insert("mapper.admin.product.insertProduct", product);
    	sqlSession.commit();
    }

    @Override
    public void updateProduct(Product product) throws Exception {
    	sqlSession.update("mapper.admin.product.updateProduct", product);
    	sqlSession.commit();
    }

    @Override
    public void deleteProductById(int productId) throws Exception {
    	sqlSession.delete("mapper.admin.product.deleteProductById", productId);
    	sqlSession.commit();
        }
    

    @Override
    public Product selectProductById(int productId) throws Exception {
    	return sqlSession.selectOne("mapper.admin.product.selectProductById", productId);
    }

    @Override
    public List<Product> selectProductList(String searchType, String keyword)throws Exception {
    	Map<String,String> param = new HashMap<>();
    	param.put("type", searchType);
    	param.put("keyword", keyword);
        return sqlSession.selectList("mapper.admin.product.selectProductList", param);
    }

    @Override
    public List<Product> selectProductsBySubCategoryId(int subCategoryId) throws Exception {
        return sqlSession.selectList("mmapper.admin.product.selectProductsBySubCategoryId", subCategoryId);
    }
}
