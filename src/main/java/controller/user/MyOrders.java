package controller.user;

import java.io.IOException;
import java.sql.Date;
import java.time.LocalDate;
import java.util.Calendar;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dto.order.Order;
import dto.order.OrderItem;
import service.order.OrderService;
import service.order.OrderServiceImpl;
import service.user.ReviewService;
import service.user.ReviewServiceImpl;

/**
 * Servlet implementation class MyOrders
 */
@WebServlet("/myOrders")
public class MyOrders extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private OrderService service = new OrderServiceImpl();
	private ReviewService reviewService = new ReviewServiceImpl();

	public MyOrders() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		HttpSession session = request.getSession();
		String userId = (String) session.getAttribute("userId");

		if (userId == null) {
			response.sendRedirect(request.getContextPath() + "/login");
			return;
		}

		try {
			// 날짜 필터 파라미터 처리
			String startYear = request.getParameter("startYear");
			String startMonth = request.getParameter("startMonth");
			String startDay = request.getParameter("startDay");
			String endYear = request.getParameter("endYear");
			String endMonth = request.getParameter("endMonth");
			String endDay = request.getParameter("endDay");

			List<Order> orderList;
			Date startDate;
			Date endDate;

			LocalDate today = LocalDate.now();
			LocalDate weekAgo = today.minusDays(7);

			if (startYear != null && startMonth != null && startDay != null && endYear != null && endMonth != null
					&& endDay != null) {
				String startStr = startYear + "-" + startMonth + "-" + startDay;
				String endStr = endYear + "-" + endMonth + "-" + endDay;
				startDate = Date.valueOf(startStr);
				endDate = Date.valueOf(endStr);

				if (startDate.after(endDate)) {
					Date temp = startDate;
					startDate = endDate;
					endDate = temp;
				}
			} else {
				// 날짜 필터 없을 때 전체 주문 목록 조회
				startDate = Date.valueOf(weekAgo);
				endDate = Date.valueOf(today);
			}

			orderList = service.getOrdersByDateRange(userId, startDate, endDate);
			// 상태별 개수 계산
			int countReady = 0;
			int countShipping = 0;
			int countComplete = 0;
			for (Order order : orderList) {
				for (OrderItem item : order.getItems()) {
					boolean alreadyReviewed = reviewService.hasReview(item.getOrderItemId());
					item.setHasReview(alreadyReviewed);
				}
			}

			for (Order order : orderList) {
				switch (order.getDeliveryStatus()) {
				case "배송준비중":
					countReady++;
					break;
				case "배송중":
					countShipping++;
					break;
				case "배송완료":
					countComplete++;
					break;
				}
			}

			// 기본값으로 현재 연도 전달
			int currentYear = Calendar.getInstance().get(Calendar.YEAR);
			request.setAttribute("todayYear", today.getYear());
			request.setAttribute("todayMonth", today.getMonthValue());
			request.setAttribute("todayDay", today.getDayOfMonth());
			request.setAttribute("currentYear", currentYear);

			// 데이터 바인딩
			request.setAttribute("orderList", orderList);
			request.setAttribute("countReady", countReady);
			request.setAttribute("countShipping", countShipping);
			request.setAttribute("countComplete", countComplete);
			request.setAttribute("startDate", startDate);
			request.setAttribute("endDate", endDate);
			request.getRequestDispatcher("/user/myOrderList.jsp").forward(request, response);

		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("error", "주문 목록을 불러오는 중 오류가 발생했습니다.");
			request.getRequestDispatcher("/error.jsp").forward(request, response);
		}
	}
}
