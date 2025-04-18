<%@ page contentType="text/html; charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<title>좋아요 목록</title>
<style>
.layout {
	display: flex;
	max-width: 1200px;
	margin: 0 auto;
	padding: 40px 20px;
	gap: 30px;
}

.sidebar {
	width: 200px;
	background: #f7f7f7;
	padding: 10px;
	border-radius: 8px;
}

.content {
	flex: 1;
}

.btn {
	font-size: 12px;
	padding: 6px 12px;
	height: 34px;
	border-radius: 3px;
	border: 1px solid #000;
	cursor: pointer;
	line-height: 1.4;
	display: inline-flex;
	align-items: center;
	justify-content: center;
	box-sizing: border-box;
	text-decoration: none;
}

.like-btn {
	background-color: #fff;
	color: #000;
}

.like-btn:hover {
	background-color: #f5f5f5;
	border-color: #222;
}

.buy-btn {
	background-color: #000;
	color: #fff;
}

.buy-btn:hover {
	background-color: #333;
}

.product-card {
	display: flex;
	gap: 15px;
	border: 1px solid #eee;
	border-radius: 8px;
	padding: 15px;
	margin-bottom: 15px;
	background-color: #fff;
}
</style>
</head>
<body>

	<div class="layout">
		<!-- 사이드바 -->
		<div class="sidebar" style="width: 200px;">
			<%@ include file="mysidebar.jsp"%>
		</div>

		<!-- 본문 -->
		<div class="content">
			<h2 style="font-size: 20px; font-weight: bold; margin-bottom: 10px;">좋아요</h2>
			<p style="font-size: 13px; color: #555;">좋아요 누르신 상품 목록입니다.</p>

			<!-- 좋아요 목록 -->
			<div id="likeListContainer">
				<c:forEach var="item" items="${likeList}">
					<div class="product-card">
						<a
							href="${pageContext.request.contextPath}/product/detail?productId=${item.productId}">
							<img src="${item.mainImage1}" alt="${item.name}"
							style="width: 90px; height: 110px; object-fit: cover; border-radius: 5px;">
						</a>
						<div style="flex: 1;">
							<div style="font-weight: bold; margin-bottom: 5px;">
								<a
									href="${pageContext.request.contextPath}/product/detail?productId=${item.productId}"
									style="color: inherit; text-decoration: none;">
									${item.name} </a>
							</div>
							<div style="font-size: 13px; color: #666; margin-bottom: 10px;">${item.detail}</div>
							<div style="display: flex; gap: 10px;">
								<form action="unlike" method="post" style="display: inline;">
									<input type="hidden" name="likeId" value="${item.likeId}">
									<button type="submit" class="btn like-btn">좋아요 취소</button>
								</form>
								<a href="/product/detail?productId=${item.productId}"
									class="btn buy-btn">구매하러 가기</a>
							</div>
						</div>
					</div>
				</c:forEach>
			</div>

			<!-- 페이지네이션 -->
			<c:choose>
				<c:when test="${pageInfo.curPage > 1}">
					<a
						href="${pageContext.request.contextPath}/myLikeList?page=${pageInfo.curPage - 1}">&lt;</a>
				</c:when>
				<c:otherwise>
					<a>&lt;</a>
				</c:otherwise>
			</c:choose>

			<c:forEach begin="${pageInfo.startPage}" end="${pageInfo.endPage}"
				step="1" var="page">
				<c:choose>
					<c:when test="${page eq pageInfo.curPage}">
						<a class="select">${page}</a>
					</c:when>
					<c:otherwise>
						<a
							href="${pageContext.request.contextPath}/myLikeList?page=${page}"
							class="btn">${page}</a>
					</c:otherwise>
				</c:choose>
			</c:forEach>

			<c:choose>
				<c:when test="${pageInfo.curPage < pageInfo.allPage}">
					<a
						href="${pageContext.request.contextPath}/myLikeList?page=${pageInfo.curPage + 1}">&gt;</a>
				</c:when>
				<c:otherwise>
					<a>&gt;</a>
				</c:otherwise>
			</c:choose>
		</div>
	</div>



</body>
</html>
