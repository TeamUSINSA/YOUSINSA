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

    public Login() {
        super();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
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
                // ✅ 세션 저장
                HttpSession session = request.getSession();
                session.setAttribute("userId", loginUser.getUserId());
                session.setAttribute("name", loginUser.getName());

                // ✅ 아이디 저장 쿠키 처리
                if ("on".equals(saveId)) {
                    Cookie cookie = new Cookie("saveId", userId);
                    cookie.setMaxAge(60 * 60 * 24 * 30); // 30일
                    cookie.setPath("/");
                    response.addCookie(cookie);
                } else {
                    Cookie cookie = new Cookie("saveId", "");
                    cookie.setMaxAge(0); // 즉시 삭제
                    cookie.setPath("/");
                    response.addCookie(cookie);
                }

                response.sendRedirect("loginSuccess");
            } else {
                request.setAttribute("err", "아이디 또는 비밀번호가 일치하지 않습니다.");
                request.getRequestDispatcher("/common/login.jsp").forward(request, response);
            }

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("err", "로그인 중 오류가 발생했습니다.");
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        }
    }
}
