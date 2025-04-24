package service.user;

import java.util.List;

import dao.user.MyReviewDAO;
import dao.user.MyReviewDAOImpl;
import dto.user.Review;

public class ReviewServiceImpl implements ReviewService {
	private MyReviewDAO reviewDAO = new MyReviewDAOImpl();

	@Override
	public void writeReview(Review review) throws Exception {
		reviewDAO.insertReview(review);
	}

	@Override
	public List<Review> getMyReviews(String userId) throws Exception {
		return reviewDAO.getReviewsByUserId(userId);
	}

	@Override
	public Review getReviewById(int reviewId) throws Exception {
		return reviewDAO.getReviewById(reviewId);
	}

	@Override
	public void updateReview(Review review) throws Exception {
		reviewDAO.updateReview(review);
	}

	@Override
	public void deleteReview(int reviewId) throws Exception {
		reviewDAO.deleteReview(reviewId);
		
	}
	


	

}
