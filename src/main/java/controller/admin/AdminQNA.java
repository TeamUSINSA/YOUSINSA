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
            String filter = request.getParameter("filter"); // ✅ 추가: 필터 파라미터 받기
            List<QnA> qnaList = qnaService.getQnAByFilter(filter); // ✅ 필터에 맞게 가져오기

            request.setAttribute("qnaList", qnaList);   
            
            dao.product.CategoryDAO categoryDAO = new dao.product.CategoryDAOImpl();
            List<dto.product.Category> categoryList = categoryDAO.selectCategoryWithSubList(); // 또는 selectAllCategories()
            request.setAttribute("categoryList", categoryList);

            
            request.getRequestDispatcher("/admin/adminQNA.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/error.jsp");
        }
    }


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response); // POST 요청도 동일 처리
    }
}
