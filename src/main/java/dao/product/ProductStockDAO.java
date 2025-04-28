package dao.product;

public interface ProductStockDAO {
    void increaseQuantity(int productId, String color, String size, int quantity) throws Exception;
}