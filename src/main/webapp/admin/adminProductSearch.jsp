<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page import="java.util.*" %>

<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<html>
<head>
    <title>상품 검색</title>
    <style>
        body {
            font-family: sans-serif;
            min-width: 1000px;
            background-color: #f9f9f9;
            margin: 0;
            padding: 0;
        }

        h2 {
            width: 700px;
            margin: 50px auto 10px auto;
            text-align: left;
        }

        .container {
            width: 700px;
            margin: 0 auto 50px auto;
            border: 1px solid #ccc;
            border-radius: 10px;
            padding: 30px;
            background-color: white;
        }

        .search-options {
            margin-bottom: 20px;
        }

        input[type="radio"] {
            margin-right: 5px;
        }

        input[type="text"] {
            width: 250px;
            height: 30px;
            padding: 5px;
        }

        .search-btn {
            height: 30px;
            padding: 0 15px;
            background: black;
            color: white;
            border: none;
            border-radius: 5px;
            margin-left: 10px;
            cursor: pointer;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }

        th, td {
            border-bottom: 1px solid #ddd;
            padding: 10px;
            text-align: center;
        }

        th {
            background: #eee;
        }

        .product-img {
            width: 50px;
            height: 50px;
            object-fit: cover;
        }
    </style>
    <jsp:include page="adminSideBarStyle.jsp" />
</head>
<body>
<jsp:include page="adminSideBar.jsp" />
    <h2>상품검색</h2>
    <div class="container">
        <form method="post" action="${contextPath}/adminproductsearch">
            <div class="search-options">
                <c:choose>
                	<c:when test="${searchType eq 'name' }">
		                <label><input type="radio" name="searchType" value="name" checked> 상품명</label>
        		        <label><input type="radio" name="searchType" value="product_id"> 제품코드</label>
                	</c:when>
                	<c:otherwise>
		                <label><input type="radio" name="searchType" value="name" > 상품명</label>
        		        <label><input type="radio" name="searchType" value="product_id" checked> 제품코드</label>                	
                	</c:otherwise>
                </c:choose>
            </div>
            <input type="text" name="keyword" required value="${keyword }"/>
            <button type="submit" class="search-btn">검색</button>
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
</body>
</html>
