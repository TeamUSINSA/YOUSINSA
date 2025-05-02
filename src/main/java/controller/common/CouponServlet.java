package controller.common;

import java.io.IOException;
import java.sql.Date;
import java.time.LocalDate;
import java.time.ZoneId;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dto.order.Coupon;
import service.order.CouponService;
import service.order.CouponServiceImpl;

@WebServlet("/coupon")
public class CouponServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // 세션에서 userId 읽기
    	request.setCharacterEncoding("UTF-8");
    	CouponService couponService = new CouponServiceImpl();

        HttpSession session = request.getSession(false);
        String userId = (session != null) ? (String) session.getAttribute("userId") : null;

        try {
            List<Coupon> coupons;
            if (userId == null) {
                // 비로그인: 전체 유효 쿠폰
                coupons = couponService.selectValidCoupons();
            } else {
                // 로그인: 사용자별 미다운된 유효 쿠폰
                coupons = couponService.selectValidCouponsByUser(userId);
            }
            request.setAttribute("couponList", coupons);
            // JSP로 포워드
            RequestDispatcher rd = request.getRequestDispatcher("/common/couponDownload.jsp");
            rd.forward(request, response);
        } catch (Exception e) {
            throw new ServletException("쿠폰 목록 조회 중 오류 발생", e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        CouponService couponService = new CouponServiceImpl();
        HttpSession session = request.getSession(false);
        String userId = (session != null) ? (String) session.getAttribute("userId") : null;
        if (userId == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        try {
            int couponId = Integer.parseInt(request.getParameter("coupon_id"));

            // 쿠폰 정보 조회
            Coupon coupon = couponService.getCouponById(couponId);
            if (coupon == null) {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "존재하지 않는 쿠폰입니다.");
                return;
            }

            // 발행일·만료일 계산
            LocalDate issueDate = LocalDate.now();
            LocalDate expireDate = issueDate.plusDays(coupon.getPeriod());

            couponService.downloadCoupon(couponId, userId, issueDate, expireDate);

            response.sendRedirect(request.getContextPath() + "/coupon");
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "잘못된 쿠폰 ID입니다.");
        } catch (Exception e) {
            throw new ServletException("쿠폰 다운로드 처리 중 오류 발생", e);
        }
    }
}