<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page session="true" %>
<%
    String savedId = "";
    Cookie[] cookies = request.getCookies();
    if (cookies != null) {
        for (Cookie c : cookies) {
            if ("saveId".equals(c.getName())) {
                savedId = c.getValue();
                break;
            }
        }
    }
%>
<c:if test="${not empty errMsg}">
  <script>
    alert('${errMsg}');
  </script>
</c:if>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8" />
  <title>로그인</title>
  <style>
    body {
      margin: 0;
      font-family: sans-serif;
      background-color: #fff;
      color: #333;
      min-height: 100vh;
      display: flex;
      flex-direction: column;
    }

    main {
      flex-grow: 1;
      max-width: 400px;
      margin: 0 auto;
      padding: 80px 20px;
      text-align: center;
    }

    h1 {
      font-size: 24px;
      font-weight: bold;
      margin-bottom: 24px;
    }

    form {
      display: flex;
      flex-direction: column;
      gap: 12px;
    }

    input[type="text"],
    input[type="password"] {
      padding: 10px;
      border: 1px solid #ccc;
      border-radius: 4px;
      width: 100%;
      box-sizing: border-box;
    }

    button {
      padding: 10px;
      background-color: #000;
      color: #fff;
      border: none;
      border-radius: 4px;
      cursor: pointer;
    }

    .checkbox {
      display: flex;
      align-items: center;
      font-size: 14px;
    }

    .checkbox input {
      margin-right: 6px;
    }

    .links {
      margin-top: 16px;
      font-size: 12px;
      color: #777;
    }

    .links a {
      color: #777;
      text-decoration: none;
      margin: 0 6px;
    }

    .links a:hover {
      text-decoration: underline;
    }
  </style>
</head>

<body>
  <jsp:include page="/header" />

  <main>
    <h1>LOGIN</h1>

    <form action="${pageContext.request.contextPath}/login" method="post">
      <input type="text" name="userId" placeholder="아이디" required
             value="<%= savedId %>" />

      <input type="password" name="password" placeholder="비밀번호" required />

      <div class="checkbox">
        <input type="checkbox" id="saveId" name="saveId"
               <%= !savedId.isEmpty() ? "checked" : "" %> />
        <label for="saveId">아이디 저장</label>
      </div>

      <button type="submit">로그인</button>
    </form>

    <div class="links">
      <a href="findId">아이디 찾기</a> |
      <a href="findPassword">비밀번호 찾기</a> |
      <a href="join">회원가입</a>
    </div>
  </main>

  <jsp:include page="/footer" />
</body>

</html>
