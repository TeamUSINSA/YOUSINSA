package controller.user;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dto.user.Alert;
import service.user.AlertService;
import service.user.AlertServiceImpl;

@WebServlet("/myAlarm")
public class MyAlertList extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private AlertService alertService = new AlertServiceImpl();
	
    public MyAlertList() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 1) 로그인처리
    HttpSession session = request.getSession(false);
    String userId = (session != null)
                    ? (String) session.getAttribute("userId")
                    : null;
    if (userId == null) {
        response.sendRedirect(request.getContextPath() + "/login");
        return;
    }

    try {
    	// 2)★ 체크 처리 요청이 있으면 먼저 처리
        String action = request.getParameter("action");
        if ("check".equals(action)) {
            int alertId = Integer.parseInt(request.getParameter("alertId"));
            alertService.markAsChecked(alertId);
            // 처리 후 리다이렉트로 새로고침 방지
            response.sendRedirect(request.getContextPath() + "/myAlarm");
            return;
        }
        // 3) Service 호출: userId 기준으로 Alert 목록 조회
        List<Alert> alertList = alertService.getAlertsByUser(userId);

        // 4) 조회된 알림을 request 속성에 저장
        request.setAttribute("alertList", alertList);

        // 5) user/myAlertList.jsp 로 포워드
        request.getRequestDispatcher("/user/myAlertList.jsp")
               .forward(request, response);

    } catch (Exception e) {
        // 6) 예외 발생 시 로그 남기고, 서블릿 예외로 포장
        e.printStackTrace();
        throw new ServletException("알림 목록 조회 중 오류", e);
    }
}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
