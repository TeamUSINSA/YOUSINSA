package dao.user;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import dto.user.LikeList;
import utils.MybatisSqlSessionFactory;

public class LikeDAOImpl implements LikeDAO {
	SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();

	@Override
	public List<LikeList> getLikedProductsByUserId(String userId, int offset, int limit) throws Exception {
		Map<String, Object> param = new HashMap<>();
		param.put("userId", userId);
		param.put("offset", offset);
		param.put("limit", limit);
		return sqlSession.selectList("mapper.user.selectLikedProducts", param);
	}

	@Override
	public int countLikedProducts(String userId) throws Exception {
		return sqlSession.selectOne("mapper.user.countLikedProducts", userId);

	}

	@Override
	public void deleteLikeById(int likeId) throws Exception {
		try {
	        sqlSession.delete("mapper.user.deleteLikeById", likeId);
	        sqlSession.commit(); // 이거 추가해야 DB 반영됨!
	    } catch (Exception e) {
	        sqlSession.rollback(); // 예외 발생 시 롤백
	        e.printStackTrace();
	        throw e; // 다시 던져서 서블릿에서 처리할 수 있게
	    }
}}