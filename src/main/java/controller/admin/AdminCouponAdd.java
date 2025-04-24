package controller.admin;

import java.io.IOException;
import java.sql.Date;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.order.CouponDAO;
import dao.order.CouponDAOImpl;
import dto.order.Coupon;

@WebServlet("/admincouponadd")
public class AdminCouponAdd extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public AdminCouponAdd() {
        super();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");

        try {
            // 파라미터 받기
            String name = request.getParameter("name");
            String description = request.getParameter("description");
            String discountStr = request.getParameter("discount_amount");
            String startDateStr = request.getParameter("startDate");
            String endDateStr = request.getParameter("endDate");
            String type = request.getParameter("type"); // "auto" or "download"

            // 필수값 검증
            if (name == null || name.trim().isEmpty() ||
                description == null || description.trim().isEmpty() ||
                discountStr == null || discountStr.trim().isEmpty() ||
                startDateStr == null || endDateStr == null) {

                throw new IllegalArgumentException("필수 항목 누락");
            }

            // 변환
            int discountAmount = Integer.parseInt(discountStr.trim());
            Date startDate = Date.valueOf(startDateStr);
            Date endDate = Date.valueOf(endDateStr);
            boolean active = "auto".equals(type); // 자동 쿠폰이면 1, 다운로드면 0

            // DTO 세팅
            Coupon coupon = new Coupon();
            coupon.setName(name);
            coupon.setDescription(description);
            coupon.setDiscountAmount(discountAmount);
            coupon.setStartDate(startDate);
            coupon.setEndDate(endDate);
            coupon.setType(type);
            coupon.setActive(active);

            // DAO 호출
            CouponDAO dao = new CouponDAOImpl();
            dao.insertCoupon(coupon);

            // 등록 성공 시 쿠폰 목록으로 이동

            List<Coupon> couponList = dao.selectAllCoupons();
            request.setAttribute("couponList", couponList);
            request.getRequestDispatcher("/admin/adminCouponList.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "쿠폰 등록 중 오류가 발생했습니다: " + e.getMessage());
            request.getRequestDispatcher("/admin/adminCouponAdd.jsp").forward(request, response);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // GET 요청 시 폼 보여주기
        request.getRequestDispatcher("/admin/adminCouponAdd.jsp").forward(request, response);
    }
}
