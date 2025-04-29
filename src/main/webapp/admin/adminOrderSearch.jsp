<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8" />
  <title>주문 내역 조회</title>
  <jsp:include page="../common/header.jsp" />
  <jsp:include page="adminSideBarStyle.jsp" />

  <style>
    body {
      margin: 0;
      background-color: #f8f8f8;
      font-family: 'Pretendard', sans-serif;
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
      display: flex;
      align-items: center;
      gap: 20px;
      margin-bottom: 30px;
    }
    .search-form select,
    .search-form input[type="text"],
    .search-form button {
      padding: 8px 12px;
      font-size: 14px;
      border-radius: 6px;
      border: 1px solid #ccc;
    }
    .btn-search {
      background-color: #000;
      color: white;
      padding: 8px 20px;
      border-radius: 6px;
      cursor: pointer;
      border: none;
      font-size: 14px;
    }
    .btn-search:hover {
      background-color: #333;
    }
    table {
      width: 100%;
      border-collapse: collapse;
      font-size: 14px;
    }
    th, td {
      padding: 12px;
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
    .pagination {
      margin-top: 30px;
      text-align: center;
    }
    .pagination a {
      display: inline-block;
      margin: 0 5px;
      padding: 6px 12px;
      text-decoration: none;
      background-color: #eee;
      color: #333;
      border-radius: 6px;
    }
    .pagination a.active {
      background-color: black;
      color: white;
    }
  </style>
</head>

<body>
<div class="content-wrapper">
  <jsp:include page="adminSideBar.jsp" />

  <div class="main-content">
    <h2>주문 내역 조회</h2>

    <!-- ✅ 검색 폼 -->
    <form method="get" action="${pageContext.request.contextPath}/adminOrderSearch" class="search-form">
      <select name="searchType">
        <option value="userId" selected>회원 ID</option>
      </select>
      <input type="text" name="userId" placeholder="검색어 입력" value="${param.userId}" />
      
      <button type="submit" class="btn-search">검색</button>

      <label><input type="radio" name="period" value="all" ${param.period == 'all' || param.period == null ? 'checked' : ''}> 전체</label>
      <label><input type="radio" name="period" value="3" ${param.period == '3' ? 'checked' : ''}> 3일</label>
      <label><input type="radio" name="period" value="7" ${param.period == '7' ? 'checked' : ''}> 7일</label>
      <label><input type="radio" name="period" value="30" ${param.period == '30' ? 'checked' : ''}> 30일</label>

      <label><input type="radio" name="status" value="all" ${param.status == 'all' || param.status == null ? 'checked' : ''}> 전체</label>
      <label><input type="radio" name="status" value="배송준비" ${param.status == '배송준비' ? 'checked' : ''}> 배송준비</label>
      <label><input type="radio" name="status" value="배송중" ${param.status == '배송중' ? 'checked' : ''}> 배송중</label>
      <label><input type="radio" name="status" value="배송완료" ${param.status == '배송완료' ? 'checked' : ''}> 배송완료</label>
    </form>

    <!-- ✅ 결과 테이블 -->
    <table>
      <thead>
        <tr>
          <th>주문일자</th>
          <th>회원 ID</th>
          <th>주문번호</th>
          <th>상태</th>
        </tr>
      </thead>
      <tbody>
        <c:choose>
          <c:when test="${not empty orderList}">
            <c:forEach var="order" items="${orderList}">
              <tr onclick="location.href='${pageContext.request.contextPath}/adminOrderDetail?orderId=${order.orderId}'">
                <td>${order.orderDate}</td>
                <td>${order.userId}</td>
                <td>${order.orderId}</td>
                <td>${order.deliveryStatus}</td>
              </tr>
            </c:forEach>
          </c:when>
          <c:otherwise>
            <tr><td colspan="4">조회된 주문이 없습니다.</td></tr>
          </c:otherwise>
        </c:choose>
      </tbody>
    </table>

    <!-- ✅ 페이지네이션 -->
    <div class="pagination">
      <c:forEach var="i" begin="1" end="${totalPages}">
        <a href="${pageContext.request.contextPath}/adminOrderSearch?page=${i}&userId=${param.userId}&period=${param.period}&status=${param.status}" class="${i == param.page ? 'active' : ''}">${i}</a>
      </c:forEach>
    </div>

  </div>
</div>

<jsp:include page="../common/footer.jsp" />
</body>
</html>
