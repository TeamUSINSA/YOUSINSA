// src/main/java/service/order/impl/OrderServiceImpl.java
package service.order;

import java.sql.Date;
import java.util.List;

import dao.order.OrderDAO;
import dao.order.OrderDAOImpl;
import dto.order.Order;
import dto.order.OrderItem;
import dto.order.OrderList;

public class OrderServiceImpl implements OrderService {

    private OrderDAO orderDAO = new OrderDAOImpl();

    @Override
    public int insertOrder(Order order) throws Exception {
        return orderDAO.insertOrder(order);
    }

    @Override
    public void insertOrderItem(OrderItem item) throws Exception {
        orderDAO.insertOrderItem(item);
    }

    @Override
    public List<OrderList> selectOrderListByUser(String userId) throws Exception {
        return orderDAO.selectOrderListByUser(userId);
    }

	@Override
	public List<Order> getOrdersWithItemsByUserId(String userId) throws Exception {
		return orderDAO.getOrderWithItemsByUserId(userId);
	}

	@Override
	public List<Order> getOrdersByDateRange(String userId, Date startDate, Date endDate) throws Exception {
		return orderDAO.getOrdersByDateRange(userId, startDate, endDate);
	}

	@Override
	public OrderList getOrderDetail(int orderId) throws Exception {
		return orderDAO.getOrderDetailById(orderId);
	}

	
}
