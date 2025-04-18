<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
  String categoryId = request.getParameter("categoryId");
  String subCategoryId = request.getParameter("subCategoryId");
%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8" />
  <title>상품 리스트</title>
  <style>
    body {
      font-family: 'Arial', sans-serif;
      margin: 40px;
      text-align: center;
    }

    .category-menu, .subcategory-menu {
      margin-bottom: 20px;
    }

    .category-menu a,
    .subcategory-menu a {
      margin: 0 10px;
      text-decoration: none;
      color: #333;
      font-weight: bold;
    }
    .category-menu,
.subcategory-menu {
  display: flex;
  justify-content: center;
  gap: 30px;
  font-size: 20px;
  margin-bottom: 20px;
}

.active-category {
  font-weight: bold;
  font-size: 24px;
  color: crimson;
}
    

    .active {
      color: crimson;
    }

    .product-grid {
      display: flex;
      flex-wrap: wrap;
      justify-content: center;
      gap: 30px;
      margin-top: 40px;
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

  <!-- ✅ 대분류 카테고리 메뉴 -->
  <div class="category-menu">
  <c:forEach var="cat" items="${categoryList}">
    <c:if test="${cat.categoryId == categoryId}">
      <span class="active-category">${cat.categoryName}</span>
    </c:if>
  </c:forEach>
</div>

  <!-- ✅ 선택된 categoryId에 해당하는 서브카테고리만 출력 -->
  <c:if test="${not empty categoryId}">
    <div class="subcategory-menu">
      <c:forEach var="sub" items="${subCategoryList}">
        <c:if test="${sub.categoryId == categoryId}">
          <a href="/yousinsa/productList?categoryId=${sub.categoryId}&subCategoryId=${sub.subCategoryId}"
             class="${sub.subCategoryId == subCategoryId ? 'active' : ''}">
            ${sub.subCategoryName}
          </a>
        </c:if>
      </c:forEach>
    </div>
  </c:if>

  <!-- ✅ 상품 목록 -->
  <div class="product-grid">
    <c:forEach var="product" items="${productList}">
      <div class="product-item">
        <img src="${product.mainImage1}" alt="${product.name}" />
        <div class="product-info">
          <div>${product.name}</div>
          <div class="product-discount">${product.discount}% ${product.price}원</div>
        </div>
      </div>
    </c:forEach>
  </div>

  <!-- ✅ 상품 없을 경우 안내 -->
  <c:if test="${empty productList}">
    <p>상품이 없습니다.</p>
  </c:if>

</body>
</html>
