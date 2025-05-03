package controller.common;

import java.io.IOException;
import java.time.LocalDate;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

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

@WebServlet("/login")
public class Login extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public Login() {
		super();
	}

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String error = request.getParameter("error");
		if ("1".equals(error)) {
			request.setAttribute("errMsg", "아이디 또는 비밀번호가 일치하지 않습니다.");
		}
		if ("2".equals(error)) {
			request.setAttribute("errMsg", "삭제된 회원입니다. 관리자에게 문의하세요.");
		}
		request.getRequestDispatcher("/common/login.jsp").forward(request, response);
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		request.setCharacterEncoding("utf-8");
	

		String userId = request.getParameter("userId");
		String password = request.getParameter("password");
		String saveId = request.getParameter("saveId"); // 체크박스가 체크 안 되면 null

		UserService service = new UserServiceImpl();

		User user = new User();
		user.setUserId(userId);
		user.setPassword(password);

		try {
			User loginUser = service.login(user);

			

			
			if (loginUser != null) {
				// 로그인된 사용자가 삭제된 사용자일 경우 처리
				if (loginUser.getDeleted()) { // boolean 값으로 확인
					request.setAttribute("errMsg", "삭제된 회원입니다. 관리자에게 문의하세요.");
					response.sendRedirect("login?error=2");
					return;
				}
				
				CouponService couponService = new CouponServiceImpl();
				couponService.expireUserCoupons(loginUser.getUserId());
				// ✅ 세션 저장
				
				java.sql.Date bd = loginUser.getBirth();
				LocalDate today = LocalDate.now();

				// 이번 해 생일 계산
				LocalDate birthThisYear = bd.toLocalDate().withYear(today.getYear());
				// 이미 지났으면 내년 생일로
				if (birthThisYear.isBefore(today)) {
				    birthThisYear = birthThisYear.plusYears(1);
				}

				List<Coupon> birthCoupons = couponService.selectValidCouponsByType("autoBirth");
				
				for (Coupon bc : birthCoupons) {
				    LocalDate windowStart = birthThisYear.minusDays(bc.getPeriod());
				   

				    if (!today.isBefore(windowStart) && !today.isAfter(birthThisYear)) {
				     

				        boolean alreadyHasCoupon = couponService.hasUserCoupon(loginUser.getUserId(), bc.getCouponId());
				        

				        if (!alreadyHasCoupon) {
				            

				            LocalDate issue = today;
				            LocalDate expire = issue.plusDays(bc.getPeriod());

				            couponService.downloadCoupon(
				                bc.getCouponId(), loginUser.getUserId(), issue, expire
				            );
				            

				            Alert alert = new Alert();
				            alert.setUserId(loginUser.getUserId());
				            alert.setTitle("🎉 생일 축하 쿠폰 도착!");
				            alert.setContent(bc.getName() + " 쿠폰이 발급되었습니다.");
				            alert.setSenderId("system");
				            alert.setSenderName("YOUSINSA");
				            alert.setType("coupon");
				            alert.setChecked(false);

				            AlertService alertService = new AlertServiceImpl();
				            alertService.insertAlert(alert);
				            

				            String token = loginUser.getFcmToken();
				            

				            if (token != null && !token.isEmpty()) {
				                try {
				                    FCMService.sendNotification(alert.getTitle(), alert.getContent(), token);
				                    
				                } catch (Exception e) {
				                    System.out.println("❌ FCM 푸시 전송 실패");
				                    e.printStackTrace();
				                }
				            } else {
				                System.out.println("⚠️ FCM 토큰이 없어 알림 전송 생략");
				            }
				        } else {
				            System.out.println("⚠️ 이미 해당 쿠폰 보유 중 → 발급 생략");
				        }
				    } else {
				        System.out.println("⛔ 생일 윈도우 범위 아님");
				    }
				}

				    
				HttpSession session = request.getSession();
				session.setAttribute("userId", loginUser.getUserId());
				session.setAttribute("name", loginUser.getName());
				session.setAttribute("isSeller", loginUser.getIsSeller());

				// ✅ 아이디 저장 쿠키 처리
				Cookie saveIdCookie = new Cookie("saveId", "on".equals(saveId) ? userId : "");
				saveIdCookie.setMaxAge("on".equals(saveId) ? 60 * 60 * 24 * 30 : 0); // 30일 or 삭제
				saveIdCookie.setPath("/");
				response.addCookie(saveIdCookie);

				response.sendRedirect("loginSuccess");
			} else {
				response.sendRedirect("login?error=1");
				return;
			}

		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("errMsg", "로그인 중 오류가 발생했습니다.");
			request.getRequestDispatcher("/error.jsp").forward(request, response);
		}
	}

}
