package controller.user;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dto.order.Cancel;
import service.user.MyCancelService;
import service.user.MyCancelServiceImpl;


@WebServlet("/myCancelDetail")
public class MyCancelDetail extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public MyCancelDetail() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		MyCancelService cancelService = new MyCancelServiceImpl();
		 // 1) 로그인 검사
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        // 2) 파라미터 읽기
        String sId = request.getParameter("cancelId");
        if (sId == null) {
            response.sendRedirect(request.getContextPath() + "/myCancelList");
            return;
        }
        int cancelId = Integer.parseInt(sId);

        try {
            // 3) 취소 상세 조회
            Cancel cancel = cancelService.getCancelById(cancelId);
            if (cancel == null) {
                response.sendError(HttpServletResponse.SC_NOT_FOUND);
                return;
            }

            // 4) JSP 에 넘기기
            request.setAttribute("cancel", cancel);
            // orderItems 는 cancel.getOrderItems() 에 담겨 있음
            request.getRequestDispatcher("/user/myCancelDetail.jsp")
                   .forward(request, response);

        } catch (Exception e) {
        	e.printStackTrace();
            throw new ServletException("취소 상세조회 중 오류 발생", e);
        }
    }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
