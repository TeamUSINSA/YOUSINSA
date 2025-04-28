package dao.user;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import utils.MybatisSqlSessionFactory;

public class AlertDAOImpl implements AlertDAO{

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

	   
}
