//package controller.user;
//
//import java.io.IOException;
//
//import javax.servlet.ServletException;
//import javax.servlet.annotation.WebServlet;
//import javax.servlet.http.HttpServlet;
//import javax.servlet.http.HttpServletRequest;
//import javax.servlet.http.HttpServletResponse;
//
//import com.oreilly.servlet.MultipartRequest;
//import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;
//
//import dto.product.Product;
//import dto.user.Review;
//import service.user.ReviewService;
//import service.user.ReviewServiceImpl;
//
///**
// * Servlet implementation class MyReviewWrite
// */
//@WebServlet("/myReviewWrite")
//public class MyReviewWrite extends HttpServlet {
//	private static final long serialVersionUID = 1L;
//    
//    public MyReviewWrite() {
//        super();
//    }
//
//	
//	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//		Product product = productService.getProductById(productId);
//		request.setAttribute("product", product);
//		request.getRequestDispatcher("/user/myReviewWrite.jsp").forward(request, response);
//	}
//
//	
//	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//
//		String path = request.getServletContext().getRealPath("upload");
//		int size = 10*1024*1024;
//		
//		MultipartRequest multi = new MultipartRequest(request, path,size,"utf-8", new DefaultFileRenamePolicy());
//		
//		String userId = (String) request.getSession().getAttribute("userId");
//		int productId = Integer.parseInt(multi.getParameter("productId"));
//		int rating = Integer.parseInt(multi.getParameter("rating")); 
//		String content = multi.getParameter("content");
//		String image = multi.getFilesystemName("image");
//		
//		Review review = new Review(content,image,userId,productId,rating);
//		
//		ReviewService service = new ReviewServiceImpl();
//		try {
//		    service.writeReview(review);
//		    response.sendRedirect("myReviewList");
//		} catch (Exception e) {
//		    e.printStackTrace();
//		    request.setAttribute("err", "리뷰 작성시 오류가 발생했습니다.");
//		    request.getRequestDispatcher("error.jsp").forward(request, response);
//		}    
//	}
//}
