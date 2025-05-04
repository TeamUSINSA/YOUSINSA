package controller.common;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import dto.user.User;
import service.user.UserService;
import service.user.UserServiceImpl;

@WebServlet("/login")
public class Login extends HttpServlet {
	private static final long serialVersionUID = 1L;

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

	    request.setCharacterEncoding("UTF-8");
	    String contentType = request.getContentType();

	    String userId = null;
	    String password = null;
	    String token = null;
	    String saveId = null;

	    if (contentType != null && contentType.contains("application/json")) {
	        StringBuilder sb = new StringBuilder();
	        String line;
	        while ((line = request.getReader().readLine()) != null) {
	            sb.append(line);
	        }
	        try {
	            org.json.JSONObject json = new org.json.JSONObject(sb.toString());
	            userId = json.getString("userId");
	            password = json.getString("password");
	            token = json.optString("token");
	        } catch (Exception e) {
	            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
	            response.getWriter().write("Invalid JSON");
	            return;
	        }
	    } else {
	        userId = request.getParameter("userId");
	        password = request.getParameter("password");
	        saveId = request.getParameter("saveId");
	    }

	    UserService service = new UserServiceImpl();
	    User user = new User();
	    user.setUserId(userId);
	    user.setPassword(password);

	    try {
	        User loginUser = service.login(user);

	        if (loginUser != null && !loginUser.getDeleted()) {
	            HttpSession session = request.getSession();
	            session.setAttribute("userId", loginUser.getUserId());
	            session.setAttribute("name", loginUser.getName());
	            session.setAttribute("isSeller", loginUser.getIsSeller());

	            if (token != null && !token.isEmpty()) {
	                service.updateFcmToken(userId, token);
	            }

	            Cookie saveIdCookie;
	            if ("on".equals(saveId)) {
	                // 아이디 저장 체크된 경우 → 쿠키에 아이디 저장
	                saveIdCookie = new Cookie("saveId", userId);
	                saveIdCookie.setMaxAge(60 * 60 * 24 * 30); // 30일
	            } else {
	                // 체크 안 된 경우 → 쿠키 즉시 삭제
	                saveIdCookie = new Cookie("saveId", "");
	                saveIdCookie.setMaxAge(0); 
	            }
	            saveIdCookie.setPath("/");
	            response.addCookie(saveIdCookie);


	            if (contentType != null && contentType.contains("application/json")) {
	                response.setContentType("application/json; charset=UTF-8");
	                response.getWriter().write("{\"status\":\"success\", \"redirect\":\"loginSuccess\"}");
	            } else {
	                response.sendRedirect("loginSuccess");
	            }
	            

	        } else {
	            if (contentType != null && contentType.contains("application/json")) {
	                response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
	                response.getWriter().write("아이디 또는 비밀번호 오류");
	            } else {
	                response.sendRedirect("login?error=1");
	            }
	        }

	    } catch (Exception e) {
	        e.printStackTrace();
	        response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
	        response.getWriter().write("서버 오류");
	    }
	}

}
