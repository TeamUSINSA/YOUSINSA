package dao.order;

import java.sql.Date;
import java.util.List;

import dto.order.Coupon;
import dto.order.Order;
import dto.order.OrderList;
import dto.user.User;
import dto.user.UserCoupon;

public interface OrderDAO {
	List<OrderList> selectAllOrders() throws Exception;

	int getTotalOrderPages() throws Exception;
	
	List<OrderList> findOrdersByUserId(String userId) throws Exception;
	
	OrderList findOrderById(int orderId) throws Exception;
	
	// DAO 인터페이스
	List<OrderList> selectFilteredOrders(String userId, String status, String period) throws Exception;
	
	void insertOrderList(Order order) throws Exception;

	void insertOrderItem(Order order) throws Exception;

	List<Order> selectOrdersByUser(String userId) throws Exception;


	List<Order> getOrderWithItemsByUserId(String userId) throws Exception;

	List<Order> findOrdersByUserAndDate(String userId, Date startDate, Date endDate) throws Exception;
	
	List<Order> getOrdersByDateRange(String userId, Date startDate, Date endDate) throws Exception;
	
	OrderList getOrderDetailById(int orderId) throws Exception;

	User selectUserById(String userId) throws Exception;

	void markCouponUsed(UserCoupon uc) throws Exception;

	List<Coupon> selectUnusedCouponsByUserId(String userId) throws Exception;
	List<OrderList> selectOrderListByUser(String userId) throws Exception;
}
