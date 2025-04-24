<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>쿠폰 보기</title>
  <jsp:include page="adminSideBarStyle.jsp" />
  <style>
    body {
      font-family: 'Pretendard', sans-serif;
      margin: 0;
      background-color: #f8f8f8;
      display: flex;
    }

    .main-wrapper {
      flex-grow: 1;
      padding: 40px 60px;
    }

    h2 {
      font-size: 24px;
      font-weight: bold;
      margin-bottom: 30px;
    }

    .container {
      background-color: white;
      border-radius: 12px;
      padding: 30px;
      box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
    }

    table {
      width: 100%;
      border-collapse: collapse;
    }

    th, td {
      padding: 12px 10px;
      text-align: center;
      border-bottom: 1px solid #eee;
    }

    thead {
      background-color: #e0e0e0;
    }

    .delete-icon {
      font-size: 18px;
      background: none;
      border: none;
      cursor: pointer;
    }

    .delete-icon:hover {
      color: red;
    }

    .back-btn {
      margin-top: 30px;
      text-align: right;
    }

    .back-btn button {
      padding: 10px 20px;
      background-color: #333;
      color: white;
      border: none;
      border-radius: 6px;
      cursor: pointer;
    }

    .back-btn button:hover {
      background-color: #555;
    }

    .pagination {
      margin-top: 30px;
      text-align: center;
    }

    .pagination a {
      margin: 0 5px;
      font-weight: normal;
      text-decoration: none;
      color: #333;
    }

    .pagination a.current {
      font-weight: bold;
      color: #000;
    }

    tbody tr:hover {
      background-color: #f4f4f4;
    }
  </style>
</head>
<body>
  <jsp:include page="adminSideBar.jsp" />
  <div class="main-wrapper">
    <h2>쿠폰 보기</h2>
    <div class="container">
      <table>
        <thead>
          <tr>
            <th>쿠폰명</th>
            <th>할인금액</th>
            <th>쿠폰 발송</th>
            <th>삭제</th>
          </tr>
        </thead>
        <tbody>
          <c:forEach var="coupon" items="${couponList}">
            <tr>
              <td>${coupon.name}</td>
              <td>
                <c:choose>
                  <c:when test="${coupon.discountAmount >= 100}">
                    ${coupon.discountAmount}원
                  </c:when>
                  <c:otherwise>
                    ${coupon.discountAmount}%
                  </c:otherwise>
                </c:choose>
              </td>
              <td>
                <c:choose>
                  <c:when test="${coupon.type == 'download'}">업로드</c:when>
                  <c:otherwise>자동</c:otherwise>
                </c:choose>
              </td>
              <td>
                <form method="post" action="${pageContext.request.contextPath}/admincoupondelete"
                      onsubmit="return confirm('정말 삭제하시겠습니까?');" style="display: inline;">
                  <input type="hidden" name="couponId" value="${coupon.couponId}" />
                  <button type="submit" class="delete-icon">🗑️</button>
                </form>
              </td>
            </tr>
          </c:forEach>
        </tbody>
      </table>
    </div>

    <div class="back-btn">
      <a href="${pageContext.request.contextPath}/admin/adminCategory.jsp">
        <button>관리자 메인으로 돌아가기</button>
      </a>
    </div>

    <div class="pagination">
      <c:forEach var="i" begin="1" end="${totalPages}">
        <a href="${pageContext.request.contextPath}/admincouponlist?page=${i}"
           class="${i == currentPage ? 'current' : ''}">[${i}]</a>
      </c:forEach>
    </div>
  </div>
</body>
</html>
