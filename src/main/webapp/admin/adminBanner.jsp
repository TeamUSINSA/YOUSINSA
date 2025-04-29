<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>배너 관리</title>
<jsp:include page="../common/header.jsp" />
<jsp:include page="adminSideBarStyle.jsp" />
<style>
body {
	margin: 0;
	font-family: 'Pretendard', sans-serif;
	background-color: #f8f8f8;
	min-height: 100vh;
}

.main-container {
	display: flex;
	gap: 20px;
	margin: 20px;
}


.content {
	flex-grow: 1;
	background-color: white;
	padding: 40px 50px;
	border-radius: 10px;
	box-shadow: 0 4px 10px rgba(0, 0, 0, 0.05);
	min-height: 600px;
}

h1 {
	font-size: 24px;
	font-weight: bold;
	margin-bottom: 30px;
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

.btn-delete {
	background-color: #ef4444;
	color: #fff;
	padding: 6px 14px;
	border: none;
	border-radius: 6px;
	cursor: pointer;
}

.btn-delete:hover {
	background-color: #dc2626;
}

.btn-register {
	background-color: #000;
	color: white;
	padding: 10px 20px;
	border-radius: 6px;
	font-weight: bold;
	cursor: pointer;
}

.btn-register:hover {
	background-color: #333;
}

footer {
	position: sticky;
	bottom: 0;
	width: 100%;
	background-color: #333;
	color: white;
	text-align: center;
	padding: 20px;
}
</style>
</head>
<body>

	<div class="main-container">
		<jsp:include page="adminSideBar.jsp" />
		<div class="content">
			<h1>배너 관리</h1>
			<table>
				<thead>
					<tr>
						<th>ID</th>
						<th>이름</th>
						<th>이미지</th>
						<th>product_id</th>
						<th>position</th>
						<th>삭제</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="banner" items="${bannerList}">
						<tr>
							<td>${banner.id}</td>
							<td>${banner.name}</td>
							<td><img
								src="${pageContext.request.contextPath}/upload/banner/${banner.img}"
								style="height: 48px; margin: 0 auto;" /></td>
							<td>${banner.productId}</td>
							<td>${banner.position}</td>
							<td>
								<form
									action="${pageContext.request.contextPath}/adminBannerDelete"
									method="post" onsubmit="return confirm('정말 삭제하시겠습니까?')">
									<input type="hidden" name="bannerId" value="${banner.id}" />
									<button class="btn-delete">삭제</button>
								</form>
							</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
			<div style="margin-top: 30px; text-align: right;">
				<form action="${pageContext.request.contextPath}/adminBannerAdd" method="get">
					<button class="btn-register">배너 등록</button>
				</form>
			</div>
		</div>
	</div>

<jsp:include page="../common/footer.jsp" />
</body>
</html>
