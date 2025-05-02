package dao.admin;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import dto.product.Product;
import dto.product.ProductQuantity;
import dto.product.ProductStock;
import utils.MybatisSqlSessionFactory;

public class AdminProductDAOImpl implements AdminProductDAO {

    private SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();

    @Override
    public void insertProduct(Product product) throws Exception {
        sqlSession.insert("mapper.admin.product.insertProduct", product);
        sqlSession.commit();
    }


    @Override
    public void updateProduct(Product product) throws Exception {
        sqlSession.update("mapper.admin.product.updateProduct", product); // admin 추가
        sqlSession.commit();
    }

    @Override
    public void deleteProductById(int productId) throws Exception {
        sqlSession.delete("mapper.admin.product.deleteProductById", productId);
        sqlSession.commit();
    }

    @Override
    public Product selectProductById(int productId) throws Exception {
        return sqlSession.selectOne("mapper.product.selectProductById", productId);
    }

    @Override
    public List<Product> selectProductList(String searchType, String keyword) throws Exception {
        Map<String, String> param = new HashMap<>();
        param.put("type", searchType);
        param.put("keyword", keyword);
        return sqlSession.selectList("mapper.product.selectProductList", param);
    }

    @Override
    public List<Product> selectProductsBySubCategoryId(int subCategoryId) throws Exception {
        return sqlSession.selectList("mapper.product.selectProductsBySubCategoryId", subCategoryId);
    }

	@Override
	public void insertProductStockList(List<ProductStock> productStockList) throws Exception {
		sqlSession.insert("mapper.admin.product.insertStock", productStockList);
		sqlSession.commit();
	}

	@Override
	public List<ProductStock> selectStockByProductId(Integer productId) throws Exception {
		return sqlSession.selectList("mapper.admin.product.selectStockByProductId", productId);
	}
	
	@Override
	public List<String> selectStockColorByProductId(Integer productId) throws Exception {
		return sqlSession.selectList("mapper.admin.product.selectStockColorByProductId", productId);
	}

	@Override
	public List<ProductQuantity> selectStockByColor(Integer productId, String color) throws Exception {
		Map<String,Object> param = new HashMap<>();
		param.put("productId", productId);
		param.put("color", color);
		
		return sqlSession.selectList("mapper.admin.product.selectStockByColor", param);
	}

	@Override
	public void deleteStockByProductId(Integer productId) throws Exception {
		sqlSession.delete("mapper.admin.product.deleteStockByProductId", productId);
		sqlSession.commit();
	}	
	
	@Override
    public void deleteStockByProductId(Integer productId, SqlSession session) throws Exception {
        session.delete("mapper.admin.product.deleteStockByProductId", productId);
        session.commit();
    }

    @Override
    public void updateProduct(Product product, SqlSession session) throws Exception {
        session.update("mapper.admin.product.updateProduct", product);
        session.commit();
    }

    @Override
    public void insertProductStockList(List<ProductStock> stockList, SqlSession session) throws Exception {
        if (stockList != null && !stockList.isEmpty()) {
            session.insert("mapper.admin.product.insertStockList", stockList);
            session.commit();
        }
    }
    
    @Override
    public int countStockByProductIdColorSize(int productId, String color, String size, SqlSession session) throws Exception {
        Map<String, Object> paramMap = new HashMap<>();
        paramMap.put("productId", productId);
        paramMap.put("color", color);
        paramMap.put("size", size);
        return session.selectOne("mapper.admin.product.countStockByProductIdColorSize", paramMap);
    }

    @Override
    public void updateStockQuantity(ProductStock stock, SqlSession session) throws Exception {
        session.update("mapper.admin.product.updateStockQuantity", stock);
        session.commit();
    }

    @Override
    public void insertProductStock(ProductStock stock, SqlSession session) throws Exception {
        session.insert("mapper.admin.product.insertProductStock", stock);
        session.commit();
    }
    
    @Override
    public List<Product> selectProductListWithPaging(String searchType, String keyword, int offset, int limit) throws Exception {
        Map<String, Object> param = new HashMap<>();
        param.put("type", searchType);
        param.put("keyword", keyword);
        param.put("offset", offset);
        param.put("limit", limit);
        return sqlSession.selectList("mapper.admin.product.selectProductListWithPaging", param);
    }
    
    @Override
    public int countProductList(String searchType, String keyword) throws Exception {
        Map<String, Object> param = new HashMap<>();
        param.put("type", searchType);
        param.put("keyword", keyword);
        return sqlSession.selectOne("mapper.admin.product.countProductList", param);
    }
    
    
}
