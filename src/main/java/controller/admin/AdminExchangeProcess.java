package controller.admin;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import service.order.ExchangeService;
import service.order.ExchangeServiceImpl;

@WebServlet("/adminexchangeprocess")
public class AdminExchangeProcess extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        try {
            String exchangeStatus = request.getParameter("exchangeStatus");
            String rejectReason = request.getParameter("rejectReason");
            String exchangeId = request.getParameter("exchangeId"); // 히든 값으로 받아온다고 가정

            ExchangeService service = new ExchangeServiceImpl();

            // 교환 상태 업데이트
            if ("반려".equals(exchangeStatus)) {
                service.rejectExchange(Integer.parseInt(exchangeId), rejectReason);
            } else if ("허가".equals(exchangeStatus)) {
                service.approveExchange(Integer.parseInt(exchangeId));
            }

            response.sendRedirect(request.getContextPath() + "/admin/adminExchange.jsp");

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/admin/adminExchange.jsp?error=처리실패");
        }
    }
}
