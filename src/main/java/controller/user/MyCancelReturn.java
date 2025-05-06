package controller.user;

import java.io.IOException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;
import java.util.Map;
import java.util.HashMap;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dto.order.Cancel;
import dto.order.Return;
import dto.user.CancelReturn;
import service.user.MyCancelService;
import service.user.MyCancelServiceImpl;
import service.user.MyReturnService;
import service.user.MyReturnServiceImpl;

@WebServlet("/myCancelList")
public class MyCancelReturn extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private MyCancelService  cancelService = new MyCancelServiceImpl();
    private MyReturnService  returnService = new MyReturnServiceImpl();

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        String userId = (String) session.getAttribute("userId");

        // 1) 파라미터 읽어서 yyyy-MM-dd 형태로 만들기
        String sy = request.getParameter("startYear");
        String sm = request.getParameter("startMonth");
        String sd = request.getParameter("startDay");
        String ey = request.getParameter("endYear");
        String em = request.getParameter("endMonth");
        String ed = request.getParameter("endDay");

        if (sm != null && sm.length() == 1) sm = "0"+sm;
        if (sd != null && sd.length() == 1) sd = "0"+sd;
        if (em != null && em.length() == 1) em = "0"+em;
        if (ed != null && ed.length() == 1) ed = "0"+ed;

        LocalDate today = LocalDate.now();
        String startDate = (sy!=null&&sm!=null&&sd!=null)
                         ? String.format("%s-%s-%s", sy,sm,sd)
                         : today.minusMonths(1).toString();
        String endDate   = (ey!=null&&em!=null&&ed!=null)
                         ? String.format("%s-%s-%s", ey,em,ed)
                         : today.toString();

        // 2) 검색 기간을 JSP에서 유지하도록 속성에 저장
        request.setAttribute("startDate", startDate);
        request.setAttribute("endDate",   endDate);
        request.setAttribute("currentYear", today.getYear());

        try {
            // 3) 취소/반품 각각 조회
            Map<String,Object> params = new HashMap<>();
            params.put("userId",    userId);
            params.put("startDate", startDate);
            params.put("endDate",   endDate);

            List<Cancel> cancels = cancelService.getCancels(userId, startDate, endDate);
            List<Return> returns = returnService.getReturns(userId, startDate, endDate);

            // 4) DTO 변환 + 합치기
            List<CancelReturn> mixed = new ArrayList<>();
         // — 취소 레코드
            for (Cancel c : cancels) {
                CancelReturn cr = new CancelReturn();
                cr.setType("C");
                cr.setRecordId(c.getCancelId());            // ← cancelId
                cr.setOrderId(c.getOrderId());
                cr.setOrderDate(c.getOrder().getOrderDate());
                cr.setActionDate(c.getCancelDate());
                cr.setReason(c.getReason());
                cr.setStatus(c.getOrder().getDeliveryStatus());
                // Cancel.orderItems 에 이미 “취소된 품목”만 담겨 있다고 가정
                cr.setItems(c.getOrderItems());
                mixed.add(cr);
            }

            // — 반품 레코드
            for (Return r : returns) {
                CancelReturn cr = new CancelReturn();
                cr.setType("R");
                cr.setRecordId(r.getReturnId());            // ← returnId
                cr.setOrderId(r.getOrderId());
                cr.setOrderDate(r.getOrder().getOrderDate());
                cr.setActionDate(r.getReturnDate());
                cr.setReason(r.getReason());
                cr.setStatus(r.getOrder().getDeliveryStatus());
                // Return.orderItems 에 이미 “반품된 품목”만 담겨 있다고 가정
                cr.setItems(r.getOrderItems());
                mixed.add(cr);
            }

            // 5) 날짜(반품/취소일) 내림차순 정렬
            Collections.sort(mixed, Comparator.comparing(CancelReturn::getActionDate).reversed());

            // 6) JSP 에 넘기기
            request.setAttribute("cancelList", mixed);
            request.getRequestDispatcher("/user/myCancelList.jsp")
                   .forward(request, response);

        } catch (Exception e) {
            throw new ServletException("취소/반품 목록 조회 중 오류 발생", e);
        }
    }


    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
