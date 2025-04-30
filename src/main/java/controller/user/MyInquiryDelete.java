package controller.user;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import service.user.MyInquiryService;
import service.user.MyInquiryServiceImpl;

/**
 * Servlet implementation class MyInquiryDelete
 */
@WebServlet("/inquiryDelete")
public class MyInquiryDelete extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private MyInquiryService service = new MyInquiryServiceImpl();

    public MyInquiryDelete() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		 // 로그인 체크
        HttpSession session = request.getSession(false);
        String userId = (session != null) 
                        ? (String)session.getAttribute("userId")
                        : null;
        if (userId == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        // 파라미터에서 id 파싱
        String param = request.getParameter("id");
        int inquiryId;
        try {
            inquiryId = Integer.parseInt(param);
        } catch (NumberFormatException e) {
        	e.printStackTrace();
            throw new ServletException("잘못된 문의 ID입니다.", e);
        }

        // 삭제 처리
        try {
            service.deleteInquiry(userId, inquiryId);
            // 목록으로 리다이렉트
            response.sendRedirect(request.getContextPath() + "/myInquiryList");
        } catch (Exception e) {
        	e.printStackTrace();
            throw new ServletException("문의 삭제 중 오류 발생", e);
        }
    }
}