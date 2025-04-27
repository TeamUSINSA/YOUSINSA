package dao.user;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import dto.order.Cancel;
import utils.MybatisSqlSessionFactory;

public class MyCancelDAOImpl implements myCancelDAO {
	private SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();

	@Override
	public void insertCancel(Cancel cancel) throws Exception {
		sqlSession.insert("mapper.order.mycancel.insertCancel",cancel);
		sqlSession.commit();
		
	}

	@Override
	public void updateOrderToCancelled(int orderId) throws Exception {
		sqlSession.update("mapper.order.mycancel.updateOrderToCancelled",orderId);
		sqlSession.commit();
	}


}
