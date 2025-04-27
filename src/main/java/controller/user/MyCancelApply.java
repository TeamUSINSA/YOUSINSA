package controller.user;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dto.order.OrderList;
import service.order.OrderListService;
import service.order.OrderListServiceImpl;
import service.user.MyCancelService;
import service.user.MyCancelServiceImpl;

/**
 * Servlet implementation class MyCancelApply
 */
@WebServlet("/myCancelApply")
public class MyCancelApply extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private final OrderListService orderService = new OrderListServiceImpl();
	private final MyCancelService cancelService = new MyCancelServiceImpl();
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public MyCancelApply() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 로그인 체크
        HttpSession session = request.getSession(false);
        String userId = (session != null) 
                      ? (String) session.getAttribute("userId") 
                      : null;
        if (userId == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        // 파라미터에서 orderId 가져오기
        String sOrderId = request.getParameter("orderId");
        if (sOrderId == null) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "orderId 누락");
            return;
        }

        int orderId = Integer.parseInt(sOrderId);
        try {
            // 주문정보 + 아이템 리스트 조회
            OrderList order = orderService.getOrder(orderId);

            // 사용자 소유 여부 검증 (옵션)
            
            if (!userId.equals(order.getUserId())) {
                response.sendError(HttpServletResponse.SC_FORBIDDEN, "권한 없음");
                return;
            }

            request.setAttribute("order", order);
            // 취소신청 폼 JSP로 포워드
            request.getRequestDispatcher("/user/myCancelApply.jsp")
               .forward(request, response);

        } catch (Exception e) {
        	e.printStackTrace();
            throw new ServletException("취소신청 페이지 로딩 실패", e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 로그인 체크
        HttpSession session = request.getSession(false);
        String userId = (session != null)
                      ? (String) session.getAttribute("userId")
                      : null;
        if (userId == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        // 폼 파라미터
        int orderId    = Integer.parseInt(request.getParameter("orderId"));
        String reason  = request.getParameter("reason");
        String etc     = request.getParameter("reasonEtc");
        if ("기타".equals(reason) && etc != null && !etc.isBlank()) {
            reason = etc.trim();
        }

        try {
            // 실제 취소 처리
            cancelService.requestCancel(orderId, userId, reason);
            // 완료 후 취소/반품 목록으로 리다이렉트
            response.sendRedirect(request.getContextPath() + "/myCancelList");
        } catch (Exception e) {
        	e.printStackTrace();
            throw new ServletException("취소신청 처리 실패", e);
        }
    }
}