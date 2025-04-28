<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>회원 검색</title>
<style>
body {
  margin: 0;
  font-family: 'Pretendard', sans-serif;
  background-color: #f9f9f9;
  display: flex;
  flex-direction: column;
  min-height: 100vh;
}

.main-content {
  display: flex;
  flex: 1;
  min-height: 80vh;
}

.sidebar {
  width: 250px;
  flex-shrink: 0;
}

.container {
  flex-grow: 1;
  padding: 40px;
  background-color: #f9f9f9;
}

.content-inner {
  background: #fff;
  padding: 30px;
  border-radius: 10px;
  box-shadow: 0 0 10px rgba(0, 0, 0, 0.05);
}

h2 {
  font-size: 24px;
  font-weight: bold;
  margin-bottom: 30px;
}

.search-box {
  display: flex;
  gap: 10px;
  margin-bottom: 20px;
}

select, input[type="text"], button {
  padding: 8px;
  border: 1px solid #ccc;
  border-radius: 6px;
}

button {
  background-color: #111;
  color: white;
  cursor: pointer;
}

button:hover {
  background-color: #333;
}

.info-table, .order-table {
  width: 100%;
  border-collapse: collapse;
  margin-top: 20px;
}

.info-table td, .order-table td, .order-table th {
  border: 1px solid #ddd;
  padding: 10px;
  text-align: center;
}

.info-table .label {
  background-color: #e0f7fa;
  font-weight: bold;
}

.order-table thead th {
  background-color: #f0f0f0;
}

.order-table tbody tr:hover {
  background-color: #f1f8e9;
  cursor: pointer;
}

.footer {
  margin-top: auto;
}
</style>
<script>
function goToOrderDetail(orderId) {
	  location.href = "${pageContext.request.contextPath}/adminOrderDetail?orderId=" + orderId;
	}

</script>
<jsp:include page="../common/header.jsp" />
<jsp:include page="adminSideBarStyle.jsp" />
</head>

<body>
<div class="main-content">
  <div class="sidebar">
    <jsp:include page="adminSideBar.jsp" />
  </div>

  <div class="container">
    <div class="content-inner">
      <h2>회원 검색</h2>

      <div class="search-box">
        <form method="get" action="">
          <select name="searchType">
            <option value="id" ${param.searchType == 'id' ? 'selected' : ''}>아이디</option>
            <option value="name" ${param.searchType == 'name' ? 'selected' : ''}>이름</option>
          </select>
          <input type="text" name="keyword" value="${param.keyword}" placeholder="검색어 입력" />
          <button type="submit">검색</button>
        </form>
      </div>

      <c:choose>
        <c:when test="${param.searchType == 'id'}">
          <c:if test="${not empty member}">
            <table class="info-table">
              <tr><td class="label">이름</td><td>${member.name}</td></tr>
              <tr><td class="label">아이디</td><td>${member.userId}</td></tr>
              <tr><td class="label">전화번호</td><td>${member.phone}</td></tr>
              <tr><td class="label">가입일자</td><td>${member.joinDate}</td></tr>
              <tr><td class="label">생일</td><td>${member.birth}</td></tr>
              <tr><td class="label">이메일</td><td>${member.email}</td></tr>
              <tr>
                <td class="label">주소</td>
                <td>
                  ${member.address1} ${member.address1Detail}<br/>
                  ${member.address2} ${member.address2Detail}<br/>
                  ${member.address3} ${member.address3Detail}
                </td>
              </tr>
              <c:if test="${not empty member.withdrawalReason}">
                <tr>
                  <td class="label">탈퇴사유</td>
                  <td>${member.withdrawalReason} (${member.withdrawalDetail})</td>
                </tr>
              </c:if>
            </table>

            <table class="order-table">
              <thead>
                <tr><th>주문번호</th><th>주문일자</th><th>상태</th></tr>
              </thead>
              <tbody>
                <c:forEach var="order" items="${orderList}">
                  <tr onclick="goToOrderDetail(${order.orderId})">
                    <td>${order.orderId}</td>
                    <td><fmt:formatDate value="${order.orderDate}" pattern="yyyy-MM-dd" /></td>
                    <td>${order.deliveryStatus}</td>
                  </tr>
                </c:forEach>
                <c:if test="${empty orderList}">
                  <tr><td colspan="3" style="color: gray;">주문 내역이 없습니다.</td></tr>
                </c:if>
              </tbody>
            </table>
          </c:if>
        </c:when>

        <c:otherwise>
          <c:forEach var="entry" items="${userOrderMap}">
            <c:set var="user" value="${entry.key}" />
            <c:set var="orders" value="${entry.value}" />
            <h3>${user.name} (${user.userId})</h3>
            <table class="info-table">
              <tr><td class="label">이메일</td><td>${user.email}</td></tr>
              <tr><td class="label">전화번호</td><td>${user.phone}</td></tr>
            </table>

            <table class="order-table">
              <thead>
                <tr><th>주문번호</th><th>주문일자</th><th>상태</th></tr>
              </thead>
              <tbody>
                <c:forEach var="order" items="${orders}">
                  <tr onclick="goToOrderDetail(${order.orderId})">
                    <td>${order.orderId}</td>
                    <td><fmt:formatDate value="${order.orderDate}" pattern="yyyy-MM-dd" /></td>
                    <td>${order.deliveryStatus}</td>
                  </tr>
                </c:forEach>
                <c:if test="${empty orders}">
                  <tr><td colspan="3" style="color: gray;">주문 내역이 없습니다.</td></tr>
                </c:if>
              </tbody>
            </table>
            <br><hr><br>
          </c:forEach>
        </c:otherwise>
      </c:choose>
    </div>
  </div>
</div>

<div class="footer">
  <jsp:include page="../common/footer.jsp" />
</div>
</body>
</html>