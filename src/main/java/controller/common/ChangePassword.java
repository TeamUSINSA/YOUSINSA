package controller.common;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import service.user.UserService;
import service.user.UserServiceImpl;

@WebServlet("/changePassword")
public class ChangePassword extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        String sessionUserId = (session != null) ? (String) session.getAttribute("userId") : null;
        String resetUserId   = (session != null) ? (String) session.getAttribute("resetUserId") : null;

        if (sessionUserId == null && resetUserId == null) {
            response.sendRedirect(request.getContextPath() + "/findPassword");
            return;
        }

        request.getRequestDispatcher("/common/changePassword.jsp")
               .forward(request, response);
    }


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession(false);

        String sessionUserId = (String) session.getAttribute("userId");
        String resetUserId   = (String) session.getAttribute("resetUserId");
        if (sessionUserId == null && resetUserId == null) {
            response.sendRedirect(request.getContextPath() + "/findPassword");
            return;
        }

        String userId    = (resetUserId != null) ? resetUserId : sessionUserId;
        String newPw     = request.getParameter("newPassword");
        String confirmPw = request.getParameter("confirmPassword");

        UserService service = new UserServiceImpl();
        try {
            // 1) 새 비밀번호/확인 불일치
            if (!newPw.equals(confirmPw)) {
                response.sendRedirect(request.getContextPath() + "/changePassword?error=nomatch");
                return;
            }
         // 2) 로그인 사용자일 때 현재 비밀번호 검증
            if (sessionUserId != null) {
                String currentPw = request.getParameter("currentPassword");
                if (!service.checkPassword(userId, currentPw)) {
                    // 알림만 보여주고 동일 페이지
                    response.sendRedirect(request.getContextPath() + "/changePassword?error=wrong");
                    return;
                }
            }

            // 3) 새 비밀번호가 기존 비밀번호와 동일할 때
            String existingPw = service.findUserById(userId).getPassword();
            if (newPw.equals(existingPw)) {
            	response.sendRedirect(request.getContextPath() + "/changePassword?error=same");
                return;
            }
            // 4) 비밀번호 변경
            service.updateUserPassword(userId, newPw);

            if (resetUserId != null) session.removeAttribute("resetUserId");
            if (sessionUserId != null) session.setAttribute("userId", userId);

            response.sendRedirect(request.getContextPath() + "/changePassword?success=true");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/changePassword?error=fail");
        }
    }
}