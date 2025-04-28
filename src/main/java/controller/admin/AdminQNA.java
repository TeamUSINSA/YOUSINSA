package controller.admin;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dto.user.QnA;
import service.user.QNAService;
import service.user.QNAServiceImpl;

@WebServlet("/adminQNA")
public class AdminQNA extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private QNAService qnaService;  // ✅ Service를 필드로 선언

    public AdminQNA() {
        super();
        qnaService = new QNAServiceImpl();  // ✅ ServiceImpl을 생성해서 주입
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            List<QnA> qnaList = qnaService.getAllQnA();  // ✅ DAO 말고 Service를 통해 호출
            request.setAttribute("qnaList", qnaList);   // ✅ JSP에 넘길 데이터 저장
            request.getRequestDispatcher("/admin/adminQNA.jsp").forward(request, response);  // ✅ 페이지 이동
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/error.jsp"); // 에러 시 에러페이지 이동
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response); // POST 요청도 동일 처리
    }
}
