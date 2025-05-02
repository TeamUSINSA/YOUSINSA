package controller.user;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dto.user.QnA;
import service.user.MyQnAService;
import service.user.MyQnAServiceImpl;
import utils.PageInfo;

/**
 * Servlet implementation class MyQnA
 */
@WebServlet({"/myQnAList", "/myQnAWrite", "/myQnAEdit", "/myQnADelete"})
public class MyQnA extends HttpServlet {
	private static final long serialVersionUID = 1L;
	 private MyQnAService service = new MyQnAServiceImpl();
       
    public MyQnA() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 로그인 체크
        HttpSession session = request.getSession(false);
        String userId = session!=null ? (String)session.getAttribute("userId") : null;
        if (userId == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String path = request.getServletPath();
        switch (path) {
            case "/myQnAList":
                list(request, response, userId);
                break;
            case "/myQnAWrite":
                // 단순 폼 보여주기
                request.getRequestDispatcher("/user/myQnAWrite.jsp")
                   .forward(request, response);
                break;
            case "/myQnAEdit":
                showEditForm(request, response, userId);
                break;
            case "/myQnADelete":
                delete(request, response);
                break;
            default:
                response.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		// 로그인 체크
        HttpSession session = request.getSession(false);
        String userId = session!=null ? (String)session.getAttribute("userId") : null;
        if (userId == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String path = request.getServletPath();
        switch (path) {
            case "/myQnAWrite":
                create(request, response, userId);
                break;
            case "/myQnAEdit":
                update(request, response, userId);
                break;
            default:
                response.sendError(HttpServletResponse.SC_METHOD_NOT_ALLOWED);
        }
    }

    // ─ 목록
    private void list(HttpServletRequest req, HttpServletResponse resp, String userId)
            throws ServletException, IOException {
        int page = 1;
        String p = req.getParameter("page");
        if (p != null) {
            try { page = Integer.parseInt(p); } catch (NumberFormatException e) {}
        }
        PageInfo pageInfo = new PageInfo(page);

        try {
            List<QnA> list = service.getMyQnAList(userId, pageInfo);
            req.setAttribute("qnaList", list);
            req.setAttribute("pageInfo", pageInfo);
            req.getRequestDispatcher("/user/myQnAList.jsp")
               .forward(req, resp);
        } catch (Exception e) {
            throw new ServletException("QnA 목록 조회 중 오류", e);
        }
    }

    // ─ 새 글 등록
    private void create(HttpServletRequest req, HttpServletResponse resp, String userId)
            throws IOException, ServletException {
        try {
            QnA q = new QnA();
            q.setUserId(userId);
            q.setTitle(req.getParameter("title"));
            q.setContent(req.getParameter("content"));
            q.setType(req.getParameter("type"));
            service.createQnA(q);
            resp.sendRedirect(req.getContextPath() + "/myQnAList");
        } catch (Exception e) {
            throw new ServletException("QnA 등록 중 오류", e);
        }
    }

    // ─ 수정 폼 보여주기
    private void showEditForm(HttpServletRequest req, HttpServletResponse resp, String userId)
            throws ServletException, IOException {
        int id = Integer.parseInt(req.getParameter("id"));
        try {
            QnA q = service.getQnAById(id);
            // 안전을 위해 소유자 검증
            if (!userId.equals(q.getUserId())) {
                resp.sendError(HttpServletResponse.SC_FORBIDDEN);
                return;
            }
            req.setAttribute("qna", q);
            req.getRequestDispatcher("/user/myQnAEdit.jsp")
               .forward(req, resp);
        } catch (Exception e) {
            throw new ServletException("QnA 수정 폼 조회 중 오류", e);
        }
    }

    // ─ 글 수정
    private void update(HttpServletRequest req, HttpServletResponse resp, String userId)
            throws IOException, ServletException {
        try {
            QnA q = new QnA();
            q.setQnaId(Integer.parseInt(req.getParameter("qnaId")));
            q.setUserId(userId);
            q.setTitle(req.getParameter("title"));
            q.setContent(req.getParameter("content"));
            q.setType(req.getParameter("type"));
            service.updateQnA(q);
            resp.sendRedirect(req.getContextPath() + "/myQnAList");
        } catch (Exception e) {
            throw new ServletException("QnA 수정 중 오류", e);
        }
    }

    // ─ 글 삭제
    private void delete(HttpServletRequest req, HttpServletResponse resp)
            throws IOException, ServletException {
        int id = Integer.parseInt(req.getParameter("id"));
        try {
            service.deleteQnA(id);
            resp.sendRedirect(req.getContextPath() + "/myQnAList");
        } catch (Exception e) {
            throw new ServletException("QnA 삭제 중 오류", e);
        }
    }
}
