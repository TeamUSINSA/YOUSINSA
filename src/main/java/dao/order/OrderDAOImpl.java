package dao.order;

import java.sql.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import dto.order.Order;
import dto.order.OrderItem;
import dto.order.OrderList;
import utils.MybatisSqlSessionFactory;

public class OrderDAOImpl implements OrderDAO {

    private SqlSession sqlSession;

    public OrderDAOImpl() {
		sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession(true); // auto commit
	}

    @Override
    public int insertOrder(Order order) throws Exception {
        return sqlSession.insert("mapper.order.insertOrder", order);
    }

    @Override
    public void insertOrderItem(OrderItem item) throws Exception {
        sqlSession.insert("mapper.order.insertOrderItem", item);
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

}
