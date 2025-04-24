package dao.order;

import java.sql.Date;
import java.util.List;

import dto.order.Order;
import dto.order.OrderItem;
import dto.order.OrderList;

public interface OrderDAO {

	int insertOrder(Order order) throws Exception;

	void insertOrderItem(OrderItem item) throws Exception;

	List<OrderList> selectOrderListByUser(String userId) throws Exception;

	List<Order> getOrderWithItemsByUserId(String userId) throws Exception;

	List<Order> findOrdersByUserAndDate(String userId, Date startDate, Date endDate) throws Exception;
	
	List<Order> getOrdersByDateRange(String userId, Date startDate, Date endDate) throws Exception;
	
	OrderList getOrderDetailById(int orderId) throws Exception;
}
