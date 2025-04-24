package controller.user;

import java.io.File;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dto.user.Review;
import service.user.ReviewService;
import service.user.ReviewServiceImpl;


@WebServlet("/deleteReview")
public class myReviewDelete extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private ReviewService service = new ReviewServiceImpl();
       
    
    public myReviewDelete() {
        super();
    }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			// 리뷰 ID 파라미터 검증
			String reviewIdParam = request.getParameter("reviewId");
			if (reviewIdParam == null || reviewIdParam.trim().isEmpty()) {
				throw new IllegalArgumentException("리뷰 ID가 제공되지 않았습니다.");
			}

			int reviewId = Integer.parseInt(reviewIdParam);

			// 리뷰 존재 확인
			Review review = service.getReviewById(reviewId);
			if (review == null) {
				System.out.println("❌ 해당 리뷰가 존재하지 않습니다: reviewId = " + reviewId);
				response.sendError(HttpServletResponse.SC_NOT_FOUND, "리뷰가 존재하지 않습니다.");
				return;
			}
			System.out.println("✅ 삭제할 리뷰: " + review.getReviewId() + ", 이미지: " + review.getImage());

			// DB에서 리뷰 삭제
			service.deleteReview(reviewId);
			System.out.println("🗑️ 리뷰 DB 삭제 완료");

			// 이미지 파일 삭제
			String imageName = review.getImage();
			if (imageName != null && !imageName.trim().isEmpty()) {
				String uploadDir = request.getServletContext().getRealPath("upload");
				File imageFile = new File(uploadDir, imageName);
				System.out.println("📂 이미지 경로: " + imageFile.getAbsolutePath());

				if (imageFile.exists()) {
					if (imageFile.delete()) {
						System.out.println("✅ 이미지 파일 삭제 성공");
					} else {
						System.out.println("❌ 이미지 파일 삭제 실패");
					}
				} else {
					System.out.println("⚠️ 이미지 파일이 존재하지 않음 (이미 삭제되었을 수도 있음)");
				}
			}

			// 완료 후 목록 페이지로 리디렉션
			response.sendRedirect("myReviewList");

		} catch (NumberFormatException e) {
			e.printStackTrace();
			request.setAttribute("err", "잘못된 리뷰 ID 형식입니다.");
			request.getRequestDispatcher("/error.jsp").forward(request, response);

		} catch (IllegalArgumentException e) {
			e.printStackTrace();
			request.setAttribute("err", e.getMessage());
			request.getRequestDispatcher("/error.jsp").forward(request, response);

		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("err", "리뷰 삭제 중 예기치 못한 오류가 발생했습니다.");
			request.getRequestDispatcher("/error.jsp").forward(request, response);
		}
	}
}