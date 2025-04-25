package service.order;

import java.sql.Date;
import java.util.List;

import dao.order.OrderDAO;
import dao.order.OrderDAOImpl;
import dto.order.OrderList;
import dao.order.CartDAO;
import dao.order.CartDAOImpl;
import dao.order.OrderDAO;
import dao.order.OrderDAOImpl;
import dto.order.Coupon;
import dto.order.Order;

public class OrderServiceImpl implements OrderService {
	private OrderDAO orderDAO = new OrderDAOImpl();
	private CartDAO cartDAO = new CartDAOImpl(); // 장바구니 기반 주문 조회용

	@Override
	public List<OrderList> getAllOrders() throws Exception {
		return orderDAO.selectAllOrders();
	}

	@Override
	public int getTotalPages() throws Exception {
		return orderDAO.getTotalOrderPages();
	}

	@Override
	public List<OrderList> getFilteredOrders(String userId, String status, String period) throws Exception {
		return orderDAO.selectFilteredOrders(userId, status, period);
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

	@Override
	public void insertOrderList(Order order) throws Exception {
		orderDAO.insertOrderList(order);
	}

	@Override
	public void insertOrderItem(Order order) throws Exception {
		orderDAO.insertOrderItem(order);
	}

	@Override
	public List<Order> selectOrdersByUser(String userId) throws Exception {
		return orderDAO.selectOrdersByUser(userId);
	}

	@Override
	public void insertOrderList(List<Order> orderList) throws Exception {
		for (Order order : orderList) {
			insertOrderItem(order);
		}
	}

	@Override
	public List<Order> selectOrderItemsByCartIds(List<Integer> cartIds) throws Exception {
		return cartDAO.selectOrderItemsByCartIds(cartIds);
	}

	@Override
	public List<Coupon> getUnusedCoupons(String userId) throws Exception {
		return orderDAO.selectUnusedCouponsByUserId(userId);
	}

}
