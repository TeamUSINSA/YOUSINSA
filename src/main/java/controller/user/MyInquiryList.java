package controller.user;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dto.user.Inquiry;
import service.user.MyInquiryService;
import service.user.MyInquiryServiceImpl;
import utils.PageInfo;

@WebServlet("/myInquiryList")
public class MyInquiryList extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private MyInquiryService inquiryService = new MyInquiryServiceImpl();

	public MyInquiryList() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		HttpSession session = request.getSession(false);
		if (session == null || session.getAttribute("userId") == null) {
			response.sendRedirect(request.getContextPath() + "/login");
			return;
		}
		String userId = (String) session.getAttribute("userId");
		int page = 1;
		String param = request.getParameter("page");
		if (param != null) {
			try {
				page = Integer.parseInt(param);
			} catch (NumberFormatException e) {
			}
		}
		PageInfo pageInfo = new PageInfo(page);
		try {
			List<Inquiry> list = inquiryService.getInquiriesByUserId(userId, pageInfo);
			request.setAttribute("inquiryList", list);
			request.setAttribute("pageInfo", pageInfo);
			request.getRequestDispatcher("/user/myInquiryList.jsp").forward(request, response);
		} catch (Exception e) {
			e.printStackTrace();
			throw new ServletException("문의 내역 조회 중 오류 발생", e);
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// 로그인 체크
		HttpSession session = request.getSession(false);
		String userId = (String) session.getAttribute("userId");
		if (userId == null) {
			response.sendRedirect(request.getContextPath() + "/login");
			return;
		}

		// action 파라미터로 분기
		String action = request.getParameter("action");
		int inquiryId = Integer.parseInt(request.getParameter("inquiryId"));

		try {
			if ("delete".equals(action)) {
				// 삭제
				inquiryService.deleteInquiry(userId, inquiryId);
			} else if ("update".equals(action)) {
				// 수정
				Inquiry inq = new Inquiry();
				inq.setInquiryId(inquiryId);
				inq.setUserId(userId);
				inq.setTitle(request.getParameter("title"));
				inq.setContent(request.getParameter("content"));
				inquiryService.updateInquiry(inq);
			}
			// 처리 끝나면 목록으로 리다이렉트
			response.sendRedirect(request.getContextPath() + "/myInquiryList");
		} catch (Exception e) {
			throw new ServletException("1:1 문의 처리 중 오류", e);
		}
	}

}
