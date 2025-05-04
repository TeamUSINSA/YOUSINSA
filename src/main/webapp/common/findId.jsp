<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8" />
  <title>아이디 찾기</title>
  <style>
    body {
      font-family: sans-serif;
      background-color: #f9f9f9;
      color: #333;
    }
    .container {
      max-width: 400px;
      margin: 100px auto;
      background: #fff;
      padding: 30px;
      border-radius: 8px;
      box-shadow: 0 0 10px rgba(0,0,0,0.05);
    }
    h1 {
      text-align: center;
      margin-bottom: 24px;
    }
    label {
      font-size: 14px;
      margin-bottom: 6px;
      display: block;
    }
    input {
      width: 100%;
      padding: 10px;
      margin-bottom: 16px;
      border: 1px solid #ccc;
      border-radius: 4px;
    }
    button {
      width: 100%;
      padding: 12px;
      background: #000;
      color: #fff;
      border: none;
      border-radius: 4px;
      font-weight: bold;
      cursor: pointer;
    }
    button:hover {
      background: #333;
    }
  </style>
</head>
<body>
<jsp:include page="/header" />
<%@ include file="scrollTop.jsp" %>
  <div class="container">
    <h1>아이디 찾기</h1>
    <form action="findId" method="post">
      <label for="name">이름</label>
      <input type="text" id="name" name="name" placeholder="이름을 입력해주세요.">
      
      <label for="email">이메일</label>
      <input type="email" id="email" name="email" placeholder="이메일 주소를 입력해주세요.">
      
      <label for="phone">휴대폰 번호</label>
      <input type="tel" id="phone" name="phone" placeholder="휴대폰 번호를 입력해주세요.">
      
      <button type="submit">아이디 찾기</button>
    </form>
  </div>
   <jsp:include page="footer.jsp"/>
</body>
</html>
