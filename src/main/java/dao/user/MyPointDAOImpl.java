package dao.user;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import dto.user.Point;
import utils.MybatisSqlSessionFactory;

public class MyPointDAOImpl implements MyPointDAO {

	@Override
    public void insertPoint(Point point) throws Exception {
        try (SqlSession session = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
            session.insert("mapper.user.PointMapper.insertPoint", point);
            session.commit();
        }
    }

    @Override
    public void updateUserTotalPoint(String userId, int point) throws Exception {
        try (SqlSession session = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
            Map<String, Object> param = new HashMap<>();
            param.put("userId", userId);
            param.put("point", point);
            session.update("mapper.user.PointMapper.updateUserTotalPoint", param);
            session.commit();
        }
    }

    @Override
    public List<Point> getPointsByDate(Map<String, Object> map) throws Exception {
        try (SqlSession session = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
            return session.selectList("mapper.user.PointMapper.getPointsByDate", map);
        }
    }

    @Override
    public int getTotalPoint(String userId) throws Exception {
        try (SqlSession session = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
            return session.selectOne("mapper.user.PointMapper.getTotalPoint", userId);
        }
    }

	@Override
	public List<Point> getPointsByUserAndDate(Map<String, Object> paramMap) throws Exception {
		try (SqlSession session = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
            return session.selectList("mapper.user.getPointsByUserAndDate", paramMap);
        }
    }
}