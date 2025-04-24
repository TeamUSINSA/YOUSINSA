package controller.admin;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dto.order.Exchange;
import service.order.ExchangeService;
import service.order.ExchangeServiceImpl;

/**
 * Servlet implementation class AdminExchange
 */
@WebServlet("/adminExchange")
public class AdminExchange extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AdminExchange() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            String status = request.getParameter("status");
            ExchangeService service = new ExchangeServiceImpl();
            List<Exchange> returnList;

            if ("completed".equals(status)) {
                returnList = service.getExchangesByApproved(1); // 수락
            } else if ("pending".equals(status)) {
                returnList = service.getExchangesByApproved(0); // 대기
            } else if ("rejected".equals(status)) {
                returnList = service.getExchangesByApproved(2); // ✅ 반려 추가
            } else {
                returnList = service.getAllExchanges(); // 전체
            }

            request.setAttribute("exchangeList", returnList);
            request.setAttribute("totalPages", service.getTotalPages());
            request.getRequestDispatcher("/admin/adminExchange.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "교환 목록을 불러오는 중 오류가 발생했습니다.");
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        }
    }



}
