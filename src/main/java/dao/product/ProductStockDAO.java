package dao.product;

public interface ProductStockDAO {
	
	int decrementStock(int productId, String color, String size, int qty) throws Exception;

}
