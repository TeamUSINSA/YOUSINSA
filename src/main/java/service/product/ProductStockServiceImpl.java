package service.product;

import dao.product.ProductStockDAO;
import dao.product.ProductStockDAOImpl;

public class ProductStockServiceImpl implements ProductStockService {

	private ProductStockDAO productstockDAO = new ProductStockDAOImpl();

	@Override
	public void decrementStock(int productId, String color, String size, int qty) throws Exception {
		int updated = productstockDAO.decrementStock(productId, color, size, qty);
		if (updated == 0) {
			throw new IllegalStateException("재고 부족 또는 잘못된 상품정보입니다.");
		}
	}
}
