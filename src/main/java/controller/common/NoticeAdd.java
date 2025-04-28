package controller.common;

import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import javax.servlet.ServletException;
import javax.servlet.annotation.*;
import javax.servlet.http.*;

import dto.user.Notice;
import service.user.NoticeService;
import service.user.NoticeServiceImpl;

@WebServlet("/noticeAdd")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024,    // 1MB
    maxFileSize       = 5 * 1024 * 1024, // 5MB
    maxRequestSize    = 20 * 1024 * 1024 // 20MB
)
public class NoticeAdd extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private NoticeService noticeService;

    @Override
    public void init() throws ServletException {
        noticeService = new NoticeServiceImpl();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setAttribute("notice", new Notice());
        request.getRequestDispatcher("/common/noticeAdd.jsp")
               .forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        try {
            Notice notice = new Notice();
            notice.setTitle(request.getParameter("title"));
            notice.setContent(request.getParameter("content"));

            Part filePart = request.getPart("imageFile");
            if (filePart != null && filePart.getSize() > 0) {
                String fileName = Paths.get(filePart.getSubmittedFileName())
                                       .getFileName().toString();
                String imageDir = getServletContext().getRealPath("/image");
                File dir = new File(imageDir);
                if (!dir.exists()) dir.mkdirs();
                filePart.write(imageDir + File.separator + fileName);
                notice.setImage(fileName);
            }

            noticeService.createNotice(notice);
            response.sendRedirect(request.getContextPath() + "/notice");
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "공지사항 등록 중 오류가 발생했습니다.");
            request.getRequestDispatcher("/common/error.jsp")
                   .forward(request, response);
        }
    }
}
