package dao.order;

import java.sql.Date;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import dto.order.Coupon;
import dto.order.Order;
import dto.order.OrderList;
import dto.user.User;
import dto.user.UserCoupon;
import utils.MybatisSqlSessionFactory;

public class OrderDAOImpl implements OrderDAO {

	private SqlSession sqlSession;

	public OrderDAOImpl() {
		sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession(true); // auto commit
	}

	@Override
	public void insertOrderList(Order order) throws Exception {
		sqlSession.insert("mapper.orderproduct.insertOrderList", order);
	}

	@Override
	public void insertOrderItem(Order order) throws Exception {
		sqlSession.insert("mapper.orderproduct.insertOrderItem", order);
	}

	@Override
	public List<Order> selectOrdersByUser(String userId) throws Exception {
		return sqlSession.selectList("mapper.order.selectOrdersByUser", userId);
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
	public List<OrderList> selectAllOrders() throws Exception {
		return sqlSession.selectList("mapper.order.selectAllOrders");
	}

	@Override
	public int getTotalOrderPages() throws Exception {
		return sqlSession.selectOne("mapper.order.getTotalPages");
	}

	@Override
	public List<OrderList> findOrdersByUserId(String userId) throws Exception {
		return sqlSession.selectList("mapper.order.findOrdersByUserId", userId);
	}

	@Override
	public List<OrderList> selectOrderListByUser(String userId) throws Exception {
		return sqlSession.selectList("mapper.order.selectOrderListByUser", userId);
	}

	@Override
	public List<Order> getOrderWithItemsByUserId(String userId) throws Exception {
		List<Order> result = sqlSession.selectList("mapper.order.selectOrderWithItemsByUserId", userId);
		System.out.println("[DEBUG] userId: " + userId);
		System.out.println("[DEBUG] result is null? " + (result == null));
		System.out.println("[DEBUG] result size: " + (result != null ? result.size() : "N/A"));
		return result;
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
	public OrderList findOrderById(int orderId) throws Exception {
		return sqlSession.selectOne("mapper.order.findOrderById", orderId);
	}

	@Override
	public List<OrderList> selectFilteredOrders(String userId, String status, String period) {
		// 필요한 파라미터를 Map으로 묶어서 전달
		Map<String, Object> paramMap = new HashMap<>();
		paramMap.put("userId", userId);
		paramMap.put("status", status);
		paramMap.put("period", period);

		return sqlSession.selectList("mapper.order.selectFilteredOrders", paramMap);
	}

}
