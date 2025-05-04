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
  <style>
    body {
      background-color: white;
      font-size: 14px;
      color: #4a5568;
      margin: 0;
      padding: 0;
      font-family: 'Noto Sans KR', sans-serif;
    }

    main {
      display: flex;
      flex-direction: column;
      align-items: center;
      justify-content: center;
      padding: 96px 16px;
    }

    .welcome-box {
      border: 1px solid #e5e7eb;
      border-radius: 8px;
      padding: 40px 24px;
      width: 100%;
      max-width: 640px;
      box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
      text-align: center;
    }

    .welcome-box h2 {
      font-size: 24px;
      font-weight: 600;
      margin-bottom: 24px;
    }

    .welcome-name {
      font-size: 18px;
      font-weight: bold;
      color: #16a34a;
    }

    .welcome-text {
      font-size: 14px;
      margin-top: 16px;
    }

    .button-group {
      margin-top: 24px;
      display: flex;
      justify-content: center;
      gap: 16px;
    }

    .btn {
      padding: 8px 16px;
      border-radius: 4px;
      font-size: 14px;
      text-decoration: none;
      display: inline-block;
    }

    .btn-black {
      background-color: #303030;
      color: white;
    }

    .btn-gray {
      background-color: #4b5563;
      color: white;
    }
  </style>
</head>
<body>

<jsp:include page="/header" />
<%@ include file="scrollTop.jsp" %>

<main>
  <div class="welcome-box">
    <h2>환영합니다</h2>
    <p class="welcome-name">${sessionScope.name}님, 환영합니다!</p>
    <p class="welcome-text">유신사에 오신 것을 환영합니다.</p>

    <div class="button-group">
      <a href="${pageContext.request.contextPath}/main" class="btn btn-black">
        메인화면으로
      </a>

      <c:choose>
        <c:when test="${sessionScope.isSeller}">
          <a href="${pageContext.request.contextPath}/adminOrderSearch" class="btn btn-gray">
            마이페이지로
          </a>
        </c:when>
        <c:otherwise>
          <a href="${pageContext.request.contextPath}/myLikeList" class="btn btn-gray">
            마이페이지로
          </a>
        </c:otherwise>
      </c:choose>
    </div>
  </div>
</main>

<jsp:include page="footer.jsp"/>

</body>
</html>
