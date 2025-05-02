package controller.admin;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.inquiry.InquiryDAO;
import dao.inquiry.InquiryDAOImpl;
import dto.user.Inquiry;

@WebServlet("/adminInquiry")
public class AdminInquiry extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        InquiryDAO dao = new InquiryDAOImpl();

        try {
            String filter = request.getParameter("filter");
            List<Inquiry> inquiryList;

            if (filter == null || filter.equals("all")) {
                inquiryList = dao.selectAll();
            } else {
                String status = "";
                if (filter.equals("done")) {
                    status = "답변완료";
                } else if (filter.equals("waiting")) {
                    status = "답변대기";
                }
                inquiryList = dao.selectByStatus(status);
            }

            request.setAttribute("inquiryList", inquiryList);

            // ✅ 카테고리 목록 추가
            dao.product.CategoryDAO categoryDAO = new dao.product.CategoryDAOImpl();
            List<dto.product.Category> categoryList = categoryDAO.selectAllCategories();
            request.setAttribute("categoryList", categoryList);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "문의 목록 조회 실패");
        }

        request.getRequestDispatcher("/admin/adminInquiry.jsp").forward(request, response);
    }
}
