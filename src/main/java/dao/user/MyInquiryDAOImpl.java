package dao.user;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import dto.user.Inquiry;
import utils.MybatisSqlSessionFactory;

public class MyInquiryDAOImpl implements MyInquiryDAO {

	@Override
	public List<Inquiry> selectByUserId(Map<String, Object> params) throws Exception {
		try (SqlSession session = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return session.selectList("mapper.user.inquiry.selectByUserId", params);
		}
	}

	@Override
	public int countByUserId(String userId) throws Exception {
		try (SqlSession session = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return session.selectOne("mapper.user.inquiry.countByUserId", userId);

		}
	}

	@Override
	public Inquiry selectById(Map<String, Object> params) throws Exception {
		try (SqlSession session = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return session.selectOne("mapper.user.inquiry.selectById", params);
		}
	}

	@Override
	public int updateByUser(Inquiry inquiry) throws Exception {
		try (SqlSession session = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			int rows = session.update("mapper.user.inquiry.updateByUser", inquiry);
			session.commit();
			return rows;
		}
	}

	@Override
	public int deleteByUser(Map<String, Object> params) throws Exception {
		try (SqlSession session = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			int rows = session.delete("mapper.user.inquiry.deleteByUser", params);
			session.commit();
			return rows;
		}
	}

}
