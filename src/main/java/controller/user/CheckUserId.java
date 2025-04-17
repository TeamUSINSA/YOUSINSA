//package controller.user;
//
//import java.io.IOException;
//
//import javax.servlet.annotation.WebServlet;
//import javax.servlet.http.HttpServlet;
//import javax.servlet.http.HttpServletRequest;
//import javax.servlet.http.HttpServletResponse;
//
//import service.user.UserService;
//import service.user.UserServiceImpl;
//
///**
// * Servlet implementation class CheckUserId
// */
//@WebServlet("/checkUserId")
//public class CheckUserId extends HttpServlet {
//  private UserService service = new UserServiceImpl();
//
//  protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
//    String id = request.getParameter("id");
//    boolean exists = service.findUserById(id) != null;
//    response.setContentType("text/plain");
//    response.getWriter().write(exists ? "duplicate" : "available");
//  }
//}