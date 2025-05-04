package controller.alert;

import java.io.IOException;
import java.time.LocalDate;
import java.util.List;
import java.util.stream.Collectors;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import org.json.JSONObject;

import dto.order.Coupon;
import dto.user.Alert;
import dto.user.User;
import service.order.CouponService;
import service.order.CouponServiceImpl;
import service.user.AlertService;
import service.user.AlertServiceImpl;
import service.user.UserService;
import service.user.UserServiceImpl;
import utils.FCMService;

@WebServlet("/saveFcmToken")
public class SaveFcmToken extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        request.setCharacterEncoding("UTF-8");

        String body = request.getReader().lines().collect(Collectors.joining());
        JSONObject json = new JSONObject(body);
        String token = json.optString("token");

        HttpSession session = request.getSession(false);
        String userId = (session != null) ? (String) session.getAttribute("userId") : null;

        if (userId == null || token == null || token.isEmpty()) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            System.err.println("❌ FCM 토큰 저장 실패: 세션 없음 또는 토큰 누락");
            return;
        }

        try {
            UserService userService = new UserServiceImpl();
            CouponService couponService = new CouponServiceImpl();
            AlertService alertService = new AlertServiceImpl();

            // 1. 토큰 저장
            userService.updateFcmToken(userId, token);
            System.out.println("✅ FCM 토큰 저장 완료 for userId: " + userId);

            // 2. 사용자 정보 조회
            User user = userService.getUserById(userId);
            LocalDate today = LocalDate.now();

            // 3. 생일 쿠폰 발급 조건 확인
            List<Coupon> birthCoupons = couponService.selectValidCouponsByType("autoBirth");
            if (!birthCoupons.isEmpty()) {
                Coupon bc = birthCoupons.get(0);
                int couponId = bc.getCouponId();
                LocalDate expire = today.plusDays(bc.getPeriod());

                if (user.getBirth() != null &&
                        isTodayInBirthdayWindow(user.getBirth().toLocalDate(), bc.getPeriod(), today) &&
                        !couponService.hasUserCoupon(userId, couponId)) {

                    couponService.downloadCoupon(couponId, userId, today, expire);
                    System.out.println("🎁 생일 쿠폰 발급 완료: " + couponId);

                    Alert alert = new Alert();
                    alert.setUserId(userId);
                    alert.setTitle("🎉 생일 축하 쿠폰 도착!");
                    alert.setContent(bc.getName() + " 쿠폰이 발급되었습니다.");
                    alert.setSenderId("system");
                    alert.setSenderName("YOUSINSA");
                    alert.setType("coupon");
                    alert.setChecked(false);
                    alertService.insertAlert(alert);

                    FCMService.sendNotification(alert.getTitle(), alert.getContent(), token);
                    System.out.println("✅ 생일 쿠폰 푸시 전송 완료");
                } else {
                    System.out.println("⏩ 생일 쿠폰 조건 불충족 또는 이미 발급됨");
                }
            }

            // 4. 가입 쿠폰 발급 조건 확인
            List<Coupon> joinCoupons = couponService.selectValidCouponsByType("autoJoin");
            if (!joinCoupons.isEmpty()) {
                Coupon jc = joinCoupons.get(0);
                int couponId = jc.getCouponId();
                LocalDate expire = today.plusDays(jc.getPeriod());

                if (user.getJoinDate() != null &&
                        user.getJoinDate().toLocalDate().isEqual(today) &&
                        !couponService.hasUserCoupon(userId, couponId)) {

                    couponService.downloadCoupon(couponId, userId, today, expire);
                    System.out.println("🎁 가입 쿠폰 발급 완료: " + couponId);

                    Alert alert = new Alert();
                    alert.setUserId(userId);
                    alert.setTitle("🎁 회원가입 쿠폰 도착!");
                    alert.setContent(jc.getName() + " 쿠폰이 발급되었습니다.");
                    alert.setSenderId("system");
                    alert.setSenderName("YOUSINSA");
                    alert.setType("coupon");
                    alert.setChecked(false);
                    alertService.insertAlert(alert);

                    FCMService.sendNotification(alert.getTitle(), alert.getContent(), token);
                    System.out.println("✅ 가입 쿠폰 푸시 전송 완료");
                } else {
                    System.out.println("⏩ 가입 쿠폰 조건 불충족 또는 이미 발급됨");
                }
            }
            
            List<Alert> unChecked = alertService.selectUncheckedAlertsByUser(userId);
            for (Alert a : unChecked) {
                    if ("welcome".equals(a.getType()) || "qna".equals(a.getType()) || "inquiry".equals(a.getType())) {
                        FCMService.sendNotification(a.getTitle(), a.getContent(), token);
                        a.setChecked(true);
                        alertService.markAsChecked(a.getAlertId());
                        System.out.println("✅ " + a.getType() + " 푸시 전송 완료");
                                    }
            }


            response.setStatus(HttpServletResponse.SC_OK);
        } catch (Exception e) {
            System.err.println("❌ FCM 토큰 처리 중 예외 발생");
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }

    private boolean isTodayInBirthdayWindow(LocalDate birth, int period, LocalDate today) {
        LocalDate thisYear = birth.withYear(today.getYear());
        if (thisYear.isBefore(today)) {
            thisYear = thisYear.plusYears(1);
        }
        LocalDate windowStart = thisYear.minusDays(period);
        return !today.isBefore(windowStart) && !today.isAfter(thisYear);
    }
}
