package controller.admin;

import dto.order.Exchange;
import service.order.ExchangeService;
import service.order.ExchangeServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/adminexchangedetail")
public class AdminExchangeDetail extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public AdminExchangeDetail() {
        super();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // 1. 파라미터에서 exchangeId 받아오기
            int exchangeId = Integer.parseInt(request.getParameter("exchangeId"));

            // 2. 서비스 호출
            ExchangeService service = new ExchangeServiceImpl();
            Exchange exchange = service.getExchangeDetailById(exchangeId); // ← 이 메서드 너가 구현해야 해!

            // 3. JSP로 넘기기
            request.setAttribute("exchange", exchange);
            request.getRequestDispatcher("/admin/adminExchangeDetail.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("adminExchange.jsp?error=상세조회실패");
        }
    }
}


