package service.user;

import java.util.List;

import dto.user.Review;

public interface ReviewService {
	void writeReview(Review review) throws Exception;
	List<Review> getMyReviews(String userId) throws Exception;
	Review getReviewById(int reviewId) throws Exception;
	void updateReview(Review review) throws Exception;
	void deleteReview(int reviewId) throws Exception;
	/** 특정 주문 아이템에 대해 후기를 쓸 수 있는지 (배송완료＋아직 작성 전) */
    boolean canWriteReview(String userId, int orderItemId) throws Exception;
    // 리뷰 썼는지 체크
    boolean hasReview(int orderItemId) throws Exception;
}
