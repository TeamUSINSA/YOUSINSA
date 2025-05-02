package controller.admin;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dto.order.OrderItem;
import dto.order.OrderList;
import dto.order.Return;
import dto.product.Product;
import dto.user.User;
import service.order.OrderService;
import service.order.OrderServiceImpl;
import service.order.ReturnService;
import service.order.ReturnServiceImpl;
import service.user.UserService;
import service.user.UserServiceImpl;

@WebServlet("/adminReturnDetail")
public class AdminReturnDetail extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public AdminReturnDetail() {
        super();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            // 1. 파라미터 받기
            int returnId = Integer.parseInt(request.getParameter("returnId"));

            // 2. 서비스 객체 생성
            ReturnService returnService = new ReturnServiceImpl();
            OrderService orderService = new OrderServiceImpl();
            UserService userService = new UserServiceImpl();

            // 3. 반품 정보 조회
            Return refund = returnService.getAllReturns()    // 전체 리스트에서 찾아야 함
                            .stream()
                            .filter(r -> r.getReturnId() == returnId)
                            .findFirst()
                            .orElse(null);

            if (refund == null) {
                throw new Exception("해당 ID의 반품 정보가 없습니다.");
            }

            OrderItem orderItem = orderService.findOrderItemById(refund.getOrderItemId());
            OrderList order = orderService.findOrderListById(orderItem.getOrderId());
            Product product = orderService.findProductById(orderItem.getProductId());
            User user = userService.findUserById(refund.getUserId());
            request.setAttribute("userName", user.getName());

            // ❗❗ User는 지금 orderService에 메소드 없음
            // → 일단 넘어가거나, userId만 뿌릴거면 user 없이 진행해도 됨
            // User user = orderService.selectUserById(refund.getUserId());

            // 4. request scope에 담기
            request.setAttribute("refund", refund);
            request.setAttribute("orderItem", orderItem);
            request.setAttribute("order", order);
            request.setAttribute("product", product);
            request.setAttribute("userId", refund.getUserId()); // 임시 대체
            
            // ✅ 여기 추가
            dao.product.CategoryDAO categoryDAO = new dao.product.CategoryDAOImpl();
            List<dto.product.Category> categoryList = categoryDAO.selectAllCategories();
            request.setAttribute("categoryList", categoryList);

            // 5. JSP로 포워딩
            request.getRequestDispatcher("/admin/adminReturnDetail.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "반품 상세 정보를 불러오는 데 실패했습니다.");
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}
