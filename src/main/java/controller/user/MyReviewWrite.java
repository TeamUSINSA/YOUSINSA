package controller.user;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import dto.order.OrderItem;
import dto.order.OrderList;
import dto.user.Review;
import service.order.OrderService;
import service.order.OrderServiceImpl;
import service.user.ReviewService;
import service.user.ReviewServiceImpl;

/**
 * Servlet implementation class MyReviewWrite
 */
@WebServlet("/myReviewWrite")
public class MyReviewWrite extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private ReviewService reviewService = new ReviewServiceImpl();
	private OrderService orderService = new OrderServiceImpl();

	public MyReviewWrite() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		HttpSession session = request.getSession();
		String userId = (String) session.getAttribute("userId");

		if (userId == null) {
			response.sendRedirect(request.getContextPath() + "/login");
			return;
		}
		
//		userId = (String) request.getSession().getAttribute("userId");
		int orderId = Integer.parseInt(request.getParameter("orderId"));
		int orderItemId = Integer.parseInt(request.getParameter("orderItemId"));
		int productId = Integer.parseInt(request.getParameter("productId"));

		try {
			// 1) 권한 체크 (배송완료 여부 등)
			if (!reviewService.canWriteReview(userId, orderItemId)) {
				response.sendRedirect(request.getContextPath() + "/myOrders");
				return;
			}

			// 2) 기존 getOrderDetailById(orderId) 재활용
            OrderList order = orderService.getOrderDetail(orderId);
            // 3) items 에서 해당 orderItemId 만 골라내기
            OrderItem target = null;
            for ( OrderItem it : order.getItems() ) {
                if ( it.getOrderItemId() == orderItemId ) {
                    target = it;
                    break;
                }
            }
            if (target == null) {
                response.sendRedirect(request.getContextPath() + "/myOrders");
                return;
            }
            
            // 4) JSP 에 넘겨주기
            request.setAttribute("item", target);
            request.getRequestDispatcher("/user/myReviewWrite.jsp")
                   .forward(request, response);
        } catch (Exception e) {
        	e.printStackTrace();
            throw new ServletException(e);
        }
    }

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String path = request.getServletContext().getRealPath("upload");
		int size = 10 * 1024 * 1024;

		try {
			MultipartRequest multi = new MultipartRequest(request, path, size, "UTF-8", new DefaultFileRenamePolicy());

			// 세션에서 userId 가져오기
			HttpSession session = request.getSession(false);
			String userId = (String) session.getAttribute("userId");

			// 폼 필드 꺼내기
			int productId = Integer.parseInt(multi.getParameter("productId"));
			int orderItemId = Integer.parseInt(multi.getParameter("orderItemId"));
			int rating = Integer.parseInt(multi.getParameter("rating"));
			String content = multi.getParameter("content");

			// 업로드된 파일명 (없으면 null)
			String image = multi.getFilesystemName("image");

			// DTO에 세팅
			Review review = new Review();
			review.setUserId(userId);
			review.setProductId(productId);
			review.setOrderItemId(orderItemId);
			review.setRating(rating);
			review.setContent(content);
			review.setImage(image);

			// DB에 저장

			reviewService.writeReview(review);
			response.sendRedirect("myReviewList");
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("err", "리뷰 작성시 오류가 발생했습니다.");
			request.getRequestDispatcher("error.jsp").forward(request, response);
		}
	}
}
