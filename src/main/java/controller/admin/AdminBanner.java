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
import dto.product.BannerProduct;

@WebServlet("/adminBanner")
public class AdminBanner extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private BannerProductDAO bannerProductDAO;

    public AdminBanner() {
        super();
        bannerProductDAO = new BannerProductDAOImpl();  // DAO 객체 초기화
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            // 배너 목록 가져오기
            List<BannerProduct> bannerList = bannerProductDAO.selectAllBanners();
            request.setAttribute("bannerList", bannerList); // request에 배너 목록 설정
            request.getRequestDispatcher("/admin/adminBanner.jsp").forward(request, response);  // JSP로 포워딩
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("/error.jsp"); // 에러 페이지로 리디렉션
        }
    }
}
