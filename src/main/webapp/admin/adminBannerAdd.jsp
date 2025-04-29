<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8" />
  <title>배너 등록</title>
  <jsp:include page="../common/header.jsp"/>
  <jsp:include page="adminSideBarStyle.jsp" />
  <style>
    body {
      margin: 0;
      font-family: 'Pretendard', sans-serif;
      background-color: #f8f8f8;
    }
    h1 {
      font-size: 24px;
      font-weight: bold;
      margin-bottom: 30px;
      text-align: center;
    }
    .container {
      background-color: white;
      padding: 30px;
      border-radius: 12px;
      box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
      width: 80%;
      margin: 20px auto;
    }
    .form-group {
      margin-bottom: 20px;
    }
    .form-group label {
      display: block;
      font-weight: 500;
      margin-bottom: 8px;
    }
    .form-group input[type="text"],
    .form-group input[type="file"],
    .form-group input[type="number"],
    .form-group select {
      width: 100%;
      padding: 10px;
      border: 1px solid #ddd;
      border-radius: 6px;
    }
    .btn-submit {
      background-color: #2563eb;
      color: white;
      padding: 12px 20px;
      border: none;
      border-radius: 6px;
      font-weight: bold;
      cursor: pointer;
      width: 100%;
    }
    .btn-submit:hover {
      background-color: #1e40af;
    }
    .btn-back {
      background-color: #333;
      color: white;
      padding: 10px 20px;
      border-radius: 6px;
      font-weight: bold;
      text-decoration: none;
      margin-top: 20px;
      display: inline-block;
      text-align: center;
      width: 100%;
    }
    .btn-back:hover {
      background-color: #111;
    }
    .msg {
      color: green;
      font-weight: bold;
      margin-bottom: 20px;
      text-align: center;
    }
    .content-wrapper {
      display: flex;
      gap: 20px;
    }
    .content-main {
      flex: 1;
    }
  </style>
</head>
<body>
  <div class="content-wrapper">
    <jsp:include page="adminSideBar.jsp" />
    <div class="content-main">
      <div class="container">
        <h1>배너 등록</h1>

        <c:if test="${not empty msg}">
          <p class="msg">${msg}</p>
        </c:if>

        <form action="${pageContext.request.contextPath}/adminBannerAdd" method="post" enctype="multipart/form-data">
          <div class="form-group">
            <label>배너 이미지</label>
            <input type="file" name="img" required />
          </div>

          <div class="form-group">
            <label>배너 이름</label>
            <input type="text" name="name" required />
          </div>

          <div class="form-group">
            <label>상품 ID</label>
            <input type="number" name="productId" required />
          </div>

          <div class="form-group">
            <label>배너 위치</label>
            <select name="position" required>
              <option value="top">상단</option>
              <option value="middle">중단</option>
            </select>
          </div>

          <button type="submit" class="btn-submit">등록</button>
        </form>

        <div style="margin-top: 30px;">
          <a href="${pageContext.request.contextPath}/adminBanner" class="btn-back">배너 목록으로 돌아가기</a>
        </div>
      </div>
    </div>
  </div>

  <jsp:include page="../common/footer.jsp"/>
</body>
</html>
