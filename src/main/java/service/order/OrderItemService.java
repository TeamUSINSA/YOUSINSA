package service.order;

import java.util.List;

import dto.order.OrderItem;
import dto.product.Product;

public interface OrderItemService {

	List<OrderItem> getItems(int orderId) throws Exception;

	void addItem(OrderItem item) throws Exception;

	List<Product> getTopSellingProducts(int count) throws Exception;

}
