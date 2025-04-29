<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>상품 검색</title>
  <jsp:include page="../common/header.jsp" />
  <jsp:include page="adminSideBarStyle.jsp" />

  <style>
    body {
      font-family: 'Pretendard', sans-serif;
      background-color: #f8f8f8;
      margin: 0;
      min-height: 100vh;
    }
    .content-wrapper {
      display: flex;
      gap: 20px;
      margin: 20px;
    }
    .content-wrapper > div:first-child {
      width: 280px;
      background: white;
      box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
      border-radius: 10px;
      padding: 20px;
      flex-shrink: 0;
      min-height: 600px;
    }
    .main-content {
      flex-grow: 1;
      background: white;
      padding: 40px 50px;
      border-radius: 10px;
      box-shadow: 0 4px 10px rgba(0, 0, 0, 0.05);
      min-height: 600px;
    }
    h2 {
      font-size: 24px;
      font-weight: bold;
      margin-bottom: 30px;
    }
    .search-form {
      text-align: center;
      margin-bottom: 30px;
    }
    .search-form label {
      margin-right: 20px;
      font-size: 14px;
    }
    .search-form input[type="text"] {
      padding: 8px 10px;
      width: 300px;
      border-radius: 6px;
      border: 1px solid #ccc;
    }
    .search-btn {
      padding: 8px 20px;
      background-color: #111;
      color: white;
      border: none;
      border-radius: 6px;
      margin-left: 10px;
      cursor: pointer;
      font-size: 14px;
    }
    .search-btn:hover {
      background-color: #333;
    }
    table {
      width: 100%;
      border-collapse: collapse;
      font-size: 14px;
      margin-top: 30px;
    }
    th, td {
      padding: 12px 10px;
      text-align: center;
      border-bottom: 1px solid #eee;
    }
    thead {
      background-color: #f0f0f0;
    }
    tr:hover {
      background-color: #f9f9f9;
      cursor: pointer;
    }
    .product-img {
      width: 60px;
      height: 60px;
      object-fit: cover;
      border-radius: 6px;
    }
  </style>

  <script>
    function goToModify(productId) {
      location.href = '${contextPath}/adminProductModify?productId=' + productId;
    }
  </script>
</head>

<body>
<div class="content-wrapper">
  <!-- 사이드바 -->
  <jsp:include page="adminSideBar.jsp" />

  <!-- 메인 콘텐츠 -->
  <div class="main-content">
    <h2>상품 검색</h2>
    <div>
      <form method="post" action="${contextPath}/adminProductSearch" class="search-form">
        <div>
          <c:choose>
            <c:when test="${searchType eq 'name'}">
              <label><input type="radio" name="searchType" value="name" checked> 상품명</label>
              <label><input type="radio" name="searchType" value="product_id"> 제품코드</label>
            </c:when>
            <c:otherwise>
              <label><input type="radio" name="searchType" value="name"> 상품명</label>
              <label><input type="radio" name="searchType" value="product_id" checked> 제품코드</label>
            </c:otherwise>
          </c:choose>
        </div>

        <div style="margin-top: 20px;">
          <input type="text" name="keyword" required value="${keyword}" />
          <button type="submit" class="search-btn">검색</button>
        </div>
      </form>

      <table>
        <thead>
          <tr>
            <th>이미지</th>
            <th>상품명</th>
            <th>제품코드</th>
          </tr>
        </thead>
        <tbody>
          <c:choose>
            <c:when test="${not empty productList}">
              <c:forEach var="product" items="${productList}">
                <tr onclick="goToModify('${product.productId}')">
                  <td><img src="${contextPath}/image?filename=${product.mainImage1}" alt="이미지" class="product-img" /></td>
                  <td>${product.name}</td>
                  <td>${product.productId}</td>
                </tr>
              </c:forEach>
            </c:when>
            <c:otherwise>
              <tr><td colspan="3">검색 결과가 없습니다.</td></tr>
            </c:otherwise>
          </c:choose>
        </tbody>
      </table>

    </div>
  </div>
</div>

<jsp:include page="../common/footer.jsp" />
</body>
</html>
