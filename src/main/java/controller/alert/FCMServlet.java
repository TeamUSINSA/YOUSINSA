package controller.alert;

import java.io.IOException;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.firebase.FirebaseApp;

/**
 * Servlet implementation class FCMServlet
 */
@WebServlet("/fCMServlet")
public class FCMServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public FCMServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws IOException {
      resp.setContentType("text/plain; charset=UTF-8");
      try {
        FirebaseApp app = FirebaseApp.getInstance();
        resp.getWriter().println("✅ FirebaseApp 이름: " + app.getName());
      } catch (Exception e) {
        resp.getWriter().println("❌ Firebase 초기화 실패: " + e.getMessage());
      }
    }

}
