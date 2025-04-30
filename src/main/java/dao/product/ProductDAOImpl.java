package dao.product;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import dto.product.Product;
import utils.MybatisSqlSessionFactory;

public class ProductDAOImpl implements ProductDAO {

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
	public List<Product> selectProductsBySubCategory(int subCategoryId) throws Exception {
		return sqlSession.selectList("mapper.product.selectProductsBySubCategory", subCategoryId);
	}


	@Override
	public List<Product> selectProductsByCategory(int categoryId) throws Exception {
		return sqlSession.selectList("mapper.product.selectProductsByCategory", categoryId);
	}

    
    @Override
    public Product selectById(int productId) throws Exception {
        return sqlSession.selectOne("mapper.orderproduct.selectProductById", productId);
    }


	@Override
	public Product selectProductById(int productId) throws Exception {
		return sqlSession.selectOne("mapper.product.selectProductById", productId);
	}

	@Override
	public int insertProduct(Product product) throws Exception {
		int result = sqlSession.insert("mapper.admin.product.insertProduct", product);
		sqlSession.commit(); // DML 쿼리 실행 후 반드시 커밋!
		return result;
	}

	@Override
	public List<Product> getTop10Products(String start, String end) throws Exception {
		Map<String, Object> param = new HashMap<>();
		param.put("start", start);
		param.put("end", end);
		return sqlSession.selectList("mapper.product.getTop10Products", param);
	}

	@Override
	public int getTotalSales(String start, String end, String mainCategory, String subCategory) throws Exception {
		Map<String, Object> param = new HashMap<>();
		param.put("start", start);
		param.put("end", end);
		param.put("mainCategory", mainCategory);
		param.put("subCategory", subCategory);
		return sqlSession.selectOne("mapper.product.getTotalSales", param);
	}

	public List<Map<String, Object>> getSalesChartData(String start, String end) throws Exception {
	    Map<String, String> param = new HashMap<>();
	    param.put("start", start);
	    param.put("end", end);
	    return sqlSession.selectList("mapper.product.getSalesChartData", param);
	}
	@Override
	public List<String> getAllMainCategories() throws Exception {
	    return sqlSession.selectList("mapper.product.getAllMainCategories");
	}

	@Override
	public List<String> getAllSubCategories() throws Exception {
	    return sqlSession.selectList("mapper.product.getAllSubCategories");
	}

	// 필요하다면 close() 메서드도 추가
	public void closeSession() {
		if (sqlSession != null)
			sqlSession.close();
	}
	
	 @Override
	    public List<Product> selectLatestProducts(int count) throws Exception {
	        return sqlSession.selectList("mapper.product.selectLatestProducts", count);
	    }
	 
	 @Override
	    public List<Product> findByName(String name) throws Exception {
	        return sqlSession.selectList("mapper.product.findByName", name);
	    }
	 
	 @Override
	 public List<Product> findByNamePaged(String keyword, int offset, int limit) throws Exception {
	     Map<String, Object> param = new HashMap<>();
	     param.put("keyword", keyword);
	     param.put("offset",  offset);
	     param.put("limit",   limit);
	     return sqlSession.selectList("mapper.product.findByNamePaged", param);
	 }

	 @Override
	 public int countByName(String keyword) throws Exception {
	     return sqlSession.selectOne("mapper.product.countByName", keyword);
	 }

	 /** 서브카테고리 페이징 */
	 @Override
	 public List<Product> selectProductsBySubCategoryPaged(int subCategoryId, int offset, int limit) throws Exception {
	     Map<String, Object> param = new HashMap<>();
	     param.put("subCategoryId", subCategoryId);
	     param.put("offset",        offset);
	     param.put("limit",         limit);
	     return sqlSession.selectList("mapper.product.selectProductsBySubCategoryPaged", param);
	 }

	 @Override
	 public int countBySubCategory(int subCategoryId) throws Exception {
	     return sqlSession.selectOne("mapper.product.countBySubCategory", subCategoryId);
	 }

	 /** 카테고리(대분류) 페이징 */
	 @Override
	 public List<Product> selectProductsByCategoryPaged(int categoryId, int offset, int limit) throws Exception {
	     Map<String, Object> param = new HashMap<>();
	     param.put("categoryId", categoryId);
	     param.put("offset",     offset);
	     param.put("limit",      limit);
	     return sqlSession.selectList("mapper.product.selectProductsByCategoryPaged", param);
	 }

	 @Override
	 public int countByCategory(int categoryId) throws Exception {
	     return sqlSession.selectOne("mapper.product.countByCategory", categoryId);
	 }
}
