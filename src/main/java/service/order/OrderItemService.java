package service.order;

import java.util.List;

import dto.order.OrderItem;

public interface OrderItemService {

	List<OrderItem> getItems(int orderId) throws Exception;

	void addItem(OrderItem item) throws Exception;

}
