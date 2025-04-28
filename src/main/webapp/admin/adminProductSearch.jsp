<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page import="java.util.*" %>

<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
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
    }
    .main-layout {
      display: flex;
      min-height: 100vh;
    }
    .sidebar {
      width: 250px;
      background: #ffffff;
      border-right: 1px solid #ddd;
    }
    .main-content {
      flex: 1;
      padding: 40px;
      background-color: #f8f8f8;
    }
    h2 {
      font-size: 24px;
      font-weight: bold;
      margin-bottom: 20px;
    }
    .container {
      background-color: white;
      padding: 40px;
      border-radius: 12px;
      box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
      max-width: 1000px;
      margin: auto;
    }
    .search-options {
      text-align: center;
      margin-bottom: 20px;
    }
    .search-options label {
      margin-right: 20px;
      font-size: 14px;
    }
    input[type="text"] {
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
    }
    .search-btn:hover {
      background-color: #333;
    }
    table {
      width: 100%;
      border-collapse: collapse;
      margin-top: 30px;
    }
    th, td {
      padding: 12px 10px;
      text-align: center;
      border-bottom: 1px solid #eee;
    }
    th {
      background-color: #f0f0f0;
    }
    .product-img {
      width: 60px;
      height: 60px;
      object-fit: cover;
      border-radius: 6px;
    }
  </style>
</head>
<body>

<div class="main-layout">
  <div class="sidebar">
    <jsp:include page="adminSideBar.jsp" />
  </div>

  <div class="main-content">
    <h2>상품 검색</h2>
    <div class="container">
      <form method="post" action="${contextPath}/adminProductSearch">
        <div class="search-options">
          <c:choose>
            <c:when test="${searchType eq 'name' }">
              <label><input type="radio" name="searchType" value="name" checked> 상품명</label>
              <label><input type="radio" name="searchType" value="product_id"> 제품코드</label>
            </c:when>
            <c:otherwise>
              <label><input type="radio" name="searchType" value="name"> 상품명</label>
              <label><input type="radio" name="searchType" value="product_id" checked> 제품코드</label>
            </c:otherwise>
          </c:choose>
        </div>
        <div style="text-align: center;">
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
              <tr>
                <td><img src="image?filename=${product.mainImage1}" alt="이미지" class="product-img" /></td>
                <td>${product.name}</td>
                <td>${product.productId}</td>
              </tr>
            </c:forEach>
          </c:when>
          <c:otherwise>
            <tr>
              <td colspan="3">검색 결과가 없습니다.</td>
            </tr>
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
