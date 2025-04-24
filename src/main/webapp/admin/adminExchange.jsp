<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>교환 접수</title>
<jsp:include page="adminSideBarStyle.jsp" />
<style>
body {
	margin: 0;
	font-family: 'Pretendard', sans-serif;
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
	padding: 30px;
	border-radius: 12px;
	box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
}

.search-container form {
	display: flex;
	align-items: center;
	gap: 20px;
	margin-bottom: 20px;
}

.btn-search {
	background-color: #000;
	color: #fff;
	padding: 8px 20px;
	border: none;
	border-radius: 6px;
	cursor: pointer;
}

table {
	width: 100%;
	border-collapse: collapse;
	margin-top: 20px;
}

th, td {
	padding: 12px;
	text-align: center;
	border-bottom: 1px solid #ddd;
}

thead {
	background-color: #f0f0f0;
}

.status-complete {
	color: green;
	font-weight: bold;
}

.status-pending {
	color: orange;
	font-weight: bold;
}

.status-rejected {
	color: red;
	font-weight: bold;
}

.pagination {
	text-align: center;
	margin-top: 30px;
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
	<jsp:include page="adminSideBar.jsp" />
	<div class="main-wrapper">
		<h2>교환 접수</h2>
		<div class="container">

			<!-- 검색 필터 -->
			<div class="search-container">
				<form method="get"
					action="${pageContext.request.contextPath}/adminExchange">
					<label> <input type="radio" name="status" value="all"
						${param.status == 'all' || param.status == null ? 'checked' : ''}>
						전체
					</label> <label> <input type="radio" name="status"
						value="completed" ${param.status == 'completed' ? 'checked' : ''}>
						교환 완료
					</label> <label> <input type="radio" name="status" value="pending"
						${param.status == 'pending' ? 'checked' : ''}> 교환 대기
					</label> <label> <input type="radio" name="status" value="rejected"
						${param.status == 'rejected' ? 'checked' : ''}> 교환 반려
					</label>
					<button type="submit" class="btn-search">검색</button>
				</form>
			</div>

			<!-- 테이블 -->
			<table>
				<thead>
					<tr>
						<th>접수일시</th>
						<th>주문번호</th>
						<th>교환사유</th>
						<th>현재상태</th>
					</tr>
				</thead>
				<tbody>
					<c:choose>
						<c:when test="${not empty exchangeList}">
							<c:forEach var="exchange" items="${exchangeList}">
								<tr
									onclick="location.href='${pageContext.request.contextPath}/adminexchangedetail?exchangeId=${exchange.exchangeId}'"
									style="cursor: pointer;">
									<td>${exchange.exchangeDate}</td>
									<td>${exchange.orderItemId}</td>
									<td>${exchange.reason}</td>
									<td><c:choose>
											<c:when test="${exchange.approved == 1}">
												<span class="status-complete">교환 수락</span>
											</c:when>
											<c:when test="${exchange.approved == 0}">
												<span class="status-pending">신청 접수</span>
											</c:when>
											<c:when test="${exchange.approved == 2}">
												<span class="status-rejected">교환 반려</span>
											</c:when>
											<c:otherwise>
												<span class="status-pending">처리되지 않음</span>
											</c:otherwise>
										</c:choose></td>
								</tr>
							</c:forEach>
						</c:when>
						<c:otherwise>
							<tr>
								<td colspan="4">검색 결과가 없습니다.</td>
							</tr>
						</c:otherwise>
					</c:choose>
				</tbody>
			</table>

			<!-- 페이지네이션 -->
			<div class="pagination">
				<c:forEach var="i" begin="1" end="${totalPages}">
					<a
						href="${pageContext.request.contextPath}/adminExchange?page=${i}&status=${param.status}">${i}</a>
				</c:forEach>
			</div>
		</div>
	</div>
</body>
</html>
