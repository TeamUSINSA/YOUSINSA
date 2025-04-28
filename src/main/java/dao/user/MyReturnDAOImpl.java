package dao.user;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import dto.order.Return;
import utils.MybatisSqlSessionFactory;

public class MyReturnDAOImpl implements MyReturnDAO{

	@Override
	public void insertReturn(Return returnEntity) throws Exception {
		try (SqlSession session = MybatisSqlSessionFactory
                .getSqlSessionFactory()
                .openSession()) {
			session.insert("mapper.order.return.insertReturn", returnEntity);
		}
		
	}

	@Override
	public void updateOrderItemToReturned(int orderItemId) throws Exception {
		try (SqlSession session = MybatisSqlSessionFactory
                .getSqlSessionFactory()
                .openSession()) {
			session.update("mapper.order.return.updateOrderItemToReturned", orderItemId);
		}
		
	}

	@Override
	public List<Return> selectReturnList(Map<String, Object> params) throws Exception {
		try (SqlSession session = MybatisSqlSessionFactory
                .getSqlSessionFactory()
                .openSession()) {
			return session.selectList("mapper.order.myreturn.selectReturnList", params);
		}
	}

}
