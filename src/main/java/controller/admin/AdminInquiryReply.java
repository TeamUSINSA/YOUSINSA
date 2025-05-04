package controller.admin;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import dao.inquiry.InquiryDAO;
import dao.inquiry.InquiryDAOImpl;
import dto.user.Alert;
import dto.user.User;
import service.user.AlertService;
import service.user.AlertServiceImpl;
import service.user.UserService;
import service.user.UserServiceImpl;
import utils.FCMService;

@WebServlet("/adminInquiryReply")
public class AdminInquiryReply extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/plain; charset=UTF-8");

        int inquiryId = Integer.parseInt(request.getParameter("inquiryId"));
        String answer = request.getParameter("answer");

        InquiryDAO dao = new InquiryDAOImpl();

        try {
            // 1. 답변 업데이트
            dao.updateAnswer(inquiryId, answer, "답변완료");

            // 2. 사용자 정보 조회 (질문 작성자 userId 필요)
            String userId = dao.getUserIdByInquiryId(inquiryId); // 이 메소드가 있어야 합니다

            // 3. 알림 생성
            Alert alert = new Alert();
            alert.setUserId(userId);
            alert.setTitle("📬 1:1 문의 답변이 등록되었습니다.");
            alert.setContent("문의하신 내용에 대한 답변이 등록되었습니다. 확인해 주세요.");
            alert.setSenderId("admin");
            alert.setSenderName("YOUSINSA");
            alert.setType("inquiry");
            alert.setChecked(false);

            AlertService alertService = new AlertServiceImpl();
            alertService.insertAlert(alert);

            // 4. FCM 푸시 전송
            UserService userService = new UserServiceImpl();
            User user = userService.getUserById(userId);
            String token = user.getFcmToken();

            if (token != null && !token.isEmpty()) {
                FCMService.sendNotification(alert.getTitle(), alert.getContent(), token);
                System.out.println("✅ 1:1 문의 FCM 푸시 전송 완료");
            } else {
                System.out.println("⚠️ 토큰 없음 - FCM 푸시 생략");
            }

            response.getWriter().write("success");

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().write("fail");
        }
    }
}
