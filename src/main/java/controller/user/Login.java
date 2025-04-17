package controller.user;

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
        request.getRequestDispatcher("/user/login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");

        String userId = request.getParameter("userId");
        String password = request.getParameter("password");
        String saveId = request.getParameter("saveId");

        UserService service = new UserServiceImpl();

        System.out.println("[디버깅] 입력 userId: " + userId);
        System.out.println("[디버깅] 입력 password: " + password);
        
        // ✅ user 객체 생성 후 로그인
        User user = new User();
        user.setUserId(userId);
        user.setPassword(password);

        try {
            User loginUser = service.login(user);  // ✅ 객체로 전달

            if (loginUser != null) {
                HttpSession session = request.getSession();
                session.setAttribute("userId", loginUser.getUserId());
                session.setAttribute("name", loginUser.getName());
                
                System.out.println("[디버깅] 세션 저장 완료: " + session.getAttribute("userId"));

                // 아이디 저장 쿠키
                Cookie cookie = new Cookie("saveId", saveId != null ? userId : "");
                cookie.setMaxAge(saveId != null ? 60 * 60 * 24 * 30 : 0);
                cookie.setPath("/");
                response.addCookie(cookie);
                
                System.out.println("[디버깅] loginUser 객체 = " + loginUser);
                System.out.println("[디버깅] loginUser.getUserId() = " + loginUser.getUserId());
                System.out.println("[디버깅] loginUser.getPassword() = " + loginUser.getPassword());
                System.out.println("[디버깅] loginUser.getName() = " + loginUser.getName());


                response.sendRedirect(request.getContextPath() + "/user/loginSuccess.jsp");
            } else {
            	 System.out.println("[디버깅] 로그인 실패");
                request.setAttribute("err", "아이디 또는 비밀번호가 일치하지 않습니다.");
                request.getRequestDispatcher("/user/login.jsp").forward(request, response);
            }

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("err", "로그인 중 오류가 발생했습니다.");
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        }
    }

}
