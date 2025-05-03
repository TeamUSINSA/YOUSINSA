<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8" />
  <title>아이디 찾기 결과</title>
  <style>
    body {
      font-family: sans-serif;
      background-color: #f2f2f2;
      margin: 0;
      padding: 0;
      color: #333;
    }
    .container {
      max-width: 400px;
      margin: 120px auto;
      padding: 30px;
      background-color: #fff;
      border-radius: 8px;
      box-shadow: 0 0 10px rgba(0,0,0,0.05);
      text-align: center;
    }
    h2 {
      font-size: 20px;
      margin-bottom: 16px;
    }
    p {
      font-size: 14px;
      margin-bottom: 24px;
    }
    .bold {
      font-weight: bold;
    }
    .buttons a {
      display: inline-block;
      padding: 10px 16px;
      margin: 0 6px;
      font-size: 13px;
      text-decoration: none;
      border-radius: 4px;
    }
    .btn-black {
      background-color: #000;
      color: #fff;
    }
    .btn-gray {
      background-color: #e0e0e0;
      color: #333;
    }
    .btn-black:hover {
      background-color: #333;
    }
    .btn-gray:hover {
      background-color: #ccc;
    }
  </style>
</head>
<body>
<jsp:include page="/header" />
<%@ include file="scrollTop.jsp" %>
  <div class="container">
    <h2>아이디 찾기 결과</h2>
    <c:choose>
  <c:when test="${userId eq 'notfound'}">
    <p class="bold">일치하는 정보가 없습니다.</p>
  </c:when>
  <c:otherwise>
    <p>당신의 아이디는 <span class="bold">${userId}</span> 입니다.</p>
  </c:otherwise>
</c:choose>
    <div class="buttons">
      <a href="login" class="btn-black">로그인</a>
      <a href="findPassword" class="btn-gray">비밀번호 찾기</a>
      <a href="main" class="btn-gray">메인으로</a>
    </div>
  </div>
   <jsp:include page="footer.jsp"/>
</body>
</html>
