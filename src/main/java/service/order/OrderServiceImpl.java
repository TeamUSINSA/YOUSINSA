package service.order;

import java.util.List;

import dao.order.CartDAO;
import dao.order.CartDAOImpl;
import dao.order.OrderDAO;
import dao.order.OrderDAOImpl;
import dto.order.Coupon;
import dto.order.Order;

public class OrderServiceImpl implements OrderService {

    private OrderDAO orderDAO = new OrderDAOImpl();
    private CartDAO cartDAO = new CartDAOImpl();  // 장바구니 기반 주문 조회용

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
