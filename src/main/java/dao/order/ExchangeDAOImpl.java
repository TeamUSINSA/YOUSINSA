package dao.order;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import dto.order.Exchange;
import dto.order.OrderItem;
import utils.DBUtil;
import utils.MybatisSqlSessionFactory;

public class ExchangeDAOImpl implements ExchangeDAO {

	private SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();

	@Override
	public List<Exchange> selectAllExchanges() throws Exception {
		return sqlSession.selectList("mapper.order.selectAllExchanges");
	}

	@Override
	public int getTotalPages() throws Exception {
		return sqlSession.selectOne("mapper.order.getExchangeTotalPages");
	}

	@Override
	public List<Exchange> selectExchangesByApproved(Map<String, Object> param) {
		return sqlSession.selectList("mapper.order.selectExchangesByApproved", param);
	}

	@Override
	public Exchange selectExchangeById(int exchangeId) throws Exception {
		return sqlSession.selectOne("mapper.order.selectExchangeById", exchangeId);
	}

	// 교환 승인
	public void approveExchange(int exchangeId) throws Exception {
		String sql = "UPDATE exchange SET approved = 1, reject_reason = NULL WHERE exchange_id = ?";
		try (Connection conn = DBUtil.getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)) {
			pstmt.setInt(1, exchangeId);
			pstmt.executeUpdate();
		}
	}

	// 교환 반려
	public void rejectExchange(int exchangeId, String reason) throws Exception {
		String sql = "UPDATE exchange SET approved = 2, reject_reason = ? WHERE exchange_id = ?";
		try (Connection conn = DBUtil.getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)) {
			pstmt.setString(1, reason);
			pstmt.setInt(2, exchangeId);
			pstmt.executeUpdate();
		}
	}

	@Override
	public List<OrderItem> selectDeliveredItemsByOrder(String userId, int orderId) throws Exception {
		Map<String, Object> param = new HashMap<>();
		param.put("userId", userId);
		param.put("orderId", orderId);
		return sqlSession.selectList("mapper.order.selectDeliveredItemsByOrder", param);
	}

	@Override
	public void insertExchange(Exchange exchange) throws Exception {
		sqlSession.insert("mapper.order.insertExchange", exchange);
		sqlSession.commit();
	}

	@Override
	public void updateOrderItemToCancelPending(int orderItemId) throws Exception {
		sqlSession.update("mapper.order.updateOrderItemToCancelPending", orderItemId);
		sqlSession.commit();
	}

    
    @Override
    public int getOrderItemIdByExchangeId(int exchangeId) throws Exception {
        return sqlSession.selectOne("mapper.exchange.getOrderItemIdByExchangeId", exchangeId);
    }

}
