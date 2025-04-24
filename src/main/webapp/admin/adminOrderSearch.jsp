<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>주문내역조회</title>
  <style>
    body {
      font-family: sans-serif;
      display: flex;
      justify-content: center;
      align-items: flex-start;
      min-height: 100vh;
      background-color: #f9f9f9;
      padding: 40px 20px;
    }

    .container {
      width: 100%;
      max-width: 900px;
      background-color: #fff;
      padding: 20px;
      border-radius: 10px;
      box-shadow: 0 0 10px rgba(0,0,0,0.1);
    }

    h2 {
      text-align: left;
      margin-bottom: 20px;
    }

    .search-box {
      border: 1px solid #ccc;
      padding: 15px;
      border-radius: 10px;
      margin-bottom: 20px;
    }

    .search-box input[type="text"],
    .search-box button {
      margin-right: 8px;
      padding: 5px 10px;
    }

    .radio-group {
      margin: 10px 0;
    }

    .radio-group label {
      margin-right: 10px;
    }

    table {
      width: 100%;
      border-collapse: collapse;
      margin-top: 10px;
    }

    table thead {
      background-color: #f0f0f0;
    }

    table th, table td {
      padding: 8px;
      border: 1px solid #ddd;
      text-align: center;
    }

    tr:hover {
      background-color: #f5f5f5;
    }

    .pagination {
      text-align: center;
      margin-top: 20px;
    }

    .pagination a {
      display: inline-block;
      margin: 0 4px;
      padding: 5px 10px;
      text-decoration: none;
      border-radius: 5px;
      background-color: #eee;
      color: #333;
    }

    .pagination .active {
      background-color: black;
      color: white;
    }
  </style>
  <jsp:include page="adminSideBarStyle.jsp" />
</head>
<body>
<jsp:include page="adminSideBar.jsp" />

  <div class="container">
    <h2>주문내역조회</h2>

    <!-- ✅ 검색 폼 -->
    <div class="search-box">
      <form method="get" action="${pageContext.request.contextPath}/adminordersearch">
        <select name="searchType">
          <option value="userId" selected>회원 ID</option>
        </select>
        <input type="text" name="userId" placeholder="검색어 입력" value="${param.userId}">
        <button type="submit">검색</button>

        <div class="radio-group">
          <strong>기간 선택:</strong>
          <label><input type="radio" name="period" value="all" ${param.period == 'all' || param.period == null ? 'checked' : ''}> 전체</label>
          <label><input type="radio" name="period" value="3" ${param.period == '3' ? 'checked' : ''}> 3일</label>
          <label><input type="radio" name="period" value="7" ${param.period == '7' ? 'checked' : ''}> 7일</label>
          <label><input type="radio" name="period" value="30" ${param.period == '30' ? 'checked' : ''}> 30일</label>
        </div>

        <div class="radio-group">
          <strong>상태 선택:</strong>
          <label><input type="radio" name="status" value="all" ${param.status == 'all' || param.status == null ? 'checked' : ''}> 전체</label>
          <label><input type="radio" name="status" value="배송준비" ${param.status == '배송준비' ? 'checked' : ''}> 배송준비</label>
          <label><input type="radio" name="status" value="배송중" ${param.status == '배송중' ? 'checked' : ''}> 배송중</label>
          <label><input type="radio" name="status" value="배송완료" ${param.status == '배송완료' ? 'checked' : ''}> 배송완료</label>
        </div>
      </form>
    </div>

    <!-- ✅ 결과 테이블 -->
    <table>
      <thead>
        <tr>
          <th>주문일자</th>
          <th>회원ID</th>
          <th>주문번호</th>
          <th>상태</th>
        </tr>
      </thead>
      <tbody>
        <c:choose>
          <c:when test="${not empty orderList}">
            <c:forEach var="order" items="${orderList}">
              <tr onclick="location.href='${pageContext.request.contextPath}/adminorderdetail?orderId=${order.orderId}'" style="cursor:pointer;">
                <td>${order.orderDate}</td>
                <td>${order.userId}</td>
                <td>${order.orderId}</td>
                <td>${order.deliveryStatus}</td>
              </tr>
            </c:forEach>
          </c:when>
          <c:otherwise>
            <tr>
              <td colspan="4">조회된 주문이 없습니다.</td>
            </tr>
          </c:otherwise>
        </c:choose>
      </tbody>
    </table>

    <!-- ✅ 페이지네이션 -->
    <div class="pagination">
      <c:forEach var="i" begin="1" end="${totalPages}">
        <a href="${pageContext.request.contextPath}/adminordersearch?page=${i}&userId=${param.userId}&period=${param.period}&status=${param.status}"
           class="${i == param.page ? 'active' : ''}">${i}</a>
      </c:forEach>
    </div>

  </div>
</body>
</html>
