package dao.order;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import dto.order.Return;
import utils.MybatisSqlSessionFactory;

public class ReturnDAOImpl implements ReturnDAO {

	private SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();

	@Override
	public List<Return> selectAllReturns() throws Exception {
		return sqlSession.selectList("mapper.return.selectAllReturns");
	}

	@Override
	public List<Return> selectReturnsByApproved(int approved) throws Exception {
		return sqlSession.selectList("mapper.return.selectReturnsByApproved", approved);
	}

	@Override
	public int getTotalPages() throws Exception {
		return sqlSession.selectOne("mapper.return.getTotalPages");
	}

	@Override
	public void updateApprovedStatus(int returnId, int approved) throws Exception {
		Map<String, Object> param = new HashMap<>();
		param.put("returnId", returnId);
		param.put("approved", approved);

		sqlSession.update("mapper.return.updateApprovedStatus", param);
		sqlSession.commit();
	}

	@Override
	public void updateRejectedStatus(int returnId, int approved, String rejectReason) throws Exception {
		Map<String, Object> param = new HashMap<>();
		param.put("returnId", returnId);
		param.put("approved", approved);
		param.put("rejectReason", rejectReason);

        sqlSession.update("mapper.return.updateRejectedStatus", param);
        sqlSession.commit();
    }
    
    @Override
    public Return selectReturnById(int returnId) throws Exception {
        return sqlSession.selectOne("mapper.return.selectReturnById", returnId);
    }
    
    @Override
    public int getOrderItemIdByReturnId(int returnId) throws Exception {
        return sqlSession.selectOne("mapper.return.getOrderItemIdByReturnId", returnId);
    }

	@Override
	public int insertReturn(Return returnRequest) throws Exception {
		int cnt = sqlSession.insert("mapper.return.insertReturn", returnRequest);
		sqlSession.commit();
		return cnt;
	}

	@Override
	public Return selectReturnByReturnId(int returnId) throws Exception {
		return sqlSession.selectOne("mapper.return.selectReturnById", returnId);
	}

	@Override
	public List<Return> selectReturnsByUserId(String userId) throws Exception {
		return sqlSession.selectList("mapper.return.selectReturnsByUserId", userId);
	}

	@Override
	public int updateOrderItemStatus(Return returnRequest) throws Exception {
		int cnt = sqlSession.update("mapper.return.updateOrderItemStatus", returnRequest);
		sqlSession.commit();
		return cnt;
	}

	@Override
	public int updateOrderListStatus(Return returnRequest) throws Exception {
		int cnt = sqlSession.update("mapper.return.updateOrderListStatus", returnRequest);
		sqlSession.commit();
		return cnt;
	}

}
