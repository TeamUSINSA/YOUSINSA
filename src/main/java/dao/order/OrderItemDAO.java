package dao.order;

import java.util.List;

import dto.order.OrderItem;
import dto.product.Product;

public interface OrderItemDAO {

	void insert(OrderItem item) throws Exception;

	List<OrderItem> selectByOrderId(int orderId) throws Exception;

	List<Product> selectTopSellingProducts(int count) throws Exception;

}
