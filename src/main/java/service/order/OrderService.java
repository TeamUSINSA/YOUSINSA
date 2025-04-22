// src/main/java/service/order/OrderService.java
package service.order;

import java.util.List;
import dto.order.Order;
import dto.order.OrderItem;
import dto.order.OrderList;

public interface OrderService {

    int insertOrder(Order order) throws Exception;

    void insertOrderItem(OrderItem item) throws Exception;

    List<OrderList> selectOrderListByUser(String userId) throws Exception;
}
