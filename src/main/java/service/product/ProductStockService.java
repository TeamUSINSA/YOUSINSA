package service.product;

public interface ProductStockService {

	 void decrementStock(int productId, String color, String size, int qty) throws Exception;
}
