package controller.user;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dto.user.Review;
import service.user.ReviewService;
import service.user.ReviewServiceImpl;

/**
 * Servlet implementation class MyReview
 */
@WebServlet("/myReviewList")
public class MyReview extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private ReviewService service = new ReviewServiceImpl();

	public MyReview() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		try {
			// 세션에서 로그인한 사용자 ID 가져오기
			HttpSession session = request.getSession();
			String userId = (String) session.getAttribute("userId");
			System.out.println("userId = " + userId);
			if (userId == null || userId.trim().isEmpty()) {
				response.sendRedirect(request.getContextPath() +"/login");
				return;
			}

			// 내 리뷰 목록 조회
			List<Review> reviewList = service.getMyReviews(userId);
			System.out.println("리뷰 개수 = " + reviewList.size());
			// request 영역에 저장 후 포워딩
			request.setAttribute("reviewList", reviewList);
			request.getRequestDispatcher("/user/myReviewList.jsp").forward(request, response);
			System.out.println("리뷰 개수 = " + reviewList.size());
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("err", "리뷰 목록을 불러오는 중 오류가 발생했습니다.");
			request.getRequestDispatcher("/error.jsp").forward(request, response);
		}
	}

}
