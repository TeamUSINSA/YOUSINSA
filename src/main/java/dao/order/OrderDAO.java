package dao.order;

import java.util.List;

import dto.order.Coupon;
import dto.order.Order;
import dto.user.User;
import dto.user.UserCoupon;

public interface OrderDAO {

	void insertOrderList(Order order) throws Exception;

	void insertOrderItem(Order order) throws Exception;

	List<Order> selectOrdersByUser(String userId) throws Exception;

	User selectUserById(String userId) throws Exception;

	void markCouponUsed(UserCoupon uc) throws Exception;

	List<Coupon> selectUnusedCouponsByUserId(String userId) throws Exception;
}
