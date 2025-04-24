package controller.admin;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.order.OrderDAO;
import dao.order.OrderDAOImpl;
import dao.user.UserDAO;
import dao.user.UserDAOImpl;
import dto.order.OrderList;
import dto.user.User;

@WebServlet("/adminsearchmember")
public class AdminSearchMember extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String searchType = request.getParameter("searchType");
        String keyword = request.getParameter("keyword");

        UserDAO userDao = new UserDAOImpl();
        OrderDAO orderDao = new OrderDAOImpl();

        try {
            User member = null;

            // 🔥 memberNo 검색 제거
            if ("id".equals(searchType)) {
                member = userDao.findById(keyword);
            }

            if (member != null) {
                List<OrderList> orderList = orderDao.findOrdersByUserId(member.getUserId());

                request.setAttribute("member", member);
                request.setAttribute("orderList", orderList);
            }

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "회원 정보 조회 중 오류 발생");
        }

        request.getRequestDispatcher("/admin/adminSearchMember.jsp").forward(request, response);
    }
}
