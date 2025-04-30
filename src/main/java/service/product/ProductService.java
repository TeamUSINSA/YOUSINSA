package service.product;

import java.util.List;

import dto.product.Product;

public interface ProductService {

	List<Product> getProductsByType(String type) throws Exception;

	List<Product> getRandomProductsByType(String type, int count) throws Exception;

	List<Product> getProductsBySubCategory(int subCategoryId) throws Exception;

	List<Product> getProductsByCategory(int categoryId) throws Exception;
	
	Product selectById(int productId) throws Exception;

	Product findProductById(int productId) throws Exception;

	List<Product> getLatestProducts(int count) throws Exception;

}
