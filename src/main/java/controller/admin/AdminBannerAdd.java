package controller.admin;

import java.io.File;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import dao.product.BannerProductDAO;
import dao.product.BannerProductDAOImpl;
import dto.product.BannerProduct;

@WebServlet("/adminbanneradd")
public class AdminBannerAdd extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final String SAVE_DIR = "/upload/banner";

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/admin/adminBannerAdd.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String realPath = getServletContext().getRealPath(SAVE_DIR);
        File saveDir = new File(realPath);
        if (!saveDir.exists()) saveDir.mkdirs();

        MultipartRequest multi = new MultipartRequest(
                request,
                realPath,
                10 * 1024 * 1024, // 10MB
                "UTF-8",
                new DefaultFileRenamePolicy()
        );

        String img = multi.getFilesystemName("img");
        String name = multi.getParameter("name");
        String position = multi.getParameter("position");
        int productId = Integer.parseInt(multi.getParameter("productId"));

        BannerProduct banner = new BannerProduct();
        banner.setName(name);
        banner.setImg(img);
        banner.setPosition(position);
        banner.setProductId(productId);

        try {
            BannerProductDAO dao = new BannerProductDAOImpl();
            dao.insertBanner(banner);
            request.setAttribute("msg", "배너가 성공적으로 등록되었습니다!");
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("msg", "배너 등록 중 오류 발생");
        }

        request.getRequestDispatcher("/admin/adminBannerAdd.jsp").forward(request, response);
    }
}
