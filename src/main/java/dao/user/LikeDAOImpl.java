// src/main/java/dao/user/LikeDAOImpl.java
package dao.user;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import org.apache.ibatis.session.SqlSessionFactory;

import dto.user.LikeList;

import utils.MybatisSqlSessionFactory;
import dto.user.LikeList;

public class LikeDAOImpl implements LikeDAO {

	private SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();

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
	public boolean existsLike(String userId, int productId) throws Exception {
		Map<String, Object> param = new HashMap<>();
		param.put("userId", userId);
		param.put("productId", productId);
		return sqlSession.selectOne("mapper.productdetail.existsLike", param);
	}

	@Override
	public void deleteLikeById(int likeId) throws Exception {
		try {
			sqlSession.delete("mapper.user.deleteLikeById", likeId);
			sqlSession.commit();
		} catch (Exception e) {
			sqlSession.rollback(); // 예외 발생 시 롤백
			e.printStackTrace();
			throw e; // 다시 던져서 서블릿에서 처리할 수 있게
		}
	}

	@Override
	public void insertLike(String userId, int productId) throws Exception {
		Map<String, Object> param = new HashMap<>();
		param.put("userId", userId);
		param.put("productId", productId);
		sqlSession.insert("mapper.productdetail.insertLike", param);
		sqlSession.commit();
	}

	@Override
	public void deleteLike(String userId, int productId) throws Exception {
		Map<String, Object> param = new HashMap<>();
		param.put("userId", userId);
		param.put("productId", productId);
		sqlSession.delete("mapper.productdetail.deleteLike", param);
		sqlSession.commit();
	}

	@Override
    public int countLikes(int productId) throws Exception {
        return sqlSession.selectOne("mapper.productdetail.countLikesByProductId", productId);
    }

}
