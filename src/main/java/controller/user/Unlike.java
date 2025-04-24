package controller.user;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import service.user.LikeService;
import service.user.LikeServiceImpl;

/**
 * Servlet implementation class Unlike
 */
@WebServlet("/unlike")
public class Unlike extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private LikeService likeService = new LikeServiceImpl();
	
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Unlike() {
        super();
        // TODO Auto-generated constructor stub
    }
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
            int likeId = Integer.parseInt(request.getParameter("likeId"));
            likeService.removeLike(likeId);
            System.out.println("likeId: " + likeId);
            response.setContentType("text/plain; charset=UTF-8");
            response.getWriter().write("success");
        } catch (Exception e) {
        	e.printStackTrace();
        	request.setAttribute("errorMessage", "좋아요 삭제 중 오류가 발생했습니다.");
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        }		
	}
}
