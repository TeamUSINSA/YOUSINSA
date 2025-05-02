package dao.order;

import java.sql.Date;
import java.util.List;

import org.apache.ibatis.session.SqlSession;

import dto.order.Coupon;
import dto.order.Order;
import dto.order.OrderItem;
import dto.order.OrderList;
import dto.user.User;
import dto.user.UserCoupon;

public interface OrderDAO {
    List<OrderList> selectAllOrders() throws Exception;

    int getTotalOrderPages() throws Exception;


    List<OrderList> findOrdersByUserId(String userId) throws Exception;

    OrderList findOrderListById(int orderId) throws Exception;

    void insertOrderList(Order order, SqlSession session) throws Exception;
    void insertOrderItem(Order order, SqlSession session) throws Exception;

    List<Order> selectOrdersByUser(String userId) throws Exception;

    Order selectOrderById(int orderId) throws Exception;

    OrderItem selectOrderItemById(int orderItemId) throws Exception;

    User selectUserById(String userId) throws Exception;

    List<Coupon> selectUnusedCouponsByUserId(String userId) throws Exception;

    void markCouponUsed(UserCoupon uc) throws Exception;

    List<Order> getOrderWithItemsByUserId(String userId) throws Exception;

    List<Order> findOrdersByUserAndDate(String userId, Date startDate, Date endDate) throws Exception;

    List<Order> getOrdersByDateRange(String userId, Date startDate, Date endDate) throws Exception;

    OrderList getOrderDetailById(int orderId) throws Exception;

    List<OrderList> selectOrderListByUser(String userId) throws Exception;
    
    void updateDeliveryStatus(Integer orderId, String deliveryStatus) throws Exception;
    
 // ✅ 페이징 적용된 주문 목록 조회
    List<OrderList> selectFilteredOrders(String userId, String status, String period, int offset, int limit) throws Exception;

    // ✅ 필터된 전체 주문 수 조회
    int countFilteredOrders(String userId, String status, String period) throws Exception;
    
    void updateOrderItemStatuses(int orderId, String deliveryStatus) throws Exception;

	void insertOrderList(Order order) throws Exception;

	void insertOrderItem(Order order) throws Exception;

}
