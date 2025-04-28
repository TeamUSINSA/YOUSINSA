package controller.admin;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.inquiry.InquiryDAO;
import dao.inquiry.InquiryDAOImpl;

/**
 * Servlet implementation class AdminInquiryReply
 */
@WebServlet("/adminInquiryReply")
public class AdminInquiryReply extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        int inquiryId = Integer.parseInt(request.getParameter("inquiryId"));
        String answer = request.getParameter("answer");

        InquiryDAO dao = new InquiryDAOImpl();
        try {
        	dao.updateAnswer(inquiryId, answer, "답변완료");  // DB에 답변 저장
            response.getWriter().write("success");
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().write("fail");
        }
    }
}
