package dao.product;

import java.util.List;
import java.util.Map;

import dto.product.Product;

public interface ProductDAO {

	List<Product> selectProductsByType(String type) throws Exception;

	List<Product> selectRandomProductsByType(String type) throws Exception;

	List<Product> selectProductsBySubCategory(int subCategoryId) throws Exception;

	List<Product> selectProductsByCategory(int categoryId) throws Exception;

	Product selectProductById(int productId) throws Exception;

	int insertProduct(Product product) throws Exception;

	List<Product> getTop10Products(String start, String end) throws Exception;

	int getTotalSales(String start, String end, String mainCategory, String subCategory) throws Exception;

	Map<String, List<Integer>> getSalesChartData(String start, String end) throws Exception;
	
	List<String> getAllMainCategories() throws Exception;
    List<String> getAllSubCategories() throws Exception;

}
