package dao.order;

import java.util.List;

import dto.order.OrderList;

public interface OrderDAO {
	List<OrderList> selectAllOrders() throws Exception;

	int getTotalOrderPages() throws Exception;
	
	List<OrderList> findOrdersByUserId(String userId) throws Exception;
	
	OrderList findOrderById(int orderId) throws Exception;
	
	// DAO 인터페이스
	List<OrderList> selectFilteredOrders(String userId, String status, String period) throws Exception;
}