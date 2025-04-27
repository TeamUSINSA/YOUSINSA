package controller.user;

import java.io.IOException;
import java.time.LocalDate;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dto.user.CancelReturn;
import service.user.MyCancelReturnService;
import service.user.MyCancelReturnServiceImpl;

/**
 * Servlet implementation class MyCancelReturn
 */
@WebServlet("/myCancelList")
public class MyCancelReturn extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private final MyCancelReturnService service = new MyCancelReturnServiceImpl();
    public MyCancelReturn() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        String userId = (String) session.getAttribute("userId");

        // 파라미터 읽기
        String sy = request.getParameter("startYear");
        String sm = request.getParameter("startMonth");
        String sd = request.getParameter("startDay");
        String ey = request.getParameter("endYear");
        String em = request.getParameter("endMonth");
        String ed = request.getParameter("endDay");

        // 포맷팅: 한 자리일 때 0패드
        if (sm != null && sm.length() == 1) sm = "0" + sm;
        if (sd != null && sd.length() == 1) sd = "0" + sd;
        if (em != null && em.length() == 1) em = "0" + em;
        if (ed != null && ed.length() == 1) ed = "0" + ed;

        // 날짜 문자열 만들기
        String startDate = (sy != null && sm != null && sd != null)
                         ? String.format("%s-%s-%s", sy, sm, sd)
                         : null;
        String endDate   = (ey != null && em != null && ed != null)
                         ? String.format("%s-%s-%s", ey, em, ed)
                         : null;

        // 기본값: 없으면 최근 1개월
        LocalDate today = LocalDate.now();
        if (startDate == null || startDate.isEmpty()) {
            startDate = today.minusMonths(1).toString();
        }
        if (endDate == null || endDate.isEmpty()) {
            endDate   = today.toString();
        }

        try {
            List<CancelReturn> cancelList =
                service.getMyCancelReturnList(userId, startDate, endDate);

            request.setAttribute("cancelList", cancelList);
            request.setAttribute("currentYear", today.getYear());
            // JSP에서 param.* 를 그대로 쓰므로 추가 파라미터는 안 넣어도 됩니다.

            request.getRequestDispatcher("/user/myCancelList.jsp")
               .forward(request, response);
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
