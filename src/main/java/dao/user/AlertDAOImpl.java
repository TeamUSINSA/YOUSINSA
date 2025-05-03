package dao.user;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import dto.user.Alert;
import utils.MybatisSqlSessionFactory;

public class AlertDAOImpl implements AlertDAO {

	private final SqlSessionFactory sqlSessionFactory;

	public AlertDAOImpl() {
		this.sqlSessionFactory = MybatisSqlSessionFactory.getSqlSessionFactory();
	}

	@Override
	public int countUncheckedAlerts(String userId) throws Exception {
		try (SqlSession session = sqlSessionFactory.openSession()) {
			return session.selectOne("mapper.alert.countUncheckedAlerts", userId);
		}
	}

	@Override
	public List<Alert> selectByUser(String userId) throws Exception {
		try (SqlSession session = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			// mapper 의 id: selectByUser
			List<Alert> alerts = session.selectList("mapper.alert.selectByUser", userId);
			return alerts;
		}
	}

	@Override
	public void markAsChecked(int alertId) throws Exception {
		try (SqlSession session = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
            session.update("mapper.alert.markAsChecked", alertId);
            session.commit();
        }
	}
	
	@Override
	public int insertAlert(Alert alert) throws Exception {
	    try (SqlSession session = sqlSessionFactory.openSession()) {
	        int result = session.insert("mapper.alert.insertAlert", alert);
	        session.commit();
	        return result;
	    }
	}
	
}
