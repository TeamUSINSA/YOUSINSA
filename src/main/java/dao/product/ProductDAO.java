package dao.product;

import java.util.List;
import java.util.Map;

import dto.product.Product;

public interface ProductDAO {

	List<Product> selectProductsByType(String type) throws Exception;

	List<Product> selectRandomProductsByType(String type) throws Exception;

	List<Product> selectProductsBySubCategory(int subCategoryId) throws Exception;

	List<Product> selectProductsByCategory(int categoryId) throws Exception;

	Product selectById(int productId) throws Exception;

	Product selectProductById(int productId) throws Exception;

	int insertProduct(Product product) throws Exception;


	List<Product> getTop10Products(String start, String end) throws Exception;

	int getTotalSales(String start, String end, String mainCategory, String subCategory) throws Exception;

	List<Map<String, Object>> getSalesChartData(String start, String end) throws Exception;
	
	List<String> getAllMainCategories() throws Exception;
    List<String> getAllSubCategories() throws Exception;

	List<Product> selectLatestProducts(int count) throws Exception;

	List<Product> findByName(String name) throws Exception;

	List<Product> findByNamePaged(String keyword, int offset, int limit) throws Exception;

	int countByName(String keyword) throws Exception;

	/** 서브카테고리 페이징 */
	List<Product> selectProductsBySubCategoryPaged(int subCategoryId, int offset, int limit) throws Exception;

	int countBySubCategory(int subCategoryId) throws Exception;

	/** 카테고리(대분류) 페이징 */
	List<Product> selectProductsByCategoryPaged(int categoryId, int offset, int limit) throws Exception;

	int countByCategory(int categoryId) throws Exception;
    


}
