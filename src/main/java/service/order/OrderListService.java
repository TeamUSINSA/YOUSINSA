package service.order;

import dto.order.OrderList;

public interface OrderListService {

	void createPendingOrder(OrderList order) throws Exception;

	OrderList getOrder(int orderId) throws Exception;

	void markPaid(OrderList order) throws Exception;

	void cancelOrder(int orderId) throws Exception;

}
