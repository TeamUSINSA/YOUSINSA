package dao.user;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import dto.user.Review;
import utils.MybatisSqlSessionFactory;

public class MyReviewDAOImpl implements MyReviewDAO{
	private SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();

	@Override
	public void insertReview(Review review) throws Exception{
		sqlSession.insert("mapper.user.insertReview",review);
		sqlSession.commit();
	}

	@Override
	public List<Review> getReviewsByUserId(String userId) {
		try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
	        return sqlSession.selectList("mapper.user.getReviewsByUserId", userId);
	    }
	}

	@Override
	public Integer selectReviewCount() throws Exception {
		return sqlSession.selectOne("mapper.user.selectReviewCount");
	}

	@Override
	public Review getReviewById(int reviewId) throws Exception {
		return sqlSession.selectOne("mapper.user.getReviewById", reviewId);
	}

	@Override
	public void updateReview(Review review) throws Exception {
		sqlSession.update("mapper.user.updateReview", review);
	    sqlSession.commit();
	}

	@Override
	public void deleteReview(int reviewId) throws Exception {
		sqlSession.delete("mapper.user.deleteReview", reviewId);
		sqlSession.commit();
	}

	@Override
	public int countReviewByOrderItem(int orderItemId) throws Exception {
		return sqlSession.selectOne("mapper.user.countReviewByOrderItem", orderItemId);
	}

	@Override
	public int countReviewsByOrderItemId(int orderItemId) throws Exception {
		return sqlSession.selectOne("mapper.user.countReviewByOrderItem", orderItemId);
	}

}
