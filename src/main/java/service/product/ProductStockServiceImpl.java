package service.product;

import dao.product.ProductStockDAO;
import dao.product.ProductStockDAOImpl;

public class ProductStockServiceImpl implements ProductStockService {

	private ProductStockDAO productstockDAO = new ProductStockDAOImpl();

	
	@Override
    public void decrementStock(int productId, String color, String size, int quantity) throws Exception {
		productstockDAO.decrementStock(productId, color, size, quantity);
    }
}
