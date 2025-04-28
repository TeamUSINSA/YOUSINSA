<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>반품 신청 목록</title>
  <jsp:include page="../common/header.jsp" />
  <jsp:include page="adminSideBarStyle.jsp" />
  <style>
    * { margin: 0; padding: 0; box-sizing: border-box; }
    body, html { height: 100%; font-family: 'Pretendard', sans-serif; }

    .main-layout {
      display: flex;
      min-height: calc(100vh - 100px); /* header/footer 제외 */
    }

    .sidebar {
      width: 250px;
      background-color: #fff;
      border-right: 1px solid #ddd;
    }

    .main-content {
      flex-grow: 1;
      background-color: #f8f8f8;
      padding: 40px 60px;
      display: flex;
      flex-direction: column;
    }

    h2 {
      font-size: 24px;
      font-weight: bold;
      margin-bottom: 30px;
    }

    .container {
      background: white;
      padding: 30px;
      border-radius: 12px;
      box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
      flex: 1;
      display: flex;
      flex-direction: column;
    }

    .search-container form {
      display: flex;
      gap: 20px;
      margin-bottom: 20px;
      flex-wrap: wrap;
      align-items: center;
    }

    .search-container label {
      font-size: 14px;
    }

    .btn-search {
      background-color: #000;
      color: #fff;
      padding: 8px 20px;
      border: none;
      border-radius: 6px;
      cursor: pointer;
    }

    .btn-search:hover {
      background-color: #333;
    }

    table {
      width: 100%;
      border-collapse: collapse;
      margin-top: 20px;
    }

    th, td {
      padding: 12px;
      text-align: center;
      border-bottom: 1px solid #eee;
    }

    thead {
      background-color: #f0f0f0;
    }

    .status-complete { color: green; font-weight: bold; }
    .status-pending { color: orange; font-weight: bold; }
    .status-rejected { color: red; font-weight: bold; }

    .clickable {
      cursor: pointer;
      transition: background-color 0.2s;
    }

    .clickable:hover {
      background-color: #f9f9f9;
    }

    .pagination {
      margin-top: 30px;
      text-align: center;
    }

    .pagination a {
      margin: 0 5px;
      text-decoration: none;
      color: #333;
      font-weight: bold;
    }

    .pagination a:hover {
      text-decoration: underline;
    }
  </style>
</head>

<body>
<div class="main-layout">
  <div class="sidebar">
    <jsp:include page="adminSideBar.jsp" />
  </div>

  <div class="main-content">
    <h2>반품 신청 목록</h2>
    <div class="container">
      <div class="search-container">
        <form method="get" action="${pageContext.request.contextPath}/adminReturn">
          <label><input type="radio" name="status" value="all" ${param.status == 'all' || param.status == null ? 'checked' : ''}> 전체</label>
          <label><input type="radio" name="status" value="completed" ${param.status == 'completed' ? 'checked' : ''}> 승인 완료</label>
          <label><input type="radio" name="status" value="pending" ${param.status == 'pending' ? 'checked' : ''}> 대기</label>
          <label><input type="radio" name="status" value="rejected" ${param.status == 'rejected' ? 'checked' : ''}> 반려</label>
          <button type="submit" class="btn-search">검색</button>
        </form>
      </div>

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
                <tr class="clickable" onclick="location.href='${pageContext.request.contextPath}/adminReturnDetail?returnId=${refund.returnId}'">
                  <td><fmt:formatDate value="${refund.returnDate}" pattern="yyyy-MM-dd"/></td>
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
          <a href="${pageContext.request.contextPath}/adminReturn?page=${i}&status=${param.status}">${i}</a>
        </c:forEach>
      </div>
    </div>
  </div>
</div>

<jsp:include page="../common/footer.jsp" />
</body>
</html>
