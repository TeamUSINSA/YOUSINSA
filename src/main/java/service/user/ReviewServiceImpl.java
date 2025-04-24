package service.user;

import java.util.List;

import dao.user.MyReviewDAO;
import dao.user.MyReviewDAOImpl;
import dto.user.Review;
import service.order.OrderService;
import service.order.OrderServiceImpl;

public class ReviewServiceImpl implements ReviewService {
	private MyReviewDAO reviewDAO = new MyReviewDAOImpl();
	private OrderService orderService = new OrderServiceImpl();

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

	@Override
	public boolean canWriteReview(String userId, int orderItemId) throws Exception {
		// 1) 그 orderItem이 userId의 것이고 status가 '배송완료'인지 확인
        var orders = orderService.getOrdersWithItemsByUserId(userId);
        boolean delivered = orders.stream()
            .flatMap(o -> o.getItems().stream())
            .filter(i -> i.getOrderItemId() == orderItemId)
            .anyMatch(i -> "배송완료".equals(i.getStatus()));
        if (!delivered) return false;

        // 2) 아직 리뷰가 한 건도 없으면 true
        return reviewDAO.countReviewByOrderItem(orderItemId) == 0;
	}

	@Override
	public boolean hasReview(int orderItemId) throws Exception {
		return reviewDAO.countReviewsByOrderItemId(orderItemId) > 0;
	}
	
}
