<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
  String currentCategoryId = request.getParameter("categoryId");
  String currentSubCategoryId = request.getParameter("subCategoryId");
%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8" />
  <title>카테고리 페이지</title>
  <style>
    body {
      font-family: 'Arial', sans-serif;
      margin: 40px;
      text-align: center;
    }

    .category-menu, .subcategory-menu {
      margin-bottom: 30px;
    }

    .category-menu a,
    .subcategory-menu a {
      margin: 0 10px;
      text-decoration: none;
      color: #333;
      font-weight: bold;
    }

    .active {
      color: crimson;
    }

    .product-grid {
      display: flex;
      flex-wrap: wrap;
      justify-content: center;
      gap: 30px;
    }

    .product-item {
      width: 23%;
      min-width: 200px;
      text-align: left;
    }

    .product-item img {
      width: 100%;
      border-radius: 4px;
    }

    .product-info {
      margin-top: 10px;
    }

    .product-discount {
      color: red;
      font-weight: bold;
    }
  </style>
</head>
<body>

  <!-- ✅ 대분류 카테고리 -->
  <div class="category-menu">
    <c:forEach var="cat" items="${categoryList}">
      <a href="category.jsp?categoryId=${cat.categoryId}" class="${cat.categoryId == currentCategoryId ? 'active' : ''}">
        ${cat.categoryName}
      </a>
    </c:forEach>
  </div>

  <!-- ✅ 소분류 카테고리 -->
  <div class="subcategory-menu">
    <c:forEach var="sub" items="${subCategoryList}">
      <c:if test="${sub.categoryId == currentCategoryId}">
        <a href="category.jsp?categoryId=${sub.categoryId}&subCategoryId=${sub.subCategoryId}" class="${sub.subCategoryId == currentSubCategoryId ? 'active' : ''}">
          ${sub.subCategoryName}
        </a>
      </c:if>
    </c:forEach>
  </div>

  <!-- ✅ 상품 목록 -->
  <div class="product-grid">
    <c:forEach var="product" items="${productList}">
      <c:if test="${product.subCategoryId == currentSubCategoryId}">
        <div class="product-item">
          <img src="${product.imageUrl}" alt="${product.name}" />
          <div class="product-info">
            <div>${product.name}</div>
            <div class="product-discount">${product.discount}% ${product.price}원</div>
          </div>
        </div>
      </c:if>
    </c:forEach>
  </div>

</body>
</html>
