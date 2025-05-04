package controller.common;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import dto.product.Category;
import service.product.CategoryService;
import service.product.CategoryServiceImpl;
import service.user.AlertService;
import service.user.AlertServiceImpl;

@WebServlet("/header")
public class Header extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public Header() {
        super();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 1) 세션 가져오기 (로그인 전에도 헤더 렌더링)
    	request.setCharacterEncoding("utf-8");
        HttpSession session = request.getSession(false);

        // 2) 알림 개수 조회 (로그인 되어 있으면 실제 개수, 아니면 0)
        int alertCount = 0;
        if (session != null && session.getAttribute("userId") != null) {
            String userId = (String) session.getAttribute("userId");
            AlertService alertService = new AlertServiceImpl();
            try {
                alertCount = alertService.countUncheckedAlerts(userId);
            } catch (Exception e) {
                throw new ServletException("알림 개수 조회 중 오류 발생", e);
            }
        }
        request.setAttribute("alertCount", alertCount);

        // 3) 카테고리 조회
        try {
            CategoryService categoryService = new CategoryServiceImpl();
            List<Category> categoryList = categoryService.selectCategoryWithSubList();
            request.setAttribute("categoryList", categoryList);
        } catch (Exception e) {
            throw new ServletException("카테고리 조회 중 오류 발생", e);
        }

        // 4) 헤더 JSP 포함
        request.getRequestDispatcher("/common/header.jsp")
               .include(request, response);
    }
}
