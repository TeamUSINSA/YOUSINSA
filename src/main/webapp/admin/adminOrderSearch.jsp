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
  <script src="https://cdn.tailwindcss.com"></script>
  <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
  <style>
    body {
      margin: 0;
      font-family: 'Pretendard', sans-serif;
      background-color: #f8f8f8;
    }
    h2 {
      font-size: 24px;
      font-weight: bold;
      margin-bottom: 30px;
    }
    .content-wrapper {
      display: flex;
      gap: 20px;
      margin: 20px;
    }
    .sidebar {
      width: 300px;
      flex-shrink: 0;
    }
    .main-content {
      background-color: white;
      padding: 30px;
      border-radius: 12px;
      box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
      width: 100%;
      max-width: 1200px;
      flex-grow: 1;
    }
    .search-box {
      background-color: #f9f9f9;
      border: 1px solid #ccc;
      padding: 20px;
      border-radius: 10px;
      margin-bottom: 30px;
    }
    .search-box select,
    .search-box input[type="text"],
    .search-box button {
      margin-right: 10px;
      padding: 8px 12px;
      border: 1px solid #ccc;
      border-radius: 6px;
      font-size: 14px;
    }
    .radio-group {
    margin-top: 15px;
    display: flex;
    align-items: center;
    flex-wrap: wrap;
    gap: 8px; /* 간격 좁힘 */
  }

  .radio-group strong {
    width: 80px; /* strong 너비 줄임 */
    flex-shrink: 0;
  }

  .radio-group label {
    display: inline-flex;
    align-items: center;
    gap: 4px; /* ○ 버튼과 텍스트 간 간격 최소화 */
    font-size: 14px;
    margin: 0;
    white-space: nowrap; /* 줄바꿈 방지 */
  }

  .radio-group input[type="radio"] {
    accent-color: black; /* 라디오 버튼 색 */
    cursor: pointer;
  }
    table {
      width: 100%;
      border-collapse: collapse;
      margin-top: 10px;
      font-size: 14px;
    }
    th, td {
      padding: 12px;
      text-align: center;
      border-bottom: 1px solid #ddd;
    }
    th {
      background-color: #f0f0f0;
      font-weight: 600;
    }
    tr:hover {
      background-color: #f5f5f5;
      cursor: pointer;
    }
    .pagination {
      text-align: center;
      margin-top: 30px;
    }
    .pagination a {
      display: inline-block;
      margin: 0 5px;
      padding: 6px 12px;
      text-decoration: none;
      border-radius: 6px;
      background-color: #eee;
      color: #333;
    }
    .pagination a.active {
      background-color: black;
      color: white;
    }
  </style>
</head>
<body class="bg-gray-100 min-h-screen font-pretendard">
  <div class="content-wrapper">
    <jsp:include page="adminSideBar.jsp" />
    <div class="main-content">
      <h2 class="text-2xl font-bold mb-6">주문 내역 조회</h2>

      <!-- ✅ 검색 폼 -->
      <div class="search-box">
        <form method="get" action="${pageContext.request.contextPath}/adminOrderSearch">
          <select name="searchType" class="border rounded p-2">
            <option value="userId" selected>회원 ID</option>
          </select>
          <input type="text" name="userId" placeholder="검색어 입력" value="${param.userId}" class="border rounded p-2" />
          <button type="submit" class="px-4 py-2 bg-black text-white rounded">검색</button>

          <div class="radio-group mt-4">
            <strong>기간 선택:</strong>
            <label><input type="radio" name="period" value="all" ${param.period == 'all' || param.period == null ? 'checked' : ''}> 전체</label>
            <label><input type="radio" name="period" value="3" ${param.period == '3' ? 'checked' : ''}> 3일</label>
            <label><input type="radio" name="period" value="7" ${param.period == '7' ? 'checked' : ''}> 7일</label>
            <label><input type="radio" name="period" value="30" ${param.period == '30' ? 'checked' : ''}> 30일</label>
          </div>

          <div class="radio-group mt-4">
            <strong>상태 선택:</strong>
            <label><input type="radio" name="status" value="all" ${param.status == 'all' || param.status == null ? 'checked' : ''}> 전체</label>
            <label><input type="radio" name="status" value="배송준비" ${param.status == '배송준비' ? 'checked' : ''}> 배송준비</label>
            <label><input type="radio" name="status" value="배송중" ${param.status == '배송중' ? 'checked' : ''}> 배송중</label>
            <label><input type="radio" name="status" value="배송완료" ${param.status == '배송완료' ? 'checked' : ''}> 배송완료</label>
          </div>
        </form>
      </div>

      <!-- ✅ 결과 테이블 -->
      <table class="w-full border-t text-sm">
        <thead class="bg-gray-100">
          <tr>
            <th class="p-3">주문일자</th>
            <th class="p-3">회원 ID</th>
            <th class="p-3">주문번호</th>
            <th class="p-3">상태</th>
          </tr>
        </thead>
        <tbody>
          <c:choose>
            <c:when test="${not empty orderList}">
              <c:forEach var="order" items="${orderList}">
                <tr onclick="location.href='${pageContext.request.contextPath}/adminOrderDetail?orderId=${order.orderId}'" class="hover:bg-gray-50 cursor-pointer">
                  <td class="p-3">${order.orderDate}</td>
                  <td class="p-3">${order.userId}</td>
                  <td class="p-3">${order.orderId}</td>
                  <td class="p-3">${order.deliveryStatus}</td>
                </tr>
              </c:forEach>
            </c:when>
            <c:otherwise>
              <tr>
                <td colspan="4" class="p-5 text-gray-500">조회된 주문이 없습니다.</td>
              </tr>
            </c:otherwise>
          </c:choose>
        </tbody>
      </table>

      <!-- ✅ 페이지네이션 -->
      <div class="pagination mt-6">
        <c:forEach var="i" begin="1" end="${totalPages}">
          <a href="${pageContext.request.contextPath}/adminOrderSearch?page=${i}&userId=${param.userId}&period=${param.period}&status=${param.status}"
             class="${i == param.page ? 'active' : ''}">${i}</a>
        </c:forEach>
      </div>

    </div>
  </div>

  <jsp:include page="../common/footer.jsp" />
</body>
</html>
