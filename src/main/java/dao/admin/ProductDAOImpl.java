package dao.admin;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import dto.product.Product;
import dto.product.ProductStock;
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
        sqlSession.update("mapper.admin.product.updateProduct", product); // 🔥 admin 추가!
        sqlSession.commit();
    }

    @Override
    public void deleteProductById(int productId) throws Exception {
        sqlSession.delete("mapper.product.deleteProductById", productId);
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
	public int getTotalSales(String start, String end, String mainCategory, String subCategory) throws Exception {
		Map<String, Object> param = new HashMap<>();
		param.put("start", start);
		param.put("end", end);
		param.put("mainCategory", mainCategory);
		param.put("subCategory", subCategory);
		return sqlSession.selectOne("mapper.product.getTotalSales", param);
	}

	@Override
	public Map<String, List<Integer>> getSalesChartData(String start, String end) throws Exception {
		// 차트용 쿼리가 만들어졌다는 가정
		// label(기간명 등)을 key로, 판매량 리스트를 value로 매핑한다고 가정
		return sqlSession.selectMap("mapper.product.getSalesChartData", null, "label");
	}
	
	@Override
	public List<String> getAllMainCategories() throws Exception {
	    return sqlSession.selectList("mapper.product.getAllMainCategories");
	}

	@Override
	public List<String> getAllSubCategories() throws Exception {
	    return sqlSession.selectList("mapper.product.getAllSubCategories");
	}
}
