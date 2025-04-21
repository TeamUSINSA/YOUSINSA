package dao.product;

import java.util.List;

import dto.product.Product;

public interface ProductDAO {

	List<Product> selectProductsByType(String type) throws Exception;

	List<Product> selectRandomProductsByType(String type) throws Exception;

	List<Product> selectProductsBySubCategory(int subCategoryId)throws Exception;

	List<Product> selectProductsByCategory(int categoryId) throws Exception;

}
