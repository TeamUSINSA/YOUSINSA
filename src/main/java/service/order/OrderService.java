// src/main/java/service/order/OrderService.java
package service.order;

import java.util.List;

import dto.order.Coupon;
import dto.order.Order;

public interface OrderService {

	void insertOrderList(Order order) throws Exception;

	void insertOrderItem(Order order) throws Exception;

	List<Order> selectOrdersByUser(String userId) throws Exception;

	void insertOrderList(List<Order> orderList) throws Exception;

	List<Order> selectOrderItemsByCartIds(List<Integer> cartIds) throws Exception;

	List<Coupon> getUnusedCoupons(String userId) throws Exception;
}
