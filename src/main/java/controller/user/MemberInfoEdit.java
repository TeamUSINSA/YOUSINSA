package controller.user;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import dao.user.UserDAO;
import dao.user.UserDAOImpl;
import dto.user.User;

@WebServlet("/memberInfoEdit")
public class MemberInfoEdit extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public MemberInfoEdit() {
        super();
    }

    
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        String userId = (session != null) ? (String) session.getAttribute("userId") : null;

        if (userId == null) {
            response.sendRedirect("login.jsp?error=needLogin");
            return;
        }

        try {
            UserDAO userDao = new UserDAOImpl();
            User user = userDao.findUserByUserId(userId);  // DB에서 유저 전체 정보 조회
            request.setAttribute("user", user);
            request.getRequestDispatcher("/user/memberInfoEdit.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }
    }

    
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("utf-8");
        response.setContentType("text/html; charset=UTF-8");
        response.setCharacterEncoding("UTF-8");
        String field = request.getParameter("field");
        String value = request.getParameter("value");

        HttpSession session = request.getSession(false);
        String userId = (session != null) ? (String) session.getAttribute("userId") : null;

        if (userId == null) {
            response.getWriter().write("unauthorized");
            return;
        }
        //폰 유효성 검사
        if ("phone".equals(field)) {
            if (!value.matches("\\d{10,11}")) {
                response.getWriter().write("invalid_phone");
                return;
            }
        }
        //이메일 유효성 검사
        if ("email".equals(field)) {
            String emailRegex = "^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+$";
            if (!value.matches(emailRegex)) {
                response.getWriter().write("이메일 형식이 올바르지 않습니다.");
                return;
            }
        }

        //생년월일 유효성 검사
        if ("birth".equals(field)) {
            try {
                java.sql.Date.valueOf(value);  // 형식 안 맞으면 예외 발생
            } catch (IllegalArgumentException e) {
                response.getWriter().write("생일 형식이 올바르지 않습니다.");
                return;
            }
        }

        try {
            UserDAO userDao = new UserDAOImpl();
            userDao.updateSingleField(userId, field, value);
            response.getWriter().write("success");
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().write("error");
        }
    }
}
