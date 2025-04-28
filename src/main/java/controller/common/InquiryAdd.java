package controller.common;

import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import java.util.UUID;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import dto.user.Inquiry;
import service.user.InquiryService;
import service.user.InquiryServiceImpl;

@WebServlet("/inquiryAdd")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024,    // 1MB 넘으면 디스크에 임시 저장
    maxFileSize       = 5 * 1024 * 1024, // 업로드 최대 5MB
    maxRequestSize    = 10 * 1024 * 1024 // 요청 최대 10MB
)
public class InquiryAdd extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private InquiryService inquiryService = new InquiryServiceImpl();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession(false);
        String userId = (session != null) ? (String) session.getAttribute("userId") : null;
        if (userId == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        // 1) 폼 데이터
        int productId = Integer.parseInt(request.getParameter("productId"));
        String title   = request.getParameter("title");
        String content = request.getParameter("content");

     // 2) 이미지 파일 처리
        Part imagePart = request.getPart("image");
        String filename = null;
        if (imagePart != null && imagePart.getSize() > 0) {
            // 원본 파일명만 꺼내기
            String submitted = Paths
              .get(imagePart.getSubmittedFileName())
              .getFileName()
              .toString();

            filename = submitted;  // ← 여기만 변경 (UUID 제거)

            // 저장 디렉토리
            String imageDir = getServletContext().getRealPath("/image");
            File uploadDir = new File(imageDir);
            if (!uploadDir.exists()) uploadDir.mkdirs();

            // 원본명으로 저장
            imagePart.write(new File(uploadDir, filename).getAbsolutePath());
        }


        // 3) DTO 구성
        Inquiry inq = new Inquiry();
        inq.setUserId(userId);
        inq.setProductId(productId);
        inq.setTitle(title);
        inq.setContent(content);
        inq.setImage(filename);      // 이미지 파일명 (or null)
        inq.setStatus("답변대기");

        // 4) 서비스 호출
        try {
            inquiryService.addInquiry(inq);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("err", "문의 등록 중 오류 발생");
            request.getRequestDispatcher("/error.jsp").forward(request, response);
            return;
        }

        // 5) 리다이렉트
        response.sendRedirect(
            request.getContextPath() +
            "/productDetail?productId=" + productId
        );
    }
}
