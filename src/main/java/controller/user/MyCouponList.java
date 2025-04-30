package controller.user;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dto.user.UserCoupon;
import service.user.MyCouponService;
import service.user.MyCouponServiceImpl;


@WebServlet("/myCouponList")
public class MyCouponList extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private MyCouponService myCouponService = new MyCouponServiceImpl();
       

    public MyCouponList() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
			// 1) 로그인된 userId 확인
	        String userId = (String) request.getSession().getAttribute("userId");
	        if (userId == null) {
	            // 로그인 안 됐으면 로그인 페이지로 리다이렉트
	            response.sendRedirect(request.getContextPath() + "/login");
	            return;
	        }

	        try {
	            // 2) 전체 쿠폰 목록 조회
	            List<UserCoupon> fullList = myCouponService.getMyCoupons(userId);

	            // 3) 페이징 파라미터 처리 (기본 1페이지, 페이지당 5개)
	            int pageSize = 5;
	            String pageParam = request.getParameter("page");
	            int currentPage = 1;
	            if (pageParam != null) {
	                try { currentPage = Integer.parseInt(pageParam); }
	                catch (NumberFormatException ignored) {}
	            }

	            int totalItems = fullList.size();
	            int totalPages = (int) Math.ceil(totalItems / (double) pageSize);

	            // 4) 리스트 잘라서 페이지용 리스트 생성
	            int fromIndex = (currentPage - 1) * pageSize;
	            int toIndex   = Math.min(fromIndex + pageSize, totalItems);
	            List<UserCoupon> pageList = fullList.subList(
	                Math.min(fromIndex, totalItems),
	                Math.min(toIndex, totalItems)
	            );

	            // 5) 디버그 로그
	            System.out.println("[DEBUG] totalCoupons=" + totalItems +
	                               ", currentPage=" + currentPage +
	                               ", totalPages=" + totalPages);

	            // 6) JSP에 필요한 속성 세팅
	            request.setAttribute("couponList", pageList);
	            request.setAttribute("currentPage", currentPage);
	            request.setAttribute("totalPages", totalPages);

	            // 7) myCouponList.jsp로 포워드
	            request.getRequestDispatcher("/user/myCouponList.jsp")
	                   .forward(request, response);

	        } catch (Exception e) {
	            e.printStackTrace();  // 로그 남기기
	            throw new ServletException("쿠폰 목록 조회 중 오류", e);
	        }
	    }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
