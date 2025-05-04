// src/main/java/controller/admin/AdminQNAReply.java
package controller.admin;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dto.user.Alert;
import dto.user.QnA;
import service.user.AlertService;
import service.user.AlertServiceImpl;
import service.user.QNAService;
import service.user.QNAServiceImpl;
import service.user.UserServiceImpl;
import utils.FCMService;

@WebServlet("/adminQNAReply")
public class AdminQNAReply extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private QNAService qnaService;

    public AdminQNAReply() {
        super();
        qnaService = new QNAServiceImpl(); // QNA 서비스 연결
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/plain; charset=UTF-8");

        try {
            int qnaId = Integer.parseInt(request.getParameter("qnaId"));
            String answer = request.getParameter("answer");

            // 답변 객체 세팅
            QnA qna = new QnA();
            qna.setQnaId(qnaId);
            qna.setAnswer(answer);
            qna.setStatus("답변완료"); // 상태 업데이트

            qnaService.answerQnA(qna); // 서비스 통해 업데이트
            
            AlertService alertService = new AlertServiceImpl();
            String userId = qnaService.getUserIdByQnaId(qnaId); // 질문 작성자 ID 조회

            Alert alert = new Alert();
            alert.setUserId(userId);
            alert.setTitle("📢 문의하신 Q&A에 답변이 등록되었습니다.");
            alert.setContent("관리자의 답변이 등록되었으니 확인해보세요.");
            alert.setSenderId("admin");
            alert.setSenderName("YOUSINSA");
            alert.setType("qna");
            alert.setChecked(false);

            alertService.insertAlert(alert);

            // FCM 푸시 전송
            String token = new UserServiceImpl().getUserById(userId).getFcmToken();
            if (token != null && !token.isEmpty()) {
            	System.out.println("🎯 FCM 전송 대상 userId: " + userId + ", token: " + token);

                FCMService.sendNotification(alert.getTitle(), alert.getContent(), token);
            }

            response.getWriter().write("success");
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().write("fail");
        }
    }
}
