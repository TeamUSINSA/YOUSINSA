<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>상품 수정</title>
<jsp:include page="../common/header.jsp" />
<jsp:include page="adminSideBarStyle.jsp" />
<style>
body {
	font-family: 'Pretendard', sans-serif;
	background-color: #f8f8f8;
	margin: 0;
}

h2 {
	font-size: 24px;
	font-weight: bold;
	margin: 40px 0 20px 0;
	text-align: center;
}

.layout {
	width: 1500px;
	display: flex;
}

.container {
	background-color: white;
	padding: 40px;
	border-radius: 12px;
	box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
	margin: auto;
	width: 1200px;
	display: flex;
	gap: 40px;
	align-items: flex-start;
}

.left, .right {
	flex: 1;
}

.main-image, .sub-thumb, .big-img-slot {
	border: 1px solid #999;
	background-color: #fafafa;
	display: flex;
	align-items: center;
	justify-content: center;
	position: relative;
	overflow: hidden;
}

.main-image {
	width: 100%;
	aspect-ratio: 1/1;
}

.main-image img, .sub-thumb img, .big-img-slot img {
	width: 100%;
	height: 100%;
	object-fit: cover;
}

.sub-thumbnails, .big-preview-box {
	display: flex;
	gap: 10px;
	margin-top: 10px;
	flex-wrap: wrap;
}

.sub-thumb, .big-img-slot {
	width: 80px;
	height: 80px;
}

.form-box {
	border: 1px solid #ccc;
	padding: 20px;
	border-radius: 10px;
	margin-bottom: 20px;
}

.form-box input, .form-box select {
	width: 100%;
	padding: 10px;
	margin-top: 10px;
	box-sizing: border-box;
}

.category-row {
	display: flex;
	gap: 10px;
	align-items: center;
}

.radio-group {
	margin: 20px 0;
	display: flex;
	gap: 20px;
	align-items: center;
}

.add-btn {
	display: inline-block;
	background-color: #007BFF;
	color: white;
	padding: 8px 16px;
	border-radius: 6px;
	cursor: pointer;
	font-size: 14px;
}

.image-upload-section {
	margin-top: 40px;
	background-color: #fff;
	padding: 30px;
	border-radius: 10px;
	width: 1200px;
	margin-left: auto;
	margin-right: auto;
}

#bigImageTitle {
	width: 100%;
	height: 80px;
	padding: 10px;
	font-size: 15px;
	resize: vertical;
	border-radius: 6px;
	border: 1px solid #ccc;
	margin-top: 20px;
}
</style>
</head>
<body>
	<div class="layout">
		<jsp:include page="adminSideBar.jsp" />
		<div class="content">
			<h2>상품 수정</h2>
			<form action="${pageContext.request.contextPath}/adminProductModify"
				method="post" enctype="multipart/form-data">
				<input type="hidden" name="productId" value="${product.productId}" />
				<div class="container">
					<div class="left">
						<div class="main-image">
							<c:choose>
								<c:when test="${not empty product.imageList}">
									<img src="${product.imageList[0]}" alt="대표 이미지">
								</c:when>
								<c:otherwise>
									<span>이미지 영역</span>
								</c:otherwise>
							</c:choose>
						</div>
						<div class="sub-thumbnails">
							<c:forEach var="img" items="${product.imageList}" begin="1"
								end="3">
								<div class="sub-thumb">
									<img src="${img}" alt="서브 이미지" />
								</div>
							</c:forEach>
						</div>
						<button type="button" id="addImageBtn" class="add-btn">+
							이미지 수정</button>
						<div class="thumbnail-box" id="thumbnailBox"></div>
						<input type="file" name="images" id="imageInput" multiple
							accept="image/*" style="display: none">
					</div>
					<div class="right">
						<div class="form-box">
							<div class="category-row">
								<select name="category1">
									<option selected>${product.category1}</option>
								</select> <span> > </span> <select name="category2">
									<option selected>${product.category2}</option>
								</select>
							</div>
							<input type="text" name="name" value="${product.name}"
								placeholder="상품명 입력"> <input type="text" name="code"
								value="${product.code}" placeholder="제품코드 입력"> <input
								type="text" name="price" value="${product.price}"
								placeholder="판매가 입력"> <input type="text"
								name="discountPrice" value="${product.discountPrice}"
								placeholder="할인가 입력">
						</div>
						<div class="radio-group">
							<span>분류:</span> <label><input type="radio" name="type"
								value="new" ${product.type == 'new' ? 'checked' : ''}>
								신상품</label> <label><input type="radio" name="type"
								value="popular" ${product.type == 'popular' ? 'checked' : ''}>
								인기상품</label> <label><input type="radio" name="type"
								value="recommend"
								${product.type == 'recommend' ? 'checked' : ''}> 추천상품</label>
						</div>
					</div>
				</div>

				<div class="image-upload-section">
					<h3>상품 설명 이미지</h3>
					<div class="big-preview-box" id="bigPreviewBox">
						<c:forEach var="descImg" items="${product.descriptionImages}">
							<div class="big-img-slot">
								<img src="${descImg}" alt="설명이미지">
							</div>
						</c:forEach>
					</div>
					<input type="file" name="descriptionImages" id="bigImageInput"
						multiple accept="image/*" style="display: none">
					<button type="button" class="add-btn" id="bigImageUploadBtn">+
						이미지 등록</button>
					<textarea id="bigImageTitle" name="description"
						placeholder="제품 설명글 입력">${product.description}</textarea>
				</div>

				<div class="image-upload-section">
					<h3>사이즈 이미지</h3>
					<div class="big-preview-box" id="sizeImageBox">
						<c:if test="${not empty product.sizeImage}">
							<div class="big-img-slot">
								<img src="${product.sizeImage}" alt="사이즈 이미지">
							</div>
						</c:if>
					</div>
					<input type="file" name="sizeImage" id="sizeImageInput"
						accept="image/*" style="display: none">
					<button type="button" class="add-btn" id="sizeImageUploadBtn">+
						사이즈 설명표 추가</button>
				</div>

				<div class="image-upload-section">
					<button type="submit" class="add-btn"
						style="font-size: 16px; padding: 10px 20px;">상품 수정 완료</button>
				</div>
			</form>
		</div>
	</div>
	<jsp:include page="../common/footer.jsp" />
</body>
</html>
