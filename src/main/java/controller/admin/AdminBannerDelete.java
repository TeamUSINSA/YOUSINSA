package controller.admin;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.product.BannerProductDAO;
import dao.product.BannerProductDAOImpl;

@WebServlet("/adminBannerDelete")
public class AdminBannerDelete extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int bannerId = Integer.parseInt(request.getParameter("bannerId"));
        BannerProductDAO dao = new BannerProductDAOImpl();
        
        try {
            dao.deleteBanner(bannerId);
            
            
         // ✅ 카테고리 목록 추가
            dao.product.CategoryDAO categoryDAO = new dao.product.CategoryDAOImpl();
            List<dto.product.Category> categoryList = categoryDAO.selectAllCategories(); // 이름은 너가 실제 쓰는 걸로 맞춰줘
            request.setAttribute("categoryList", categoryList);
            // 🔥 랜덤 쿼리스트링 추가해서 캐시 무효화
            response.sendRedirect(request.getContextPath() + "/adminBanner?refresh=" + System.currentTimeMillis());
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/admin/adminBanner.jsp?error=exception");
        }
    }
}
