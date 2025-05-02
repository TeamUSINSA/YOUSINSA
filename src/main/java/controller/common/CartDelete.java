package controller.common;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import service.order.CartService;
import service.order.CartServiceImpl;

@WebServlet("/cartDelete")
public class CartDelete extends HttpServlet {
    private static final long serialVersionUID = 1L;


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        CartService service = new CartServiceImpl();

        String cartIdParam = request.getParameter("cartId");

        try {
            int cartId = Integer.parseInt(cartIdParam);
            service.removeCartById(cartId);

            // 삭제 후 현재 장바구니 페이지로 리다이렉트
            response.sendRedirect(request.getContextPath() + "/cart");
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("err", "장바구니 항목 삭제 중 오류가 발생했습니다.");
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        }
    }
}
