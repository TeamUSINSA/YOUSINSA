// src/main/java/service/order/OrderService.java
package service.order;

import java.sql.Date;
import java.util.List;

import dto.order.Order;
import dto.order.OrderItem;
import dto.order.OrderList;

public interface OrderService {

    int insertOrder(Order order) throws Exception;

    void insertOrderItem(OrderItem item) throws Exception;

    List<OrderList> selectOrderListByUser(String userId) throws Exception;
    
    List<Order> getOrdersWithItemsByUserId(String userId) throws Exception;
    
    List<Order> getOrdersByDateRange(String userId, Date startDate, Date endDate) throws Exception;
    
    OrderList getOrderDetail(int orderId) throws Exception;
    
}
