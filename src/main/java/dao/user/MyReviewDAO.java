package dao.user;

import java.util.List;

import dto.user.Review;

public interface MyReviewDAO {
	void insertReview(Review review) throws Exception;
	List<Review> getReviewsByUserId(String userId);
	Integer selectReviewCount() throws Exception;
	Review getReviewById(int reviewId) throws Exception; 
	void updateReview(Review review) throws Exception;
	void deleteReview(int reviewId) throws Exception;
}
