package controller.common;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dto.user.Notice;
import service.user.NoticeService;
import service.user.NoticeServiceImpl;

@WebServlet("/noticeDetail")
public class NoticeDetail extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    	request.setCharacterEncoding("UTF-8");
        NoticeService noticeService = new NoticeServiceImpl();
        
        String idParam = request.getParameter("noticeId");
        try {
            int noticeId = Integer.parseInt(idParam);
            Notice notice = noticeService.getNoticeById(noticeId);  // throws Exception
            request.setAttribute("notice", notice);
            request.getRequestDispatcher("/common/noticeDetail.jsp")
                   .forward(request, response);
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "잘못된 공지 ID입니다.");
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "공지사항 상세 조회 중 오류가 발생했습니다.");
            request.getRequestDispatcher("/common/error.jsp")
                   .forward(request, response);
        }
    }

}
