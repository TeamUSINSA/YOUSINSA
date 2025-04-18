package dao.user;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import dto.user.LikeList;
import utils.MybatisSqlSessionFactory;

public class LikeDAOImpl implements LikeDAO {
	SqlSession session = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();

	@Override
	public List<LikeList> getLikedProductsByUserId(String userId, int offset, int limit) throws Exception {
		Map<String, Object> param = new HashMap<>();
		param.put("userId", userId);
		param.put("offset", offset);
		param.put("limit", limit);
		return session.selectList("mapper.user.selectLikedProducts", param);
	}

	@Override
	public int countLikedProducts(String userId) throws Exception {
		return session.selectOne("mapper.user.countLikedProducts", userId);

	}

}