package service.order;

import java.sql.Date;
import java.util.List;
import dto.order.Order;
import dto.order.OrderItem;
import dto.order.OrderList;
import dto.order.Coupon;
import dto.order.Order;

public interface OrderService {
	List<OrderList> getAllOrders() throws Exception;

	int getTotalPages() throws Exception;

	List<OrderList> getFilteredOrders(String userId, String status, String period) throws Exception;

	List<OrderList> selectOrderListByUser(String userId) throws Exception;

	List<Order> getOrdersWithItemsByUserId(String userId) throws Exception;

	List<Order> getOrdersByDateRange(String userId, Date startDate, Date endDate) throws Exception;

	OrderList getOrderDetail(int orderId) throws Exception;

	void insertOrderList(Order order) throws Exception;

	void insertOrderItem(Order order) throws Exception;

	List<Order> selectOrdersByUser(String userId) throws Exception;

	void insertOrderList(List<Order> orderList) throws Exception;

	List<Order> selectOrderItemsByCartIds(List<Integer> cartIds) throws Exception;

	List<Coupon> getUnusedCoupons(String userId) throws Exception;

}
