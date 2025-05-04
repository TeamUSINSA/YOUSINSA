package controller.user;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dto.user.QnA;
import service.user.QNAService;
import service.user.QNAServiceImpl;

@WebServlet("/myQnADetail")
public class MyQnADetail extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public MyQnADetail() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		QNAService qnaService = new QNAServiceImpl();
		
		HttpSession session = request.getSession(false);
		String userId = (session != null) ? (String) session.getAttribute("userId") : null;

		int qnaId = Integer.parseInt(request.getParameter("id"));

		try {
			QnA qna = qnaService.getQnAById(qnaId);
			request.setAttribute("qna", qna);
			request.getRequestDispatcher("/user/myQnADetail.jsp").forward(request, response);
		} catch (Exception e) {
			e.printStackTrace();
			response.sendRedirect(request.getContextPath() + "/myQnAList");
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
