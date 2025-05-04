package controller.common;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dto.user.Notice;
import service.user.NoticeService;
import service.user.NoticeServiceImpl;

@WebServlet("/notice")
public class NoticeServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;


    // 오직 목록만 조회
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    	
    	request.setCharacterEncoding("UTF-8");
        NoticeService noticeService = new NoticeServiceImpl();
        try {
            List<Notice> notices = noticeService.getAllNotices();  // throws Exception
            request.setAttribute("notices", notices);
            request.getRequestDispatcher("/common/notice.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR,
                               "공지사항 목록을 불러오는 중 오류가 발생했습니다.");
        }
    }


}
