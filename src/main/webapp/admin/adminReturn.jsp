<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>반품 신청 목록</title>
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
    .search-form label {
      font-size: 14px;
      display: flex;
      align-items: center;
      gap: 6px;
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
    .status-complete { color: green; font-weight: bold; }
    .status-pending { color: orange; font-weight: bold; }
    .status-rejected { color: red; font-weight: bold; }
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
    <h2>반품 신청 목록</h2>

    <form method="get" action="${pageContext.request.contextPath}/adminReturn" class="search-form">
      <label><input type="radio" name="status" value="all" ${param.status == 'all' || param.status == null ? 'checked' : ''}> 전체</label>
      <label><input type="radio" name="status" value="completed" ${param.status == 'completed' ? 'checked' : ''}> 승인 완료</label>
      <label><input type="radio" name="status" value="pending" ${param.status == 'pending' ? 'checked' : ''}> 대기</label>
      <label><input type="radio" name="status" value="rejected" ${param.status == 'rejected' ? 'checked' : ''}> 반려</label>
      <button type="submit" class="btn-search">검색</button>
    </form>

    <table>
      <thead>
        <tr>
          <th>접수일</th>
          <th>회원 ID</th>
          <th>반품 사유</th>
          <th>처리 상태</th>
        </tr>
      </thead>
      <tbody>
        <c:choose>
          <c:when test="${not empty refundList}">
            <c:forEach var="refund" items="${refundList}">
              <tr onclick="location.href='${pageContext.request.contextPath}/adminReturnDetail?returnId=${refund.returnId}'">
                <td><fmt:formatDate value="${refund.returnDate}" pattern="yyyy-MM-dd" /></td>
                <td>${refund.userId}</td>
                <td>${refund.reason}</td>
                <td>
                  <c:choose>
                    <c:when test="${refund.approved == 1}"><span class="status-complete">승인 완료</span></c:when>
                    <c:when test="${refund.approved == 0}"><span class="status-pending">신청 접수</span></c:when>
                    <c:when test="${refund.approved == 2}"><span class="status-rejected">반려</span></c:when>
                  </c:choose>
                </td>
              </tr>
            </c:forEach>
          </c:when>
          <c:otherwise>
            <tr><td colspan="4">검색 결과가 없습니다.</td></tr>
          </c:otherwise>
        </c:choose>
      </tbody>
    </table>

    <div class="pagination">
      <c:forEach var="i" begin="1" end="${totalPages}">
        <a href="${pageContext.request.contextPath}/adminReturn?page=${i}&status=${param.status}" class="${i == param.page ? 'active' : ''}">${i}</a>
      </c:forEach>
    </div>

  </div>
</div>

<jsp:include page="../common/footer.jsp" />
</body>
</html>
