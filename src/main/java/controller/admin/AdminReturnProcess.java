package controller.admin;

import service.order.ReturnService;
import service.order.ReturnServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/adminReturnProcess")
public class AdminReturnProcess extends HttpServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		request.setCharacterEncoding("UTF-8");
		ReturnService returnService = new ReturnServiceImpl();

		try {
			// 1. 파라미터 받기
			int returnId = Integer.parseInt(request.getParameter("returnId"));
			String status = request.getParameter("refundStatus");
			String rejectReason = request.getParameter("refundReason");

			// 2. 상태에 따라 승인/반려 처리
			if ("허가".equals(status)) {
				returnService.approveReturn(returnId);
			} else if ("반려".equals(status)) {
				if (rejectReason == null || rejectReason.isEmpty()) {
					rejectReason = "기타";
				}
				returnService.rejectReturn(returnId, rejectReason);
			}

			// 3. 완료 후 목록 페이지로 이동
			response.sendRedirect(request.getContextPath() + "/adminReturn?status=all");

		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("errorMessage", "반품 처리 중 오류가 발생했습니다.");
			request.getRequestDispatcher("/error.jsp").forward(request, response);
		}
	}
}
