package controller.user;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dto.user.User;
import service.user.MyAddressService;
import service.user.MyAddressServiceImpl;

@WebServlet("/myAddress")
public class MyAddress extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private MyAddressService addressService = new MyAddressServiceImpl();

	public MyAddress() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 1) 세션에서 로그인된 userId 가져오기
        HttpSession httpSession = request.getSession(false);
        if (httpSession == null || httpSession.getAttribute("userId") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        String userId = (String) httpSession.getAttribute("userId");
        
        try {
            // 2) Service 호출 → DTO로 받은 뒤 request 속성에 저장
            User user = addressService.getUserAddresses(userId);
            request.setAttribute("user", user);
            
            // 3) JSP로 포워드
            request.getRequestDispatcher("/user/myAddress.jsp")
                   .forward(request, response);
        } catch (Exception e) {
        	e.printStackTrace();
            throw new ServletException("배송지 조회 중 오류 발생", e);
        }
    }

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		// 1) userId 확인
        HttpSession httpSession = request.getSession(false);
        if (httpSession == null || httpSession.getAttribute("userId") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        String userId = (String) httpSession.getAttribute("userId");
        
        // 2) action 파라미터로 분기 (update1, delete2 등)
        String action = request.getParameter("action");  
        if (action == null || action.length() < 7) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST);
            return;
        }
        
        boolean isDelete = action.startsWith("delete");
        int slot = Integer.parseInt(action.substring(action.length() - 1));
        
        try {
            if (isDelete) {
                // 삭제: slot번 배송지 NULL 처리
                addressService.deleteAddress(userId, slot);
            } else {
                // 수정: 파라미터에서 addressN, addressNDetail 꺼내서 DTO에 설정
                String addr      = request.getParameter("address" + slot);
                String detail    = request.getParameter("address" + slot + "Detail");
                
                User user = new User();
                user.setUserId(userId);
                switch (slot) {
                    case 1:
                        user.setAddress1(addr);
                        user.setAddress1Detail(detail);
                        break;
                    case 2:
                        user.setAddress2(addr);
                        user.setAddress2Detail(detail);
                        break;
                    case 3:
                        user.setAddress3(addr);
                        user.setAddress3Detail(detail);
                        break;
                    default:
                        throw new IllegalArgumentException("Invalid slot: " + slot);
                }
                addressService.updateAddress(user, slot);
            }
            
            // 3) 처리 후, 목록 새로고침을 위해 GET으로 리다이렉트
            response.sendRedirect(request.getContextPath() + "/myAddress");
        } catch (Exception e) {
        	e.printStackTrace();
            throw new ServletException("배송지 " + (isDelete ? "삭제" : "수정") 
                                       + " 중 오류 발생", e);
        }
    }
}