package controller.user;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dto.order.Exchange;
import dto.order.OrderItem;
import dto.user.User;
import service.order.ExchangeService;
import service.order.ExchangeServiceImpl;
import service.order.OrderItemService;
import service.order.OrderItemServiceImpl;
import service.user.UserService;
import service.user.UserServiceImpl;

@WebServlet("/myExchangeDetail")
public class MyExchangeDetail extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public MyExchangeDetail() {
        super();
        // TODO Auto-generated constructor stub
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		ExchangeService exchService = new ExchangeServiceImpl();
	    OrderItemService itemService = new OrderItemServiceImpl();
	    UserService userService = new UserServiceImpl();
		
		
		String userId        = (String) request.getSession().getAttribute("userId");
        int exchangeId       = Integer.parseInt(request.getParameter("exchangeId"));

        try {
            // 1) Exchange 기본 정보
            Exchange exchange = exchService.getExchangeDetailById(exchangeId);

            // 2) 연관된 OrderItem 하나만 뽑기 (배송완료된 것 중 해당 ID)
            List<OrderItem> items = exchService.getDeliveredItems(userId, exchange.getOrderItemId());
            OrderItem product = items.stream()
                .filter(i -> i.getOrderItemId() == exchange.getOrderItemId())
                .findFirst()
                .orElseThrow(() -> new ServletException("유효하지 않은 상품입니다."));

            // 3) User 정보
            User user = userService.getUserById(exchange.getUserId());

            // 4) JSP로 전달
            request.setAttribute("exchange", exchange);
            request.setAttribute("product", product);
            request.setAttribute("user", user);

            request.getRequestDispatcher("/user/myExchangeDetail.jsp")
               .forward(request, response);

        } catch (Exception e) {
        	e.printStackTrace();
            throw new ServletException(e);
        }
    }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
