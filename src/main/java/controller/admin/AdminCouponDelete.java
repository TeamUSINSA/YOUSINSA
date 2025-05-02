package controller.admin;

import java.io.IOException;
import java.net.URLEncoder;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.order.CouponDAO;
import dao.order.CouponDAOImpl;

@WebServlet("/adminCouponDelete")
public class AdminCouponDelete extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public AdminCouponDelete() {
        super();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            int couponId = Integer.parseInt(request.getParameter("couponId"));

            CouponDAO dao = new CouponDAOImpl();
            dao.deleteCouponById(couponId);

         // ✅ 카테고리 목록 추가
            dao.product.CategoryDAO categoryDAO = new dao.product.CategoryDAOImpl();
            List<dto.product.Category> categoryList = categoryDAO.selectAllCategories();
            request.setAttribute("categoryList", categoryList);
            
            // 삭제 후 목록으로 리다이렉트
            response.sendRedirect(request.getContextPath() + "/admincouponlist");

        } catch (Exception e) {
            e.printStackTrace();
            String message = URLEncoder.encode("삭제실패", "UTF-8");
            response.sendRedirect(request.getContextPath() + "/admincouponlist?error=" + message);
        }
    }
}
