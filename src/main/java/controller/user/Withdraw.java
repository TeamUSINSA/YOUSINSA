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
	    if (session == null || session.getAttribute("user") == null) {
	      response.sendRedirect("/user/login.jsp?error=needLogin");
	      return;
	    }
	    request.getRequestDispatcher("/user/mywithdraw.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		
		String reason = request.getParameter("reason");
		String detail = request.getParameter("detail");
		
		HttpSession session = request.getSession(false);
		User user = (User) session.getAttribute("user");
		
		UserDAO userDao = new UserDAOImpl();
		try {
			user.setDeleted(true);
			user.setWithdrawalReason(reason);
			user.setWithdrawalDetail(detail);
			userDao.withdrawUser(user);
			
			session.invalidate();
			response.sendRedirect("mywithdrawSuccess.jsp");
		}catch (Exception e) {
			e.printStackTrace();
			response.sendRedirect("error");
		}
	}

}
