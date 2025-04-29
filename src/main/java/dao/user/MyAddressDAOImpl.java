package dao.user;

import org.apache.ibatis.session.SqlSession;

import dto.user.User;
import utils.MybatisSqlSessionFactory;

public class MyAddressDAOImpl implements MyAddressDAO {

	@Override
	public User selectAddressesByUserId(String userId) throws Exception {
		try (SqlSession session = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return session.selectOne("mapper.user.selectAddressesByUserId", userId);
		}
	}

	@Override
	public int updateAddress1(User user) throws Exception {
		try (SqlSession session = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			int rows = session.update("mapper.user.updateAddress1", user);
			session.commit();
			return rows;
		}
	}

	@Override
	public int updateAddress2(User user) throws Exception {
		try (SqlSession session = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			int rows = session.update("mapper.user.updateAddress2", user);
			session.commit();
			return rows;
		}
	}

	@Override
	public int updateAddress3(User user) throws Exception {
		try (SqlSession session = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			int rows = session.update("mapper.user.updateAddress3", user);
			session.commit();
			return rows;
		}
	}

	@Override
	public int deleteAddress1(String userId) throws Exception {
		try (SqlSession session = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			int rows = session.update("mapper.user.deleteAddress1", userId);
	        session.commit();
	        return rows;
		}
	}

	@Override
	public int deleteAddress2(String userId) throws Exception {
		try (SqlSession session = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			int rows = session.update("mapper.user.deleteAddress2", userId);
	        session.commit();
	        return rows;
		}
	}

	@Override
	public int deleteAddress3(String userId) throws Exception {
		try (SqlSession session = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			int rows = session.update("mapper.user.deleteAddress3", userId);
	        session.commit();
	        return rows;
		}
	}
}
