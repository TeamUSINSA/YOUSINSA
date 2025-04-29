// src/main/java/controller/admin/AdminQNAReply.java
package controller.admin;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import dto.user.QnA;
import service.user.QNAService;
import service.user.QNAServiceImpl;

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

            response.getWriter().write("success");
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().write("fail");
        }
    }
}
