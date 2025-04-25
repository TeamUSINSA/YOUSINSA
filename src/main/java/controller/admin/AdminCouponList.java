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

import dao.order.CouponDAO;
import dao.order.CouponDAOImpl;
import dto.order.Coupon;

@WebServlet("/admincouponlist")
public class AdminCouponList extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final int PAGE_SIZE = 10;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int page = 1;
            String pageParam = request.getParameter("page");
            if (pageParam != null && !pageParam.isEmpty()) {
                page = Integer.parseInt(pageParam);
            }

            int offset = (page - 1) * PAGE_SIZE;

            CouponDAO dao = new CouponDAOImpl();

            Map<String, Object> params = new HashMap<>();
            params.put("offset", offset);
            params.put("pageSize", PAGE_SIZE);

            List<Coupon> couponList = dao.selectCouponPage(params);
            int totalCount = dao.getCouponCount();
            int totalPages = (int) Math.ceil((double) totalCount / PAGE_SIZE);

            request.setAttribute("couponList", couponList);
            request.setAttribute("currentPage", page);
            request.setAttribute("totalPages", totalPages);

            request.getRequestDispatcher("/admin/adminCouponList.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("adminMain.jsp?error=쿠폰목록실패");
        }
    }
}
