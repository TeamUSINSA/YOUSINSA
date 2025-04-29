package controller.user;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dto.user.RestockRequest;
import service.user.MyRestockRequestService;
import service.user.MyRestockRequestServiceImpl;

/**
 * Servlet implementation class MyRestockRequest
 */
@WebServlet("/myRestockRequest")
public class MyRestockRequest extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private MyRestockRequestService service = new MyRestockRequestServiceImpl();

	public MyRestockRequest() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String userId = (String) request.getSession().getAttribute("userId");
		if (userId == null) {
			response.sendRedirect(request.getContextPath() + "/login");
			return;
		}
		
		try {
			List<RestockRequest> list = service.getMyRestockRequests(userId);
			System.out.println("▶▶ Restock list size: " + list.size());
			for (RestockRequest r : list) {
			  System.out.println(r.getRequestId() + " / " + r.getName() + " / " + r.getStock());
			}
			request.setAttribute("restockList", list);
			request.getRequestDispatcher("/user/myRestockRequest.jsp").forward(request, response);
		} catch (Exception e) {
			e.printStackTrace();
			throw new ServletException("재입고 신청 목록 조회 실패", e);
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		String userId = (String) request.getSession().getAttribute("userId");
		if (userId == null) {
			response.sendRedirect(request.getContextPath() + "/login");
			return;
		}
		String action = request.getParameter("action");
		try {
			if ("cancel".equals(action)) {
				int requestId = Integer.parseInt(request.getParameter("requestId"));
				service.cancelRestockRequest(requestId);
			} else { // 기본: 신규 신청
				RestockRequest r = new RestockRequest();
				r.setProductId(Integer.parseInt(request.getParameter("productId")));
				r.setUserId(userId);
				r.setSize(request.getParameter("size"));
				r.setColor(request.getParameter("color"));
				service.requestRestock(r);
			}
			response.sendRedirect(request.getContextPath() + "/myRestockRequest");
		} catch (Exception e) {
			e.printStackTrace();
			throw new ServletException("재입고 신청 처리 실패", e);
		}
	}
}