package dao.order;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import dto.order.OrderList;
import utils.MybatisSqlSessionFactory;

public class OrderDAOImpl implements OrderDAO {
	private SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();

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
