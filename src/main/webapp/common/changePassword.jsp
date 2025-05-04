<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    String sessionUserId = (String) session.getAttribute("userId");
    String resetUserId  = (String) session.getAttribute("resetUserId");
    if (sessionUserId == null && resetUserId == null) {
        response.sendRedirect(request.getContextPath() + "/findPassword");
        return;
    }
    String targetUserId = (resetUserId != null) ? resetUserId : sessionUserId;
%>
<!-- changePassword.jsp 최상단에 추가 -->
<c:if test="${param.error == 'same'}">
  <script>
    alert('새 비밀번호가 이전 비밀번호와 동일합니다.');
    <c:choose>
      <c:when test="${not empty sessionScope.userId}">
        window.location.href='${pageContext.request.contextPath}/memberInfoEdit';
      </c:when>
      <c:otherwise>
        window.location.href='${pageContext.request.contextPath}/login';
      </c:otherwise>
    </c:choose>
  </script>
</c:if>
<c:if test="${param.error == 'wrong'}">
  <script>alert('현재 비밀번호가 일치하지 않습니다.');</script>
</c:if>

<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8"/>
  <title>비밀번호 변경</title>
  <style>
    body {
      margin: 0;
      padding: 0;
      background-color: #f5f5f5;
      font-family: 'Noto Sans KR', sans-serif;
      color: #333;
    }
    .main-container {
      display: flex;
      justify-content: center;
      padding: 60px 20px;
    }
    .card {
      background: #fff;
      width: 100%;
      max-width: 400px;
      border-radius: 8px;
      box-shadow: 0 2px 8px rgba(0,0,0,0.1);
      padding: 30px 20px;
    }
    .card h2 {
      margin: 0 0 20px;
      font-size: 1.5rem;
      text-align: center;
    }
    .form-group {
      margin-bottom: 15px;
    }
    .form-group label {
      display: block;
      margin-bottom: 5px;
      font-weight: bold;
    }
    .form-group input {
      width: 100%;
      padding: 10px;
      border: 1px solid #ccc;
      border-radius: 4px;
      box-sizing: border-box;
      font-size: 0.9rem;
    }
    .btn-submit {
      width: 100%;
      padding: 12px;
      background-color: #303030;
      color: #fff;
      border: none;
      border-radius: 4px;
      font-size: 1rem;
      cursor: pointer;
    }
    .btn-submit:hover {
      background-color: #1a1a1a;
    }
  </style>
</head>
<body>
  <jsp:include page="/header" />
  <%@ include file="scrollTop.jsp" %>

  <div class="main-container">
    <div class="card">
      <h2>비밀번호 변경</h2>
      <form action="${pageContext.request.contextPath}/changePassword" method="post">
        <c:if test="${not empty sessionScope.userId}">
          <div class="form-group">
            <label for="currentPassword">현재 비밀번호</label>
            <input id="currentPassword" type="password" name="currentPassword" required/>
          </div>
        </c:if>
        <div class="form-group">
          <label for="newPassword">새 비밀번호</label>
          <input id="newPassword" type="password" name="newPassword" required/>
        </div>
        <div class="form-group">
          <label for="confirmPassword">비밀번호 확인</label>
          <input id="confirmPassword" type="password" name="confirmPassword" required/>
        </div>
        <input type="hidden" name="userId" value="<%= targetUserId %>"/>
        <button type="submit" class="btn-submit">변경하기</button>
      </form>
    </div>
  </div>

<jsp:include page="footer.jsp"/>
</body>
</html>
