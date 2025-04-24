package service.order;

import java.util.List;
import dto.order.OrderList;

public interface OrderService {
    List<OrderList> getAllOrders() throws Exception;
    int getTotalPages() throws Exception;
	List<OrderList> getFilteredOrders(String userId, String status, String period) throws Exception;
}