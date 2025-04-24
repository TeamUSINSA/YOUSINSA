package dao.order;

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

	User selectUserById(String userId) throws Exception;

	void markCouponUsed(UserCoupon uc) throws Exception;

	List<Coupon> selectUnusedCouponsByUserId(String userId) throws Exception;
}
