package controller.common;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import dto.product.Product;
import dto.product.BannerProduct;
import service.product.ProductService;
import service.product.ProductServiceImpl;
import service.product.BannerProductService;
import service.product.BannerProductServiceImpl;
import service.order.OrderItemService;
import service.order.OrderItemServiceImpl;

@WebServlet("/main")
public class Main extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public Main() {
        super();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        ProductService productService       = new ProductServiceImpl();
        BannerProductService bannerService  = new BannerProductServiceImpl();
        OrderItemService orderItemService   = new OrderItemServiceImpl();

        try {
            // 배너
            List<BannerProduct> mainBannerList = bannerService.getMainBannerList();
            List<BannerProduct> subBannerList  = bannerService.getSubBannerList();
            List<Product> newList     = productService.getLatestProducts(4);
            List<Product> popularList = orderItemService.getTopSellingProducts(4);

            request.setAttribute("mainBannerList", mainBannerList);
            request.setAttribute("subBannerList",  subBannerList);
            request.setAttribute("newList",         newList);
            request.setAttribute("popularList",     popularList);

            request.getRequestDispatcher("/common/main.jsp")
                   .forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "메인 페이지 로딩 실패");
        }
    }
}
