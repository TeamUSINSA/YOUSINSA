package controller.user;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dto.user.Inquiry;
import service.user.MyInquiryService;
import service.user.MyInquiryServiceImpl;

@WebServlet("/myInquiryEdit")
public class MyInquiryEdit extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private MyInquiryService inquiryService = new MyInquiryServiceImpl();

    public MyInquiryEdit() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String userId = (String) request.getSession().getAttribute("userId");
        if (userId == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        int id;
        try {
            id = Integer.parseInt(request.getParameter("id"));
        } catch (NumberFormatException e) {
        	e.printStackTrace();
            throw new ServletException("잘못된 문의 번호입니다.", e);
        }

        try {
            Inquiry inq = inquiryService.getInquiryById(userId, id);
            request.setAttribute("inq", inq);
            request.getRequestDispatcher("/user/inquiryEdit.jsp")
                   .forward(request, response);
        } catch (Exception e) {
        	e.printStackTrace();
            throw new ServletException("문의 단건 조회 중 오류 발생", e);
        }
    }
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String userId = (String) request.getSession().getAttribute("userId");
        if (userId == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        int id;
        try {
            id = Integer.parseInt(request.getParameter("inquiryId"));
        } catch (NumberFormatException e) {
        	e.printStackTrace();
            throw new ServletException("잘못된 문의 번호입니다.", e);
        }

        // 폼 입력값
        String title   = request.getParameter("title");
        String content = request.getParameter("content");

        Inquiry inq = new Inquiry();
        inq.setInquiryId(id);
        inq.setUserId(userId);
        inq.setTitle(title);
        inq.setContent(content);

        try {
            inquiryService.updateInquiry(inq);
            response.sendRedirect(request.getContextPath() + "/myInquiryList");
        } catch (Exception e) {
        	e.printStackTrace();
            throw new ServletException("문의 수정 처리 중 오류 발생", e);
        }
    }
}