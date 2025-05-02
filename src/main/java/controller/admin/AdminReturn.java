package controller.admin;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dto.order.Return;
import service.order.ReturnService;
import service.order.ReturnServiceImpl;

/**
 * Servlet implementation class AdminReturn
 */
@WebServlet("/adminReturn")
public class AdminReturn extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            String status = request.getParameter("status");

            // Service 객체 생성
            ReturnService service = new ReturnServiceImpl(); // 실제 구현체 이름에 맞춰줘!
            List<Return> returnList;

            // 상태별 조건 처리
            if ("completed".equals(status)) {
                returnList = service.getReturnsByApproved(1);
            } else if ("pending".equals(status)) {
                returnList = service.getReturnsByApproved(0);
            } else if ("rejected".equals(status)) {
                returnList = service.getReturnsByApproved(2);
            } else {
                returnList = service.getAllReturns(); // 전체
            }

            request.setAttribute("refundList", returnList); // ← JSP에서 사용하는 이름에 맞춰야 해!
            request.setAttribute("totalPages", service.getTotalPages());
            
         // ✅ 여기 추가
            dao.product.CategoryDAO categoryDAO = new dao.product.CategoryDAOImpl();
            List<dto.product.Category> categoryList = categoryDAO.selectAllCategories();
            request.setAttribute("categoryList", categoryList);

            

            request.getRequestDispatcher("/admin/adminReturn.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "반품 목록을 불러오는 중 오류가 발생했습니다.");
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        }
    }
}