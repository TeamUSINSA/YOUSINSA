<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<title>${product.name}-상세</title>
<style>
body {
	font-family: sans-serif;
	background: #fff;
	color: #333;
	font-size: 14px;
	margin: 0;
	padding: 0;
}

.container {
	max-width: 1200px;
	margin: auto;
	padding: 24px;
}

.grid {
	display: grid;
	grid-template-columns: 1fr 1fr;
	gap: 24px;
}

.border {
	border: 1px solid #ccc;
	border-radius: 8px;
}

.mb-4 {
	margin-bottom: 1rem;
}

.p-4 {
	padding: 1rem;
}

.text-xl {
	font-size: 20px;
	font-weight: bold;
}

.text-sm {
	font-size: 14px;
	color: #666;
}

.text-yellow {
	color: #facc15;
}

.button {
	padding: 8px 16px;
	border: 1px solid #333;
	background: #fff;
	cursor: pointer;
}

.button-black {
	background: #000;
	color: #fff;
}

.tab {
	display: flex;
	justify-content: center; /* ← 가로 중앙 정렬 */
	gap: 20px; /* 탭 링크 사이 간격 */
	margin-top: 40px;
	border-bottom: 1px solid #ccc;
	padding-bottom: 10px;
	position: sticky;
	top: 0; /* 뷰포트 최상단에 붙입니다 */
	background: #fff; /* 뒤에 가려지는 콘텐츠가 보이지 않도록 배경색을 채워주세요 */
	z-index: 1000; /* 다른 요소 위로 떠 있도록 충분히 큰 값으로 설정 */
}

.tab a {
	text-decoration: none;
	color: #333;
	padding: 4px 8px;
}

.tab a:hover {
	color: #000;
	border-bottom: 2px solid #000;
}

.thumbnails {
	display: flex;
	justify-content: center; /* ← 가로 중앙 정렬 */
	gap: 8px;
	margin-top: 12px;
}

.thumbnails .thumb {
	width: 80px;
	height: 80px;
	object-fit: cover;
	border: 2px solid transparent;
	border-radius: 4px;
	cursor: pointer;
	opacity: 0.8;
	transition: opacity .2s, border-color .2s;
}

.thumbnails .thumb:hover, .thumbnails .thumb.active {
	opacity: 1;
	border-color: #333;
}
/* 이미지 묶음 레이아웃 */
/* 기존 flex 레이아웃을 모두 제거하고, 세로 스택으로 변경 */
.image-group {
	display: block;
	margin: 16px 0;
}

.image-group img {
	display: block;
	width: 100%; /* 필요에 따라 max-width로 제한하세요 */
	max-width: 400px; /* 예시: 최대 400px */
	height: auto;
	margin: 8px auto; /* 위아래 8px 간격, 가로 중앙 정렬 */
	border-radius: 4px;
	object-fit: cover;
}

/* 설명문 */
.description {
	margin: 16px 0;
	line-height: 1.6;
	color: #444;
}

/* 사이즈 차트 */
.size-chart {
	text-align: center;
	margin: 24px 0;
}

/* 사이즈 차트 이미지 작게 조정 */
.size-chart img {
  display: block;
  width: 500px;      /* 원하는 고정 너비 */
  max-width: 90%;    /* 컨테이너 폭 대비 최대 90% */
  height: auto;
  margin: 16px auto; /* 위아래 여백 + 가로 중앙 정렬 */
}


.btn-inquiry, .btn-inquiry-secondary {
	background: #303030;
	color: #fff;
	border: none;
	padding: 8px 16px;
	border-radius: 4px;
	cursor: pointer;
	font-size: 14px;
}

.btn-inquiry:hover, .btn-inquiry-secondary:hover {
	opacity: 0.8;
}

.inquiry-buttons {
	text-align: right;
	margin-top: 16px;
}

.inquiry-card {
	max-width: 400px;
	margin: 16px auto;
	padding: 16px;
	border: 1px solid #eee;
	border-radius: 8px;
	background: #fafafa;
}
/* 입력창 공통 */
.inquiry-card input[type="text"], .inquiry-card textarea {
	width: 100%;
	padding: 8px 12px;
	font-size: 14px;
	border: 1px solid #ddd;
	border-radius: 4px;
	box-sizing: border-box;
	margin-bottom: 12px;
}

.inquiry-card textarea {
	height: 80px;
	resize: vertical;
}
/* 파일 선택 라벨 */
.inquiry-card .file-label {
	display: inline-block;
	background: #303030;
	color: #fff;
	padding: 6px 12px;
	border-radius: 4px;
	cursor: pointer;
	font-size: 13px;
	margin-bottom: 0;
}

.inquiry-card .file-label:hover {
	opacity: 0.9;
}

.inquiry-card .file-name {
	margin-left: 8px;
	font-size: 12px;
	color: #666;
	vertical-align: middle;
}
/* 버튼 그룹 */
.inquiry-card .btn-group {
	display: flex;
	justify-content: center;
	gap: 12px;
	margin-top: 16px;
}

.inquiry-card .btn-inquiry, .inquiry-card .btn-inquiry-secondary {
	width: 100px;
	padding: 8px 0;
	font-size: 14px;
	border-radius: 4px;
	border: none;
	cursor: pointer;
}

.inquiry-card .btn-inquiry {
	background: #303030;
	color: #fff;
}

.inquiry-card .btn-inquiry-secondary {
	background: #fff;
	color: #303030;
	border: 1px solid #ccc;
}

.inquiry-card .btn-inquiry:hover, .inquiry-card .btn-inquiry-secondary:hover
	{
	opacity: 0.9;
}
.description {
  /* 이미지와 같은 최대 너비 */
  max-width: 400px;
  margin: 16px auto;            /* 위아래 여백 + 가운데 정렬 */
  padding: 16px;                /* 안쪽 여백 */
  background: #f9f9f9;          /* 은은한 회색배경 */
  border: 1px solid #e0e0e0;    /* 연한 테두리 */
  border-radius: 8px;           /* 둥근 모서리 */
  font-size: 14px;
  line-height: 1.6;
  color: #333;
  box-shadow: 0 2px 4px rgba(0,0,0,0.05);
}
</style>
</head>
<body>
	<jsp:include page="/header" />
	<%@ include file="scrollTop.jsp" %>
	<div class="container">
		<section class="grid">
			<!-- 좌측: 메인 이미지 + 썸네일 -->
			<div>

				<!-- 메인 이미지 -->
				<img id="mainImage"
					src="${pageContext.request.contextPath}/image/${product.mainImage1}"
					style="width: 100%; height: 400px; object-fit: cover; border-radius: 8px;"
					alt="${product.name}" />

				<!-- 썸네일 4장 고정 노출 -->
				<div class="thumbnails"
					style="display: flex; gap: 8px; margin-top: 10px;">
					<c:if test="${not empty product.mainImage1}">
						<img class="thumb"
							src="${pageContext.request.contextPath}/image/${product.mainImage1}"
							data-src="${pageContext.request.contextPath}/image/${product.mainImage1}"
							alt="썸네일1"
							style="width: 80px; height: 80px; object-fit: cover; border-radius: 4px; cursor: pointer;" />
					</c:if>

					<c:if test="${not empty product.mainImage2}">
						<img class="thumb"
							src="${pageContext.request.contextPath}/image/${product.mainImage2}"
							data-src="${pageContext.request.contextPath}/image/${product.mainImage2}"
							alt="썸네일2"
							style="width: 80px; height: 80px; object-fit: cover; border-radius: 4px; cursor: pointer;" />
					</c:if>

					<c:if test="${not empty product.mainImage3}">
						<img class="thumb"
							src="${pageContext.request.contextPath}/image/${product.mainImage3}"
							data-src="${pageContext.request.contextPath}/image/${product.mainImage3}"
							alt="썸네일3"
							style="width: 80px; height: 80px; object-fit: cover; border-radius: 4px; cursor: pointer;" />
					</c:if>

					<c:if test="${not empty product.mainImage4}">
						<img class="thumb"
							src="${pageContext.request.contextPath}/image/${product.mainImage4}"
							data-src="${pageContext.request.contextPath}/image/${product.mainImage4}"
							alt="썸네일4"
							style="width: 80px; height: 80px; object-fit: cover; border-radius: 4px; cursor: pointer;" />
					</c:if>
				</div>


			</div>

			<!-- 우측: 제목 + 별점 + 좋아요 + 가격 + 드롭다운 -->
			<div>
				<!-- 제목 + 별점 + 후기 + 좋아요 버튼 -->
				<div
					style="display: flex; align-items: center; justify-content: space-between; margin-bottom: 12px;">
					<div>
						<h2 style="font-size: 28px; margin: 0;">${product.name}</h2>
						<div
							style="display: flex; align-items: center; gap: 8px; font-size: 16px; margin-top: 10px;">
							<div id="starRating" data-rating="${avgRating}"
								style="color: #facc15;"></div>
							<span style="color: #666;">(${avgRating}점)</span> <span
								style="color: #666;">| 리뷰 ${fn:length(reviewList)}개</span>
						</div>
					</div>

					<button id="likeBtn" data-product-id="${product.productId}"
						class="button"
						style="background: white; border-radius: 8px; padding: 4px 10px; display: flex; align-items: center; gap: 6px; font-size: 16px;">
						<span id="likeIcon">${likedByUser ? '❤️' : '🤍'}</span> <span
							id="likeCount">${likeCount}</span>
					</button>
				</div>


				<!-- 가격 -->
				<div style="margin: 32px 0; font-size: 20px; line-height: 1.5;">
					<c:set var="finalPrice" value="${product.price - product.discount}" />
					<c:set var="discountRate"
						value="${(product.discount * 100) / product.price}" />

					<c:choose>
						<c:when test="${product.discount > 0}">
							<!-- 원가 -->
							<div style="color: #999; text-decoration: line-through;">
								<fmt:formatNumber value="${product.price}" type="number" />
								원
							</div>
							<!-- 할인율 + 최종가 -->
							<div>
								<span style="color: red; font-weight: bold;"> <fmt:formatNumber
										value="${discountRate}" type="number" maxFractionDigits="0" />%
								</span> &nbsp; <span id="basePrice"
									style="color: #000; font-weight: bold;"> <fmt:formatNumber
										value="${finalPrice}" type="number" />원
								</span>
							</div>
						</c:when>
						<c:otherwise>
							<div id="basePrice" style="color: #000; font-weight: bold;">
								<fmt:formatNumber value="${product.price}" type="number" />
								원
							</div>
						</c:otherwise>
					</c:choose>
				</div>




				<!-- 드롭다운 -->
				<select id="colorSelect"
					style="margin-top: 32px 0; padding: 8px 12px; border: 1px solid #ccc; border-radius: 4px; font-size: 14px;">
					<option value="" disabled selected>색상 선택</option>
				</select> <select id="sizeSelect" disabled
					style="margin-top: 10px; padding: 8px 12px; border: 1px solid #ccc; border-radius: 4px; font-size: 14px;">
					<option value="" disabled selected>사이즈 선택</option>
				</select>

				<!-- 옵션 출력 -->
				<div id="optionContainer" class="option-box"
					style="margin-top: 12px;"></div>

				<!-- 총합 -->
				<div id="totalPrice"
					style="text-align: right; margin: 16px 0; font-size: 18px; font-weight: bold;">
					총 합계: 0원</div>

				<!-- 버튼 -->
				<div style="display: flex; gap: 10px;">
					<button id="addCartBtn" data-product-id="${product.productId}"
						class="button" style="flex: 1;">장바구니</button>
					<button id="buyNowBtn" class="button button-black" style="flex: 1; background-color:#303030">구매하기</button>
				</div>
			</div>
		</section>


		<div class="tab">
			<a href="#info">상품설명</a> <a href="#size">사이즈표</a> <a href="#review">후기</a>
			<a href="#inquiry">상품문의</a>
		</div>

		<section id="info" class="p-4 border mt-4">
			<h3>상품 설명</h3>

			<!-- 1~5번 이미지 -->
			<c:if
				test="${not empty product.image1 or not empty product.image2 or not empty product.image3 or not empty product.image4 or not empty product.image5}">
				<div class="image-group group1">
					<c:if test="${not empty product.image1}">
						<img
							src="${pageContext.request.contextPath}/image/${product.image1}"
							alt="Image1" />
					</c:if>
					<c:if test="${not empty product.image2}">
						<img
							src="${pageContext.request.contextPath}/image/${product.image2}"
							alt="Image2" />
					</c:if>
					<c:if test="${not empty product.image3}">
						<img
							src="${pageContext.request.contextPath}/image/${product.image3}"
							alt="Image3" />
					</c:if>
					<c:if test="${not empty product.image4}">
						<img
							src="${pageContext.request.contextPath}/image/${product.image4}"
							alt="Image4" />
					</c:if>
					<c:if test="${not empty product.image5}">
						<img
							src="${pageContext.request.contextPath}/image/${product.image5}"
							alt="Image5" />
					</c:if>
				</div>
			</c:if>

			<!-- description1 -->
			<c:if test="${not empty product.description1}">
				<div class="description">${product.description1}</div>
			</c:if>

			<!-- 6~10번 이미지 -->
			<c:if
				test="${not empty product.image6 or not empty product.image7 or not empty product.image8 or not empty product.image9 or not empty product.image10}">
				<div class="image-group group2">
					<c:if test="${not empty product.image6}">
						<img
							src="${pageContext.request.contextPath}/image/${product.image6}"
							alt="Image6" />
					</c:if>
					<c:if test="${not empty product.image7}">
						<img
							src="${pageContext.request.contextPath}/image/${product.image7}"
							alt="Image7" />
					</c:if>
					<c:if test="${not empty product.image8}">
						<img
							src="${pageContext.request.contextPath}/image/${product.image8}"
							alt="Image8" />
					</c:if>
					<c:if test="${not empty product.image9}">
						<img
							src="${pageContext.request.contextPath}/image/${product.image9}"
							alt="Image9" />
					</c:if>
					<c:if test="${not empty product.image10}">
						<img
							src="${pageContext.request.contextPath}/image/${product.image10}"
							alt="Image10" />
					</c:if>
				</div>
			</c:if>

			<!-- description2 -->
			<c:if test="${not empty product.description2}">
				<div class="description">${product.description2}</div>
			</c:if>

			<!-- 사이즈 차트 -->
			<section id="size" class="p-4 border mt-4">
				<c:if test="${not empty product.sizeChart}">
					<div class="size-chart">
						<img
							src="${pageContext.request.contextPath}/image/${product.sizeChart}"
							alt="사이즈 차트" />
					</div>
				</c:if>
			</section>
		</section>

		<section id="review" class="p-4 border mt-4">
			<h3>후기 (${fn:length(reviewList)}개)</h3>
			 <c:if test="${not empty sessionScope.userId}">
    <div style="text-align: right; margin-bottom: 12px;">
      <a href="<c:url value='myReviewList'/>"
         class="btn-inquiry"
         style="padding:6px 12px; font-size:14px;">
        후기 쓰러 가기
      </a>
    </div>
  </c:if>
			<c:forEach var="review" items="${reviewList}">
				<div class="border p-4 mb-4 review-item">
					<strong>${review.userId}</strong> ⭐ ${review.rating}<br /> <span>${review.content}</span>
					<c:if test="${not empty review.image}">
  <div style="margin-top:8px;">
    <img
      src="${pageContext.request.contextPath}/image/${review.image}"
      alt="리뷰 이미지"
      style="width:200px; height:200px; object-fit:cover; border-radius:4px;"
    />
  </div>
</c:if>
					
				</div>
			</c:forEach>
		</section>

		<section id="inquiry" class="p-4 border mt-4">
			<h3>상품문의</h3>


			<div class="inquiry-buttons"
				style="text-align: right; margin-bottom: 8px;">
				<c:choose>
					<c:when test="${sessionScope.isSeller}">
						<a href="<c:url value='adminInquiry'/>"
							class="btn-inquiry-secondary"> 문의 관리 </a>
					</c:when>
					<c:when test="${not empty sessionScope.userId}">
						<a href="/yousinsa/myInquiryList" class="btn-inquiry"
							style="margin-right: 4px;"> 내가 쓴 문의 </a>
					</c:when>
				</c:choose>
			</div>


			<c:forEach var="inq" items="${inquiryList}">
				<c:choose>

					<c:when test="${inq.userId eq sessionScope.userId}">
						<div id="myInquiry" class="border p-4 mb-4 inquiry-item"
							style="scroll-margin-top: 80px;">
							<strong>${inq.title}</strong><br />
							<p>${inq.content}</p>
							<c:if test="${not empty inq.image}">
								<div style="margin-top: 8px;">
									<img
										src="${pageContext.request.contextPath}/image/${inq.image}"
										alt="첨부 이미지"
										style="max-width: 200px; height: auto; border: 1px solid #ccc; border-radius: 4px;" />
								</div>
							</c:if>
							<c:if test="${not empty inq.answer}">
								<div style="margin-top: 8px; color: blue;">
									<strong>답변:</strong> ${inq.answer}
								</div>
							</c:if>
							<div class="text-sm">작성자: ${inq.userId} |
								${inq.questionDate}</div>
						</div>
					</c:when>

					<c:otherwise>
						<div class="border p-4 mb-4 inquiry-item">
							<strong>${inq.title}</strong><br />
							<c:choose>
								<c:when test="${sessionScope.isSeller}">

									<p>${inq.content}</p>
									<c:if test="${not empty inq.image}">
										<div style="margin-top: 8px;">
											<img
												src="${pageContext.request.contextPath}/image/${inq.image}"
												alt="첨부 이미지"
												style="max-width: 200px; height: auto; border: 1px solid #ccc; border-radius: 4px;" />
										</div>
									</c:if>
									<c:if test="${not empty inq.answer}">
										<div style="margin-top: 8px; color: blue;">
											<strong>답변:</strong> ${inq.answer}
										</div>
									</c:if>
								</c:when>
								<c:otherwise>
              🔒 비밀글입니다.
            </c:otherwise>
							</c:choose>
							<div class="text-sm">작성자: ${inq.userId} |
								${inq.questionDate}</div>
						</div>
					</c:otherwise>
				</c:choose>
			</c:forEach>


			<c:choose>
				<c:when test="${not empty sessionScope.userId}">
					<div class="inquiry-buttons" style="text-align: right;">
						<button type="button" id="openInquiryForm" class="btn-inquiry">문의하기</button>
					</div>

					<!-- 문의하기 폼 -->
					<div id="inquiryForm" class="inquiry-card" style="display: none;">
						<form action="<c:url value='/inquiryAdd'/>" method="post"
							enctype="multipart/form-data">
							<input type="hidden" name="productId"
								value="${product.productId}" /> <input type="text" name="title"
								placeholder="제목" required />

  <select name="type" required
            style="width:100%; padding:8px 12px; font-size:14px;
                   border:1px solid #ddd; border-radius:4px;
                   margin-bottom:12px; background:#fff;">
      <option value="" disabled selected>문의 종류 선택</option>
      <option value="배송문의">배송문의</option>
      <option value="취소/교환/반품">취소/교환/반품</option>
      <option value="주문/결제">주문/결제</option>
      <option value="기타">기타</option>
    </select>
    
							<textarea name="content" placeholder="내용" required></textarea>

							<input type="file" id="inquiryImage" name="image"
								accept="image/*" onchange="previewImage(event)"
								style="display: none;" /> <label for="inquiryImage"
								class="file-label">사진 선택</label> <span id="previewFilename"
								class="file-name"></span>

							<div class="btn-group">
								<button type="submit" class="btn-inquiry">등록</button>
								<button type="button" id="cancelInquiry"
									class="btn-inquiry-secondary">취소</button>
							</div>
						</form>
					</div>

					<script>
  // 파일 선택 후 파일명 표시
  function previewImage(evt) {
    const file = evt.target.files[0];
    document.getElementById('previewFilename').textContent = file ? file.name : '';
  }
  // 열기/닫기
  document.getElementById('openInquiryForm').onclick = () => {
    document.getElementById('inquiryForm').style.display = 'block';
  };
  document.getElementById('cancelInquiry').onclick = () => {
    document.getElementById('inquiryForm').style.display = 'none';
  };
</script>

				</c:when>
				<c:otherwise>
					<div class="inquiry-buttons" style="text-align: right;">
						<a href="<c:url value='/login'/>" class="btn-inquiry">로그인 후
							문의하기</a>
					</div>
				</c:otherwise>
			</c:choose>
		</section>



	</div>
	<jsp:include page="footer.jsp"/>


	<!-- 1) 옵션 선택 & 총합 계산 스크립트 -->


	<script>
document.addEventListener('DOMContentLoaded', () => {
  // 1) 가격 가져오기
  const basePrice = parseInt(
    document.getElementById('basePrice')
      .textContent.replace(/\D/g, ''), 10
  );

  // 2) 재고 리스트 JSON
  const stockList = [
    <c:forEach var="s" items="${stockList}" varStatus="st">
      { color:'<c:out value="${s.color}"/>',
        size:'<c:out value="${s.size}"/>',
        quantity:${s.quantity}
      }<c:if test="${!st.last}">,</c:if>
    </c:forEach>
  ];

  const colorSelect     = document.getElementById('colorSelect');
  const sizeSelect      = document.getElementById('sizeSelect');
  const optionContainer = document.getElementById('optionContainer');
  const totalPriceEl    = document.getElementById('totalPrice');
  const productId   = '${product.productId}';
  const userId      = '${sessionScope.userId}';

  // 3) 총합 계산 함수
  function updateTotal() {
    let sum = 0;
    document.querySelectorAll('.selected-item').forEach(div => {
      sum += parseInt(div.querySelector('.count').textContent, 10)
           * basePrice;
    });
    totalPriceEl.textContent = '총 합계: ' + sum.toLocaleString() + '원';
  }

  // 4) 색상 옵션 한 번 초기화
  [...new Set(stockList.map(i => i.color.trim()))]
    .forEach(col => {
      colorSelect.append(new Option(col, col));
    });


// 5) 색상 선택 시 사이즈 채우기
  colorSelect.addEventListener('change', function() {
    sizeSelect.innerHTML = '';
    sizeSelect.disabled  = true;
    sizeSelect.add(new Option('사이즈 선택',''));
    const c = this.value;
    if (!c) return;

    stockList
      .filter(i => i.color.trim() === c)
      .forEach(i => {
        const sizeVal = i.size.trim();
        const label   = sizeVal + (i.quantity>0
          ? ' - 재고: ' + i.quantity
          : ' - 품절');
        const opt = new Option(label, sizeVal);
        // 품절 옵션에만 플래그
        if (i.quantity === 0) {
          opt.dataset.soldout = 'true';
          opt.style.color    = '#999';
        }
        sizeSelect.add(opt);
      });

    sizeSelect.disabled = false;
  });
  
//6) 사이즈 선택 시 항목 추가
  sizeSelect.addEventListener('change', function() {
	  const sel = this.options[this.selectedIndex];
	  if (sel.dataset.soldout === 'true') {
		  if (confirm('해당 옵션은 품절되었습니다. 재입고 알림을 받겠습니까?')) {
		    fetch('${pageContext.request.contextPath}/restockRequestAdd', {
		      method: 'POST',
		      credentials: 'include',
		      headers: { 'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8' },
		      body:
		        'productId=' + encodeURIComponent(productId)
		        + '&userId='   + encodeURIComponent(userId)
		        + '&color='    + encodeURIComponent(colorSelect.value)
		        + '&size='     + encodeURIComponent(sel.value)
		    })
		    .then(r => {
		      if (r.status === 401) {
		        // 로그인 필요
		        window.location.href = '${pageContext.request.contextPath}/login';
		      } else if (r.ok) {
		        alert('재입고 요청이 접수되었습니다.');
		      } else {
		        alert('오류가 발생했습니다.');
		      }
		    })
		    .catch(() => alert('네트워크 오류'));
		  }
		  this.selectedIndex = 0;
		  this.disabled      = true;
		  return;
		}


	    // ─── 재고 있는 옵션 클릭 시: 기존 추가 로직 ───────────
	    const c = colorSelect.value.trim();
	    const s = sel.value;
	    if (!c || !s) return;

    // 2) 이미 추가된 항목 있는지 찾기
    const existing = optionContainer.querySelector(
      '.selected-item[data-color="' + c + '"][data-size="' + s + '"]'
    );

    if (existing) {
      // 2a) 있으면 수량 +1, 가격 갱신
      const cntEl = existing.querySelector('.count');
      let cnt = parseInt(cntEl.textContent, 10) + 1;
      cntEl.textContent = cnt;
      existing.querySelector('.price').textContent =
        (cnt * basePrice).toLocaleString() + '원';
      updateTotal();

    } else {
      // 2b) 새 항목 생성
      const div = document.createElement('div');
      div.className = 'selected-item';
      div.dataset.color = c;
      div.dataset.size  = s;
      div.style.cssText =
        'display:flex;align-items:center;gap:8px;'
        + 'border:1px solid #ccc;padding:10px;'
        + 'border-radius:8px;margin-top:10px;';
      div.innerHTML =
        '<div style="flex:1;display:flex;align-items:center;">' +
          '<span style="min-width:100px;color:#000;">' + c + ' · ' + s + '</span>' +
        '</div>' +
        '<div style="display:flex;align-items:center;justify-content:center;gap:8px;width:150px;">' +
          '<button class="minus button" style="width:32px;height:32px;border:1px solid #ccc;border-radius:4px;background:#fff;display:flex;align-items:center;justify-content:center;">-</button>' +
          '<span class="count" style="min-width:20px;text-align:center;">1</span>' +
          '<button class="plus button"  style="width:32px;height:32px;border:1px solid #ccc;border-radius:4px;background:#fff;display:flex;align-items:center;justify-content:center;">+</button>' +
        '</div>' +
        '<div style="display:flex;align-items:center;justify-content:flex-end;gap:8px;margin-left:auto;">' +
          '<span class="price" style="min-width:60px;text-align:right;color:#000;">' +
            basePrice.toLocaleString() + '원' +
          '</span>' +
          '<button class="remove button" style="width:32px;height:32px;border:1px solid #ccc;border-radius:4px;background:#fff;display:flex;align-items:center;justify-content:center;color:#f00;">×</button>' +
        '</div>';

      // 3) 버튼 이벤트 바인딩
      div.querySelector('.minus').addEventListener('click', () => {
        const cntEl = div.querySelector('.count');
        let cnt = parseInt(cntEl.textContent, 10) - 1;
        if (cnt > 0) {
          cntEl.textContent = cnt;
          div.querySelector('.price').textContent =
            (cnt * basePrice).toLocaleString() + '원';
        } else {
          div.remove();
        }
        updateTotal();
      });
      div.querySelector('.plus').addEventListener('click', () => {
        const cntEl = div.querySelector('.count');
        let cnt = parseInt(cntEl.textContent, 10) + 1;
        const maxQty = stockList.find(i=>i.color.trim()===c&&i.size.trim()===s).quantity;
        if (cnt <= maxQty) {
          cntEl.textContent = cnt;
          div.querySelector('.price').textContent =
            (cnt * basePrice).toLocaleString() + '원';
        } else {
          alert('재고를 초과할 수 없습니다.');
        }
        updateTotal();
      });
      div.querySelector('.remove').addEventListener('click', () => {
        div.remove();
        updateTotal();
      });

      optionContainer.appendChild(div);
      updateTotal();
    }

    // 4) 드롭다운 초기화
    colorSelect.value = '';
    while (sizeSelect.options.length) sizeSelect.remove(0);
    const ph = document.createElement('option');
    ph.value = '';
    ph.text  = '사이즈 선택';
    ph.disabled = true;
    ph.selected = true;
    sizeSelect.add(ph);
    sizeSelect.disabled = true;
  });



});
</script>




	<!-- 2) 좋아요 토글 스크립트 -->
	<script>
  (function(){
    const btn   = document.getElementById('likeBtn');
    if (!btn) return;

    const icon  = document.getElementById('likeIcon');
    const cntEl = document.getElementById('likeCount');
    const pid   = btn.dataset.productId;
    // URL은 c:url 로 생성
    const likeUrl = '<%=response.encodeURL(request.getContextPath() + "/likeProduct")%>';

    btn.addEventListener('click', () => {
      fetch(likeUrl, {
        method: 'POST',
        // 세션 쿠키를 꼭 포함하라고 명시
        credentials: 'include',
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8'
        },
        body: 'productId=' + encodeURIComponent(pid)
      })
      .then(res => {
        if (res.status === 401) {
          alert('로그인 후 이용해주세요.');
          return Promise.reject('unauthorized');
        }
        if (!res.ok) return Promise.reject('fetch error');
        return res.json();
      })
      .then(json => {
        // 서버가 준 liked, count 로 UI 갱신
        icon.textContent = json.liked ? '💖' : '🤍';
        cntEl.textContent  = json.count;
      })
      .catch(err => {
        if (err !== 'unauthorized') console.error(err);
      });
    });
  })();
</script>

	<script>
document.addEventListener('DOMContentLoaded', () => {
  const btn = document.getElementById('addCartBtn');
  if (!btn) return;

  btn.addEventListener('click', async () => {
    const ctx       = '<c:url value="/" />'.slice(0,-1); // contextPath
    const productId = btn.dataset.productId;

    // 1) 선택된 옵션 수집
    const items = Array.from(
      document.querySelectorAll('.selected-item')
    ).map(div => ({
      color:    div.dataset.color,
      size:     div.dataset.size,
      quantity: parseInt(div.querySelector('.count').textContent, 10)
    }));

    if (items.length === 0) {
      alert('옵션을 하나 이상 선택해주세요.');
      return;
    }

    try {
      // 2) 각각의 옵션을 서버에 전송
      for (const it of items) {
        const body = new URLSearchParams();
        body.append('productId', productId);
        body.append('color',      it.color);
        body.append('size',       it.size);
        body.append('quantity',   it.quantity);

        await fetch(`${ctx}/yousinsa/cartAdd`, {
          method: 'POST',
          credentials: 'include',
          headers: {
            'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8'
          },
          body: body.toString()
        });
      }

      // 3) 전송 완료 후 선택지 띄우기
      const goCart = confirm(
        '장바구니에 담겼습니다.\n\n' +
        '장바구니로 이동하시겠습니까?\n' +
        '(확인: 이동, 취소: 계속 쇼핑)'
      );
      if (goCart) {
        window.location.href = `${ctx}/yousinsa/cart`;
      }
      // else: 현재 페이지에 머뭅니다.

    } catch (e) {
      console.error(e);
      alert('장바구니 담기 중 오류가 발생했습니다.');
    }
  });
});
</script>


	<script>
document.addEventListener('DOMContentLoaded', function() {
  const mainImg = document.getElementById('mainImage');
  document.querySelectorAll('.thumbnails .thumb').forEach(function(thumb) {
    thumb.addEventListener('click', function() {
      // 클릭한 썸네일의 data-src 값을 메인 이미지에 적용
      mainImg.src = this.getAttribute('data-src');
    });
  });
});
</script>

	<script>
document.addEventListener('DOMContentLoaded', () => {
  const buyBtn = document.getElementById('buyNowBtn');
  if (!buyBtn) return;

  buyBtn.addEventListener('click', () => {
    const items = Array.from(
      document.querySelectorAll('.selected-item')
    ).map(div => ({
      productId: '<c:out value="${product.productId}"/>',
      color:     div.dataset.color,
      size:      div.dataset.size,
      quantity:  parseInt(div.querySelector('.count').textContent, 10)
    }));

    if (items.length === 0) {
      alert('옵션을 하나 이상 선택해주세요.');
      return;
    }

    const form = document.createElement('form');
    form.method = 'get';
    form.action = '<c:url value="/order" />';

    items.forEach(it => {
      ['productId','color','size','quantity'].forEach(name => {
        const input = document.createElement('input');
        input.type  = 'hidden';
        input.name  = name;     // <-- indexed 대신 단일 name
        input.value = it[name];
        form.appendChild(input);
      });
    });

    document.body.appendChild(form);
    form.submit();
  });
});
</script>
	<script>
document.addEventListener('DOMContentLoaded', () => {
  const el = document.getElementById('starRating');
  if (!el) return;

  const rating = parseInt(el.dataset.rating || '0', 10);
  const max = 5;
  let html = '';

  for (let i = 0; i < rating; i++) html += '★';
  for (let i = rating; i < max; i++) html += '☆';

  el.innerHTML = html;
});
</script>



</body>
</html>
