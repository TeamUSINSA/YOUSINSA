package controller.user;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import dto.user.LikeList;
import service.user.LikeService;
import service.user.LikeServiceImpl;

/**
 * Servlet implementation class LoadMoreLikes
 */
@WebServlet("/loadMoreLikes")
public class LoadMoreLikes extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public LoadMoreLikes() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		LikeService likeService = new LikeServiceImpl();
		try {
		      String userId      = request.getParameter("userId");
		      String offsetParam = request.getParameter("offset");
		      String limitParam  = request.getParameter("limit");

		      int offset = 0;
		      if (offsetParam != null && !offsetParam.trim().isEmpty()) {
		        try { offset = Math.max(0, Integer.parseInt(offsetParam)); }
		        catch(NumberFormatException ignored){}
		      }

		      int limit = 1;
		      if (limitParam != null && !limitParam.trim().isEmpty()) {
		        try { limit = Integer.parseInt(limitParam); }
		        catch(NumberFormatException ignored){}
		      }

		      List<LikeList> moreLikes = likeService.getLikedProductsByUserId(userId, offset, limit);

		      // ↓ 필터링 추가: productId, mainImage1, name이 모두 유효할 때만 남긴다
		      moreLikes.removeIf(item ->
		      // productId가 1 이상이 아니면 제거 (optional)
		      item.getProductId() <= 0
		   || item.getMainImage1() == null
		   || item.getMainImage1().trim().isEmpty()
		   || item.getName() == null
		   || item.getName().trim().isEmpty()
		 );

		      response.setContentType("application/json;charset=UTF-8");
		      new Gson().toJson(moreLikes, response.getWriter());

		    } catch (Exception e) {
		      e.printStackTrace();
		      response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
		    }
		  }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
