package dao.order;

import java.sql.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import dto.order.Coupon;
import dto.order.Order;
import dto.order.OrderItem;
import dto.order.OrderList;
import dto.user.User;
import dto.user.UserCoupon;
import utils.MybatisSqlSessionFactory;

public class OrderDAOImpl implements OrderDAO {

    private SqlSession sqlSession;

    public OrderDAOImpl() {
        sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession(true);
    }

    @Override
    public List<OrderList> selectAllOrders() throws Exception {
        return sqlSession.selectList("mapper.order.selectAllOrders");
    }

    @Override
    public int getTotalOrderPages() throws Exception {
        return sqlSession.selectOne("mapper.order.getTotalPages");
    }

    @Override
    public List<OrderList> selectFilteredOrders(String userId, String status, String period, int offset, int limit) throws Exception {
        Map<String, Object> paramMap = new HashMap<>();
        paramMap.put("userId", userId);
        paramMap.put("status", status);
        paramMap.put("period", period);
        paramMap.put("offset", offset);
        paramMap.put("limit", limit);
        return sqlSession.selectList("mapper.order.selectFilteredOrdersWithPaging", paramMap);
    }
    
    @Override
    public int countFilteredOrders(String userId, String status, String period) throws Exception {
        Map<String, Object> paramMap = new HashMap<>();
        paramMap.put("userId", userId);
        paramMap.put("status", status);
        paramMap.put("period", period);
        return sqlSession.selectOne("mapper.order.countFilteredOrders", paramMap);
    }

    @Override
    public List<OrderList> findOrdersByUserId(String userId) throws Exception {
        return sqlSession.selectList("mapper.order.findOrdersByUserId", userId);
    }

    @Override
    public OrderList findOrderListById(int orderId) throws Exception {
        return sqlSession.selectOne("mapper.order.findOrderListById", orderId);
    }



    @Override
    public List<Order> selectOrdersByUser(String userId) throws Exception {
        return sqlSession.selectList("mapper.order.selectOrdersByUser", userId);
    }

    @Override
    public Order selectOrderById(int orderId) throws Exception {
        return sqlSession.selectOne("mapper.order.selectOrderById", orderId);
    }

    @Override
    public OrderItem selectOrderItemById(int orderItemId) throws Exception {
        return sqlSession.selectOne("mapper.order.selectOrderItemById", orderItemId);
    }

    @Override
    public User selectUserById(String userId) throws Exception {
        return sqlSession.selectOne("mapper.user.selectUser", userId);
    }

    @Override
    public List<Coupon> selectUnusedCouponsByUserId(String userId) throws Exception {
        return sqlSession.selectList("mapper.userCoupon.selectUnusedCouponsByUserId", userId);
    }

    @Override
    public void markCouponUsed(UserCoupon uc) throws Exception {
        sqlSession.update("mapper.userCoupon.markCouponUsed", uc);
    }

    @Override
    public List<Order> getOrderWithItemsByUserId(String userId) throws Exception {
        return sqlSession.selectList("mapper.order.selectOrderWithItemsByUserId", userId);
    }

    @Override
    public List<Order> findOrdersByUserAndDate(String userId, Date startDate, Date endDate) throws Exception {
        Map<String, Object> params = new HashMap<>();
        params.put("userId", userId);
        params.put("startDate", startDate);
        params.put("endDate", endDate);
        return sqlSession.selectList("mapper.order.selectOrdersByUserAndDate", params);
    }

    @Override
    public List<Order> getOrdersByDateRange(String userId, Date startDate, Date endDate) throws Exception {
        Map<String, Object> params = new HashMap<>();
        params.put("userId", userId);
        params.put("startDate", startDate);
        params.put("endDate", endDate);
        return sqlSession.selectList("mapper.order.selectOrderByDateRange", params);
    }

    @Override
    public OrderList getOrderDetailById(int orderId) throws Exception {
        return sqlSession.selectOne("mapper.order.getOrderDetailById", orderId);
    }

    @Override
    public List<OrderList> selectOrderListByUser(String userId) throws Exception {
        return sqlSession.selectList("mapper.order.selectOrderListByUser", userId);
    }
    
    @Override
    public void updateDeliveryStatus(Integer orderId, String deliveryStatus) throws Exception {
        Map<String, Object> params = new HashMap<>();
        params.put("orderId", orderId);
        params.put("deliveryStatus", deliveryStatus);
        sqlSession.update("mapper.orderlist.updateDeliveryStatus", params);
    }
    
    @Override
    public void updateOrderItemStatuses(int orderId, String deliveryStatus) throws Exception {
        Map<String, Object> params = new HashMap<>();
        params.put("orderId", orderId);
        params.put("status", deliveryStatus);
        sqlSession.update("mapper.order.updateOrderItemStatuses", params);
    }
    
    public void insertOrderList(Order order, SqlSession session) throws Exception {
        session.insert("mapper.orderproduct.insertOrderList", order);
    }

    public void insertOrderItem(Order order, SqlSession session) throws Exception {
        session.insert("mapper.orderproduct.insertOrderItem", order);
    }

    @Override
    public void insertOrderList(Order order) throws Exception {
        SqlSession session = MybatisSqlSessionFactory.getSqlSessionFactory().openSession(true); // auto-commit
        try {
            session.insert("mapper.orderproduct.insertOrderList", order);
        } finally {
            session.close();
        }
    }

    @Override
    public void insertOrderItem(Order order) throws Exception {
        SqlSession session = MybatisSqlSessionFactory.getSqlSessionFactory().openSession(true); // auto-commit
        try {
            session.insert("mapper.orderproduct.insertOrderItem", order);
        } finally {
            session.close();
        }
    }

}
