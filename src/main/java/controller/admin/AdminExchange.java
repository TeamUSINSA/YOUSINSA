package controller.admin;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dto.order.Exchange;
import service.order.ExchangeService;
import service.order.ExchangeServiceImpl;

@WebServlet("/adminExchange")
public class AdminExchange extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public AdminExchange() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            String status = request.getParameter("status");
            ExchangeService service = new ExchangeServiceImpl();
            List<Exchange> exchangeList;

            if ("completed".equals(status) || "pending".equals(status) || "rejected".equals(status)) {
                Map<String, Object> param = new HashMap<>();
                param.put("status", status);
                exchangeList = service.getExchangesByApproved(param);
            } else {
                exchangeList = service.getAllExchanges();
            }
            
            dao.product.CategoryDAO categoryDAO = new dao.product.CategoryDAOImpl();
            List<dto.product.Category> categoryList = categoryDAO.selectAllCategories();
            request.setAttribute("categoryList", categoryList);
            
            request.setAttribute("exchangeList", exchangeList);
            request.setAttribute("totalPages", service.getTotalPages());
            request.getRequestDispatcher("/admin/adminExchange.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "교환 목록을 불러오는 중 오류가 발생했습니다.");
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        }
    }
}
