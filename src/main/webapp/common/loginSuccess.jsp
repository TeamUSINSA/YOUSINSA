<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="true" %>
<%
    String userId = (String) session.getAttribute("userId");
    if (userId == null) {
        response.sendRedirect(request.getContextPath() + "/user/login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>환영합니다</title>
  <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-white text-sm text-gray-700">

<jsp:include page="/header" />

<main class="flex flex-col items-center justify-center py-24 px-4">
  <div class="border rounded-lg px-6 py-10 w-full max-w-lg shadow-sm text-center">
    <h2 class="text-2xl font-semibold mb-6">환영합니다</h2>
    <p class="text-lg font-bold text-green-600">${sessionScope.userId}님, 환영합니다!</p>
    <p class="text-sm mt-4">유신사에 오신 것을 환영합니다.</p>

    <div class="mt-6 flex justify-center gap-4">
      <a href="${pageContext.request.contextPath}/main"
         class="bg-black text-white px-4 py-2 rounded text-sm">
        메인화면으로
      </a>

      <c:choose>
        <c:when test="${sessionScope.isSeller}">
          <a href="${pageContext.request.contextPath}/adminOrderSearch"
             class="bg-gray-700 text-white px-4 py-2 rounded text-sm">
            마이페이지로
          </a>
        </c:when>
        <c:otherwise>
          <a href="${pageContext.request.contextPath}/myLikeList"
             class="bg-gray-700 text-white px-4 py-2 rounded text-sm">
            마이페이지로
          </a>
        </c:otherwise>
      </c:choose>
    </div>

  </div>
</main>

<jsp:include page="/footer" />

</body>
</html>
