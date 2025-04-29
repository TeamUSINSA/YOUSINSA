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
	private LikeService likeService = new LikeServiceImpl();
       
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
		try {
			String userId = request.getParameter("userId");
			String offsetParam = request.getParameter("offset");
			int offset = 0; // 기본값

			try {
			    if (offsetParam != null && !offsetParam.trim().isEmpty()) {
			        offset = Integer.parseInt(offsetParam);
			        if (offset < 0) offset = 0; //offset 음수일경우 처리
			    }
			} catch (NumberFormatException e) {
			    e.printStackTrace(); // 또는 로그 처리
			    // 잘못된 요청에 대한 기본 처리 (예: offset = 0 또는 에러 리턴)
			    offset = 0;
			}
			//limit도 똑같이 처리
			String limitParam = request.getParameter("limit");
			int limit = 1;
			if (limitParam != null && !limitParam.trim().isEmpty()) {
				limit = Integer.parseInt(limitParam);
			}

			List<LikeList> moreLikes = likeService.getLikedProductsByUserId(userId, offset, limit);

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
