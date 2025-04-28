package controller.common;

import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import dto.user.Notice;
import service.user.NoticeService;
import service.user.NoticeServiceImpl;

@WebServlet("/noticeModify")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024,     // 1MB
    maxFileSize       = 5 * 1024 * 1024, // 5MB
    maxRequestSize    = 20 * 1024 * 1024 // 20MB
)
public class NoticeModify extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private NoticeService noticeService;

    @Override
    public void init() throws ServletException {
        noticeService = new NoticeServiceImpl();
    }

    // 수정 폼 열기 (GET)
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String idParam = req.getParameter("noticeId");
        if (idParam == null || !idParam.matches("\\d+")) {
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "잘못된 공지 ID입니다.");
            return;
        }
        try {
            int noticeId = Integer.parseInt(idParam);
            Notice notice = noticeService.getNoticeById(noticeId);
            if (notice == null) {
                resp.sendError(HttpServletResponse.SC_NOT_FOUND, "해당 공지를 찾을 수 없습니다.");
                return;
            }
            req.setAttribute("notice", notice);
            req.getRequestDispatcher("/common/noticeModify.jsp")
               .forward(req, resp);
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("errorMessage", "공지사항 조회 중 오류가 발생했습니다.");
            req.getRequestDispatcher("/common/error.jsp")
               .forward(req, resp);
        }
    }

    // 수정 처리 (POST)
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        try {
            String idParam = req.getParameter("noticeId");
            if (idParam == null || !idParam.matches("\\d+")) {
                resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "잘못된 공지 ID입니다.");
                return;
            }
            int noticeId = Integer.parseInt(idParam);

            // 기존 이미지명
            String oldImage = req.getParameter("oldImage");

            Notice notice = new Notice();
            notice.setNoticeId(noticeId);
            notice.setTitle(req.getParameter("title"));
            notice.setContent(req.getParameter("content"));

            // 파일 업로드 여부
            Part filePart = req.getPart("imageFile");
            if (filePart != null && filePart.getSize() > 0) {
                String fileName = Paths.get(filePart.getSubmittedFileName())
                                       .getFileName().toString();
                String imagePath = getServletContext().getRealPath("/image");
                File dir = new File(imagePath);
                if (!dir.exists()) dir.mkdirs();
                filePart.write(imagePath + File.separator + fileName);
                notice.setImage(fileName);
            } else {
                notice.setImage(oldImage);
            }

            noticeService.updateNotice(notice);
            resp.sendRedirect(req.getContextPath() + "/notice");

        } catch (NumberFormatException nfe) {
            nfe.printStackTrace();
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "파라미터 형식이 올바르지 않습니다.");
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("errorMessage", "공지사항 수정 중 오류가 발생했습니다.");
            req.getRequestDispatcher("/common/error.jsp")
               .forward(req, resp);
        }
    }
}
