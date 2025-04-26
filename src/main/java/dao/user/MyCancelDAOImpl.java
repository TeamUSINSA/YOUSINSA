//package dao.user;
//
//import java.util.List;
//
//import org.apache.ibatis.session.SqlSession;
//import org.apache.ibatis.session.SqlSessionFactory;
//
//import dto.order.Cancel;
//import utils.MybatisSqlSessionFactory;
//
//public class MyCancelDAOImpl implements myCancelDAO {
//	private SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
//
//	@Override
//	public void insertCancel(Cancel cancel) throws Exception {
//		sqlSession.insert("mapper.order.insertCancel", cancel);
//        sqlSession.commit();
//		
//	}
//
//	@Override
//	public List<Cancel> getCancelsByUserId(String userId) throws Exception {
//		return sqlSession.selectList("mapper.order.getCancelsByUserId", userId);
//	}
//
//	@Override
//	public Cancel getCancelById(int cancelId) throws Exception {
//		return sqlSession.selectOne("mapper.order.getCancelById", cancelId);
//	}
//
//	@Override
//	public int countCancelByOrderId(int orderId) throws Exception {
//		return sqlSession.selectOne("mapper.order.countCancelByOrderId", orderId);
//	}
//
//}
