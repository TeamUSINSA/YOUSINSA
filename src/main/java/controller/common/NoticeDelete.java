package controller.common;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import service.user.NoticeService;
import service.user.NoticeServiceImpl;

@WebServlet("/noticeDelete")
public class NoticeDelete extends HttpServlet {
    private static final long serialVersionUID = 1L;


    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    	request.setCharacterEncoding("UTF-8");
        NoticeService noticeService = new NoticeServiceImpl();
        
        try {
            String idParam = request.getParameter("noticeId");
            int noticeId = Integer.parseInt(idParam);
            noticeService.deleteNotice(noticeId);  // throws Exception
            response.sendRedirect(request.getContextPath() + "/notice");
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "공지사항 삭제 중 오류가 발생했습니다.");
            request.getRequestDispatcher("/common/error.jsp")
                   .forward(request, response);
        }
    }

}
