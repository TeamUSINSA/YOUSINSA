package controller.user;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dto.user.LikeList;
import service.user.LikeService;
import service.user.LikeServiceImpl;
import utils.PageInfo;

@WebServlet("/myLikeList")
public class MyLikeList extends HttpServlet {
	private static final long serialVersionUID = 1L;
	

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		LikeService likeService = new LikeServiceImpl();
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");

        HttpSession session = request.getSession(false);
        String userId = (session != null) ? (String) session.getAttribute("userId") : null;
        if (userId == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        int page = 1;
        int pageSize = 5;
        if (request.getParameter("page") != null) {
            try {
                page = Integer.parseInt(request.getParameter("page"));
            } catch (NumberFormatException e) {
                page = 1;
            }
        }

        try {
            int totalCount = likeService.countLikedProducts(userId);
            int allPage = (int) Math.ceil((double) totalCount / pageSize);
            int startPage = ((page - 1) / 5) * 5 + 1;
            int endPage = Math.min(startPage + 4, allPage);

            PageInfo pageInfo = new PageInfo();
            pageInfo.setCurPage(page);
            pageInfo.setAllPage(allPage);
            pageInfo.setStartPage(startPage);
            pageInfo.setEndPage(endPage);

            int offset = (page - 1) * pageSize;
            List<LikeList> likeList = likeService.getLikedProductsByUserId(userId, offset, pageSize);

            // 필터링: 빈 이미지 또는 이름이 없는 항목 제거
            likeList.removeIf(item ->
                item.getMainImage1() == null || item.getMainImage1().trim().isEmpty()
             || item.getName()       == null || item.getName().trim().isEmpty()
            );

            request.setAttribute("likeList", likeList);
            request.setAttribute("pageInfo", pageInfo);
            request.getRequestDispatcher("/user/mylikelist.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }
    }


	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		LikeService likeService = new LikeServiceImpl();
		request.setCharacterEncoding("utf-8");
        response.setContentType("text/html; charset=UTF-8");
        response.setCharacterEncoding("UTF-8");
		doGet(request, response);
	}
}
