package controller.user;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dto.user.Point;
import service.user.MyPointService;
import service.user.MyPointServiceImpl;

/**
 * Servlet implementation class MyPoint
 */
@WebServlet("/myPoint")
public class MyPoint extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private MyPointService service = new MyPointServiceImpl();
	public MyPoint() {
		super();
		// TODO Auto-generated constructor stub
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		HttpSession session = request.getSession(false);
        String userId = (session != null) ? (String) session.getAttribute("userId") : null;

        if (userId == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        try {
            // 파라미터 수집 (필터 확장 대비)
            String startDate = request.getParameter("startDate");
            String endDate = request.getParameter("endDate");

            Map<String, Object> paramMap = new HashMap<>();
            paramMap.put("userId", userId);
            paramMap.put("startDate", startDate);
            paramMap.put("endDate", endDate);

            // 포인트 목록 조회
            List<Point> pointList = service.getPointsByDate(paramMap);

            // JSP로 전달
            request.setAttribute("pointList", pointList);
            request.getRequestDispatcher("/user/myPoint.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "포인트 조회 실패");
        }
    }
}