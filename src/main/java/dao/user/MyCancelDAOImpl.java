package dao.user;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import dto.order.Cancel;
import utils.MybatisSqlSessionFactory;

public class MyCancelDAOImpl implements MyCancelDAO {

	@Override
	public void insertCancel(Cancel cancel) {
		try (SqlSession session = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			session.insert("mapper.order.mycancel.insertCancel", cancel);
			session.commit();
		}
	}

	@Override
	public void updateOrderToCancelled(int orderId) {
		try (SqlSession session = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			session.update("mapper.order.mycancel.updateOrderToCancelled", orderId);
			session.commit();
		}
	}

	@Override
	public List<Cancel> selectCancelList(Map<String, Object> params) throws Exception {
		try (SqlSession session = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return session.selectList("mapper.order.mycancel.selectCancelList", params);
		}
	}

	@Override
	public Cancel selectCancelById(int cancelId) throws Exception {
		try (SqlSession session = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return session.selectOne("mapper.order.mycancel.selectCancelById", cancelId);
		}
	}
}
