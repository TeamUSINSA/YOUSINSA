package service.order;

import java.util.List;

import dao.order.CartDAO;
import dao.order.CartDAOImpl;
import dao.order.OrderDAO;
import dao.order.OrderDAOImpl;
import dao.product.ProductDAO;
import dao.product.ProductDAOImpl;
import dto.order.Coupon;
import dto.order.Order;
import dto.order.OrderItem;
import dto.order.OrderList;
import dto.product.Product;

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
	
    @Override
    public OrderItem findOrderItemById(int orderItemId) throws Exception{
        return orderDAO.selectOrderItemById(orderItemId);
    }

    @Override
    public Order findOrderById(int orderId) throws Exception{
        return orderDAO.selectOrderById(orderId);
    }

    @Override
    public OrderList findOrderListById(int orderId) throws Exception {
        return orderDAO.findOrderListById(orderId); // 이게 이제 제대로 동작해!
    }
    private ProductDAO productDAO = new ProductDAOImpl();

    @Override
    public Product findProductById(int productId) throws Exception {
        return productDAO.selectProductById(productId);
    }


    @Override
    public List<OrderList> findOrdersByUserId(String userId) throws Exception {
        return orderDAO.findOrdersByUserId(userId);
    }
}
