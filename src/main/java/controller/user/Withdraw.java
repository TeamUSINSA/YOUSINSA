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


@WebServlet("/withdraw")
public class Withdraw extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

    public Withdraw() {
        super();
        // TODO Auto-generated constructor stub
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession(false);
		 String userId = (session != null) ? (String) session.getAttribute("userId") : null;

		    if (userId == null) {
		        response.sendRedirect(request.getContextPath() + "/login?error=needLogin");
		        return;
		    }
		    try {
		        UserDAO userDao = new UserDAOImpl();
		        User user = userDao.findUserByUserId(userId);
		        request.setAttribute("user", user);
		        request.getRequestDispatcher("/user/mywithdraw.jsp").forward(request, response);
		    } catch (Exception e) {
		        e.printStackTrace();
		        response.sendRedirect("error.jsp");
		    }
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		
		String reason = request.getParameter("reason");
		String detail = request.getParameter("detail");
		
		HttpSession session = request.getSession(false);
		String userId = (session != null) ? (String) session.getAttribute("userId") : null;

	    if (userId == null) {
	        response.sendRedirect(request.getContextPath() + "login");
	        return;
	    }
		
		UserDAO userDao = new UserDAOImpl();
		try {
	        User user = userDao.findUserByUserId(userId); // DB에서 다시 조회
	        user.setDeleted(true);
	        user.setWithdrawalReason(reason);
	        user.setWithdrawalDetail(detail);
	        userDao.withdrawUser(user);

			//세션 종료
			session.invalidate();
			response.sendRedirect(request.getContextPath() +"/withdrawSuccess");
		}catch (Exception e) {
			e.printStackTrace();
			response.sendRedirect("error");
		}
	}

}
