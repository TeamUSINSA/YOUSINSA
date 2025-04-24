package controller.admin;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.product.BannerProductDAO;
import dao.product.BannerProductDAOImpl;

/**
 * Servlet implementation class AdminBannerDelete
 */
@WebServlet("/adminbannerdelete")
public class AdminBannerDelete extends HttpServlet {
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		int bannerId = Integer.parseInt(request.getParameter("bannerId"));
		try {
			BannerProductDAO dao = new BannerProductDAOImpl();
			dao.deleteBanner(bannerId);
		} catch (Exception e) {
			e.printStackTrace();
		}
		response.sendRedirect(request.getContextPath() + "/admin/adminBanner.jsp");
	}
}
