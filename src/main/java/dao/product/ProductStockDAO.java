package dao.product;

import java.util.List;

import dto.product.ProductStock;

public interface ProductStockDAO {

    void increaseQuantity(int productId, String color, String size, int quantity) throws Exception;
 
	int decrementStock(int productId, String color, String size, int qty) throws Exception;
	/** 주어진 상품의 재고 목록 조회 (color, size, quantity) */
    List<ProductStock> selectStockByProductId(int productId) throws Exception;
}

