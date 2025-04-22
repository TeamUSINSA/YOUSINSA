package service.admin;

import java.util.List;

import dao.admin.ProductDAO;
import dao.admin.ProductDAOImpl;
import dto.product.Product;

public class ProductServiceImpl implements ProductService {

    // DAO 연결
    private ProductDAO productDAO = new ProductDAOImpl();

    @Override
    public void insertProduct(Product product) throws Exception{
        productDAO.insertProduct(product);
    }

    @Override
    public void updateProduct(Product product) throws Exception {
        productDAO.updateProduct(product);
    }

    @Override
    public void deleteProductById(int productId) throws Exception {
        productDAO.deleteProductById(productId);
    }

    @Override
    public Product selectProductById(int productId) throws Exception {
        return productDAO.selectProductById(productId);
    }

    @Override
    public List<Product> searchProduct(String searchType, String keyword) throws Exception {
        return productDAO.selectProductList(searchType, keyword);
    }

    @Override
    public List<Product> selectProductsBySubCategoryId(int subCategoryId) throws Exception {
        return productDAO.selectProductsBySubCategoryId(subCategoryId);
    }
}
