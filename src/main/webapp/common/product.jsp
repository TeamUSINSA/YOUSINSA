          <%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%
  // 서블릿에서 request.setAttribute("selectedCategoryId", Integer)로 넘긴 값
  Integer selCatId = (Integer) request.getAttribute("selectedCategoryId");
  String paramSub = request.getParameter("subCategoryId");
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
	display: flex;
	justify-content: center;
	gap: 30px;
	font-size: 20px;
	margin-bottom: 20px;
}

.category-menu a, .subcategory-menu a {
	text-decoration: none;
	color: #333;
	font-weight: bold;
}

.active-category {
	color: crimson;
	border-bottom: 2px solid crimson;
	padding-bottom: 2px;
}

.active {
	color: crimson;
	text-decoration: underline;
}

.product-grid {
	display: grid;
	grid-template-columns: repeat(4, 1fr);
	gap: 40px 20px;
	max-width: 1200px;
	margin: 40px auto;
}

.product-item {
	text-align: left;
	font-size: 14px;
}

.product-item img {
	width: 100%;
	height: 250px; /* 고정 높이 */
	object-fit: cover;
	border-radius: 4px;
}

.product-info {
	margin-top: 10px;
}

.product-name {
	font-weight: 500;
	margin-bottom: 4px;
}

.product-discount {
	color: red;
	font-weight: bold;
	margin-right: 5px;
}

.empty-message {
	text-align: center;
	font-size: 18px;
	color: #888;
	margin-top: 100px;
}
  .subcategory-menu a {
    text-decoration: none;
    color: #333;
    font-weight: bold;
  }

  .subcategory-menu a.active {
    color: crimson;
    text-decoration: underline;
  }
</style>
</head>
<body>
	<jsp:include page="/header" />


<!-- 1) 선택된 상위 카테고리 한 개만 -->
<div class="current-category" style="text-align:center; margin:20px 0;">
  <c:forEach var="cat" items="${categoryList}">
    <c:if test="${cat.categoryId == selectedCategoryId}">
      <h2>
        <a
          href="${pageContext.request.contextPath}/productList?categoryId=${cat.categoryId}"
          class="${empty param.subCategoryId ? 'active-category' : ''}"
          style="text-decoration:none; color:inherit;"
        >
          ${cat.categoryName}
        </a>
      </h2>
    </c:if>
  </c:forEach>
</div>


<!-- 2) 해당 상위 카테고리에 속한 서브카테고리 전부 -->
<c:if test="${not empty selectedCategoryId}">
  <div class="subcategory-menu" style="display:flex; justify-content:center; gap:20px; margin-bottom:40px;">
    <c:forEach var="sub" items="${subCategoryList}">
      <c:if test="${sub.categoryId == selectedCategoryId}">
        <a href="${pageContext.request.contextPath}/productList?categoryId=${selectedCategoryId}&subCategoryId=${sub.subCategoryId}"
           class="${sub.subCategoryId == param.subCategoryId ? 'active' : ''}">
          ${sub.subCategoryName}
        </a>
      </c:if>
    </c:forEach>
  </div>
</c:if>

	<!-- ✅ 상품 리스트 -->
<c:if test="${not empty productList}">
  <div class="product-grid">
<c:forEach var="product" items="${productList}">
  <div class="product-item">
    <a href="/yousinsa/productDetail?productId=${product.productId}" style="text-decoration: none; color: inherit;">
      <img src="/yousinsa/image/${product.mainImage1}" alt="${product.name}" />
      <div class="product-info">
        <div class="product-name">${product.name}</div>

        <c:choose>
          <c:when test="${product.discount > 0}">
            <div>
              <span style="color: crimson; font-weight: bold; margin-right: 8px;">
                <fmt:formatNumber value="${(product.discount * 100) / product.price}" type="number" maxFractionDigits="0" />%
              </span>
              <span style="color: #777; text-decoration: line-through; margin-right: 8px;">
                <fmt:formatNumber value="${product.price}" type="number" />원
              </span>
              <span style="color: red; font-weight: bold;">
                <fmt:formatNumber value="${product.price - product.discount}" type="number" />원
              </span>
            </div>
          </c:when>
          <c:otherwise>
            <div>
              <span style="color: #000;">
                <fmt:formatNumber value="${product.price}" type="number" />원
              </span>
            </div>
          </c:otherwise>
        </c:choose>
      </div>
    </a>
  </div>
</c:forEach>

  </div>
</c:if>


	<!-- ✅ 상품 없음 -->
	<c:if test="${empty productList}">
		<div class="empty-message">상품이 없습니다.</div>
	</c:if>

	<jsp:include page="/footer" />
</body>
</html>
