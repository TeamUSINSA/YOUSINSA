// 📁 controller/alert/GetAlertCount.java
package controller.common;

import java.io.IOException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import service.user.AlertService;
import service.user.AlertServiceImpl;

@WebServlet("/alertCount")
public class AlertCount extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        HttpSession session = request.getSession(false);
        String userId = (session != null) ? (String) session.getAttribute("userId") : null;

        if (userId != null) {
            AlertService alertService = new AlertServiceImpl();
            int count = 0;
            try {
                count = alertService.countUncheckedAlerts(userId);
            } catch (Exception e) {
                response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                return;
            }

            response.setContentType("application/json;charset=UTF-8");
            response.getWriter().write("{\"count\": " + count + "}");
        } else {
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
        }
    }
}
