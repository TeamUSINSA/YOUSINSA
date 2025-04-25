package dao.order;

import dto.order.OrderList;

public interface OrderListDAO {

	void insertPendingOrder(OrderList order) throws Exception;

	OrderList selectByOrderId(int orderId) throws Exception;

	void updateToPaid(OrderList order) throws Exception;

	void updateToCanceled(int orderId) throws Exception;

}
