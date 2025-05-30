package service.order;

import java.sql.Date;
import java.util.List;

import org.apache.ibatis.session.SqlSession;

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
import utils.MybatisSqlSessionFactory;

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
	public List<OrderList> getFilteredOrders(String userId, String status, String period, int offset, int limit) throws Exception {
	    return orderDAO.selectFilteredOrders(userId, status, period, offset, limit);
	}

	@Override
	public int getFilteredOrderCount(String userId, String status, String period) throws Exception {
	    return orderDAO.countFilteredOrders(userId, status, period);
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
		// 1) DAO 호출: userId, 날짜 범위에 맞는 전체 주문을 가져온다
		List<Order> orders = orderDAO.getOrdersByDateRange(userId, startDate, endDate);
		// 2) Java 8+ removeIf 로 “취소완료” 또는 “반품완료” 상태 주문을 **리스트에서 제거**
        orders.removeIf(o ->
            "취소완료".equals(o.getDeliveryStatus()) ||
            "반품완료".equals(o.getDeliveryStatus())
        );

        // 3) (선택) 품목별 리뷰 플래그 설정이나 기타 후처리

        return orders;
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
    
    @Override
    public void updateDeliveryStatus(int orderId, String deliveryStatus) throws Exception {
        orderDAO.updateDeliveryStatus(orderId, deliveryStatus);
        // ✅ orderitem 테이블도 같이 업데이트
        orderDAO.updateOrderItemStatuses(orderId, deliveryStatus);
    }

    @Override
    public void updateOrderItemStatuses(int orderId, String deliveryStatus) throws Exception {
        orderDAO.updateOrderItemStatuses(orderId, deliveryStatus);
    }
    
    @Override
    public void insertOrderWithItems(Order order) throws Exception {
        SqlSession session = MybatisSqlSessionFactory.getSqlSessionFactory().openSession(false); // 수동 커밋

        try {
            orderDAO.insertOrderList(order, session);  // 주문 테이블
            orderDAO.insertOrderItem(order, session);  // 아이템 테이블
            session.commit();
        } catch (Exception e) {
            session.rollback();
            throw e;
        } finally {
            session.close();
        }
    }
}
