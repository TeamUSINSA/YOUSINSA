package service.user;

import java.util.List;

import dto.user.Review;

public interface ReviewService {
	void writeReview(Review review) throws Exception;
	List<Review> getMyReviews(String userId) throws Exception;
	Review getReviewById(int reviewId) throws Exception;
	void updateReview(Review review) throws Exception;
	void deleteReview(int reviewId) throws Exception;
}
