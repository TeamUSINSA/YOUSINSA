package controller.common;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/afterJoin")
public class AfterJoin extends HttpServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		

		String id = request.getParameter("id");


		request.setAttribute("id", id);


		request.getRequestDispatcher("/common/AfterJoin.jsp").forward(request, response);
	}
}
