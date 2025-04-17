package controller.user;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.user.UserDAO;
import dao.user.UserDAOImpl;
import dto.user.User;

/**
 * Servlet implementation class MemberInfoEdit
 */
@WebServlet("/memberInfoEdit")
public class MemberInfoEdit extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public MemberInfoEdit() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		HttpSession session = request.getSession(false); // false = 세션 없으면 null 반환
		User user = (session != null) ? (User) session.getAttribute("user") : null;

		if (user == null) {
			// 로그인 안 돼있으면 login 페이지로 리디렉트
			response.sendRedirect("/user/login.jsp?error=needLogin");
			return;
		}

		// 로그인 되어 있으면 회원정보 페이지로
		request.setAttribute("user", user);
		request.getRequestDispatcher("/user/memberInfoEdit.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		String field = request.getParameter("field"); // 
		String value = request.getParameter("value"); // 

		// 세션에서 현재 로그인 유저 ID 가져오기
		HttpSession session = request.getSession();
		User user = (User) session.getAttribute("user");
		if (user == null) {
			response.getWriter().write("unauthorized");
			return;
		}
		String userId = user.getUserId();
		UserDAO userDao = new UserDAOImpl();

		try {
			userDao.updateSingleField(userId, field, value);
			response.getWriter().write("success");
		} catch (Exception e) {
			e.printStackTrace();
			response.getWriter().write("error");
		}
	}
}
