package service.product;

import java.util.Collections;
import java.util.List;

import dao.product.ProductDAO;
import dao.product.ProductDAOImpl;
import dto.product.Product;

public class ProductServiceImpl implements ProductService{
	
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
}
