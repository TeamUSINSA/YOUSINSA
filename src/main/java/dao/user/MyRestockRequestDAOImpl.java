package dao.user;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import dto.user.RestockRequest;
import utils.MybatisSqlSessionFactory;

public class MyRestockRequestDAOImpl implements MyRestockRequestDAO{
	private static final String NAMESPACE = "mapper.user.myrestockrequest";
	@Override
	public int insert(RestockRequest req) throws Exception {
		try (SqlSession session = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
            int cnt = session.insert(NAMESPACE + ".insert", req);
            session.commit();
            return cnt;
        }
	}

	@Override
	public List<RestockRequest> selectByUser(String userId) throws Exception {
		try (SqlSession session = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
            return session.selectList(NAMESPACE + ".selectByUser", userId);
        }
	}

	@Override
	public int delete(int requestId) throws Exception {
		try (SqlSession session = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
            int cnt = session.delete(NAMESPACE + ".delete", requestId);
            session.commit();
            return cnt;
        }
	}

}
