package dao.order;

import java.util.List;

import dto.order.OrderItem;

public interface OrderItemDAO {

	void insert(OrderItem item) throws Exception;

	List<OrderItem> selectByOrderId(int orderId) throws Exception;

}
