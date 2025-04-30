package service.product;

import java.util.Collections;
import java.util.List;

import dao.product.ProductDAO;
import dao.product.ProductDAOImpl;
import dto.product.Product;

public class ProductServiceImpl implements ProductService {

	private ProductDAO productDAO = new ProductDAOImpl();

	@Override
	public List<Product> getProductsByType(String type) throws Exception {
		return productDAO.selectProductsByType(type);
	}

	@Override
	public List<Product> getRandomProductsByType(String type, int count) throws Exception {
		List<Product> all = productDAO.selectProductsByType(type);
		Collections.shuffle(all);
		return all.subList(0, Math.min(count, all.size()));
	}

	@Override
	public List<Product> getProductsBySubCategory(int subCategoryId) throws Exception {
		return productDAO.selectProductsBySubCategory(subCategoryId);
	}

	@Override
	public List<Product> getProductsByCategory(int categoryId) throws Exception {
		return productDAO.selectProductsByCategory(categoryId);
	}

	@Override
	public Product selectById(int productId) throws Exception {
		return productDAO.selectById(productId);
	}

	@Override
	public Product findProductById(int productId) throws Exception {
		// TODO Auto-generated method stub
		return selectById(productId);
	}

	@Override
	public List<Product> getLatestProducts(int count) throws Exception {
		return productDAO.selectLatestProducts(count);
	}

	@Override
	public List<Product> findByName(String name) throws Exception {
		return productDAO.findByName(name);
	}

	private int offset(int page, int size) { // 공통 오프셋 계산
		return (page - 1) * size;
	}

	/* 1) 이름 검색 */
	@Override
	public List<Product> findByNamePaged(String keyword, int page, int size) throws Exception {
		return productDAO.findByNamePaged(keyword, offset(page, size), size);
	}

	@Override
	public int countByName(String keyword) throws Exception {
		return productDAO.countByName(keyword);
	}

	/* 2) 서브카테고리 */
	@Override
	public List<Product> getProductsBySubCategoryPaged(int subId, int page, int size) throws Exception {
		return productDAO.selectProductsBySubCategoryPaged(subId, offset(page, size), size);
	}

	@Override
	public int countBySubCategory(int subId) throws Exception {
		return productDAO.countBySubCategory(subId);
	}

	/* 3) 카테고리(대분류) */
	@Override
	public List<Product> getProductsByCategoryPaged(int catId, int page, int size) throws Exception {
		return productDAO.selectProductsByCategoryPaged(catId, offset(page, size), size);
	}

	@Override
	public int countByCategory(int catId) throws Exception {
		return productDAO.countByCategory(catId);
	}
}
