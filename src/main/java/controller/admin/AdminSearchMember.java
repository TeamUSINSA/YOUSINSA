package controller.admin;

import java.io.IOException;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dto.order.OrderList;
import dto.user.User;
import service.order.OrderService;
import service.order.OrderServiceImpl;
import service.user.UserService;
import service.user.UserServiceImpl;

@WebServlet("/adminSearchMember")
public class AdminSearchMember extends HttpServlet {
    private UserService userService = new UserServiceImpl();
    private OrderService orderService = new OrderServiceImpl();

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String searchType = request.getParameter("searchType");
        String keyword = request.getParameter("keyword");

        try {
            if ("id".equals(searchType)) {
                User member = userService.findUserById(keyword);
                if (member != null) {
                    List<OrderList> orders = orderService.findOrdersByUserId(member.getUserId());
                    request.setAttribute("member", member);
                    request.setAttribute("orderList", orders);
                }
            } else if ("name".equals(searchType)) {
                List<User> users = userService.findUsersByName(keyword);
                Map<User, List<OrderList>> userOrderMap = new LinkedHashMap<>();

                for (User user : users) {
                    List<OrderList> orders = orderService.findOrdersByUserId(user.getUserId());
                    userOrderMap.put(user, orders);
                }

                request.setAttribute("userOrderMap", userOrderMap);
            }
            
            // ✅ 카테고리 목록 추가
            dao.product.CategoryDAO categoryDAO = new dao.product.CategoryDAOImpl();
            List<dto.product.Category> categoryList = categoryDAO.selectAllCategories(); // 이름은 너가 실제 쓰는 걸로 맞춰줘
            request.setAttribute("categoryList", categoryList);
            
        } catch (Exception e) {
            e.printStackTrace();
        }

        request.getRequestDispatcher("/admin/adminSearchMember.jsp").forward(request, response);
    }
}
