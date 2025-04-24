package controller.user;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import dto.user.Review;
import service.user.ReviewService;
import service.user.ReviewServiceImpl;

/**
 * Servlet implementation class ReviewModify
 */
@WebServlet("/myReviewModify")
public class ReviewModify extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private ReviewService service = new ReviewServiceImpl();
       
    
    public ReviewModify() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			int reviewId = Integer.parseInt(request.getParameter("reviewId"));
			Review review = service.getReviewById(reviewId); // 서비스에서 리뷰 1개 조회 메서드 필요

			request.setAttribute("review", review);
			request.getRequestDispatcher("/user/myReviewModify.jsp").forward(request, response);
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("err", "리뷰 정보를 불러오는데 실패했습니다.");
			request.getRequestDispatcher("/error.jsp").forward(request, response);
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String path = request.getServletContext().getRealPath("upload");
		int size = 10 * 1024 * 1024;

		try {

			MultipartRequest multi = new MultipartRequest(request, path, size, "utf-8", new DefaultFileRenamePolicy());

			int reviewId = Integer.parseInt(multi.getParameter("reviewId"));
			int rating = Integer.parseInt(multi.getParameter("rating"));
			String content = multi.getParameter("content");

			// 새 이미지 선택 안하면 null, 기존 이미지 유지 처리
			String image = multi.getFilesystemName("image");
			if (image == null) {
				image = multi.getParameter("originalImage");
			}

			Review review = new Review();
			review.setReviewId(reviewId);
			review.setRating(rating);
			review.setContent(content);
			review.setImage(image);

			service.updateReview(review);

			// 수정 후 목록으로 이동
			response.sendRedirect("myReviewList");

		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("err", "리뷰 수정 중 오류가 발생했습니다.");
			request.getRequestDispatcher("/error.jsp").forward(request, response);
		}
	}
}