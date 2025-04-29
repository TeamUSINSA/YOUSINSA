package controller.admin;

import java.io.IOException;
import java.net.URLEncoder;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dto.order.Exchange;
import dto.order.OrderItem;
import dto.order.OrderList;
import dto.product.Product;
import dto.user.User;
import service.order.ExchangeService;
import service.order.ExchangeServiceImpl;
import service.order.OrderService;
import service.order.OrderServiceImpl;
import service.product.ProductService;
import service.product.ProductServiceImpl;
import service.user.UserService;
import service.user.UserServiceImpl;

@WebServlet("/adminExchangeDetail")
public class AdminExchangeDetail extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public AdminExchangeDetail() {
        super();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int exchangeId = Integer.parseInt(request.getParameter("exchangeId"));

            // 교환 정보
            ExchangeService exchangeService = new ExchangeServiceImpl();
            Exchange exchange = exchangeService.getExchangeDetailById(exchangeId);

            // 주문 아이템
            OrderService orderService = new OrderServiceImpl();
            OrderItem orderItem = orderService.findOrderItemById(exchange.getOrderItemId());

            // 주문 정보
            OrderList order = orderService.findOrderListById(orderItem.getOrderId());

            // 상품 정보
            ProductService productService = new ProductServiceImpl();
            Product product = productService.findProductById(orderItem.getProductId());

            // 회원 정보
            UserService userService = new UserServiceImpl();
            User user = userService.findUserById(exchange.getUserId());

            // JSP로 넘기기
            request.setAttribute("exchange", exchange);
            request.setAttribute("orderItem", orderItem);
            request.setAttribute("order", order);
            request.setAttribute("product", product);
            request.setAttribute("user", user);

            request.getRequestDispatcher("/admin/adminExchangeDetail.jsp").forward(request, response);

        } catch (Exception e) {
        	e.printStackTrace();
            String msg = URLEncoder.encode("상세조회실패", "UTF-8");
            response.sendRedirect("adminExchange.jsp?error=" + msg);
        }
    }
}
