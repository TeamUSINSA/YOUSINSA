package dao.user;

import java.util.HashMap;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import dto.user.Point;
import utils.MybatisSqlSessionFactory;

public class PointDAOImpl implements PointDAO {

    private final SqlSession sqlSession;

    public PointDAOImpl() {
        // auto-commit 모드로 열기
        this.sqlSession = MybatisSqlSessionFactory
                              .getSqlSessionFactory()
                              .openSession(true);
    }

    /**
     * 포인트 히스토리 기록 → user.total_point 업데이트
     * @param p Point.point 에는 (음수=사용, 양수=적립) 값
     */
    @Override
    public void savePoint(Point p) throws Exception {

        sqlSession.insert("mapper.point.insertPointHistory", p);

        Map<String,Object> params = new HashMap<>();
        params.put("userId", p.getUserId());
        params.put("delta",  p.getPoint()); 

        sqlSession.update("mapper.point.updateUserTotalPoint", params);
    }
}
