<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<title>교환 접수 - 상세</title>
<style>
* {
	box-sizing: border-box;
}

body {
	font-family: 'Segoe UI', 'Noto Sans KR', sans-serif;
	background-color: #f4f6f8;
	margin: 0;
	padding: 40px 20px;
}

.container {
	max-width: 900px;
	background-color: #ffffff;
	padding: 40px;
	border-radius: 12px;
	box-shadow: 0 8px 20px rgba(0, 0, 0, 0.05);
	margin: 0 auto;
}

h2 {
	margin-bottom: 30px;
	color: #333;
	font-size: 24px;
}

h3 {
	color: #444;
	font-size: 18px;
	margin-top: 30px;
	margin-bottom: 10px;
}

label {
	font-weight: 600;
	margin-top: 15px;
	display: block;
	color: #555;
}

input[type="text"], textarea {
	width: 100%;
	padding: 10px 14px;
	border: 1px solid #ccc;
	border-radius: 6px;
	font-size: 14px;
	margin-top: 6px;
	background-color: #fafafa;
}

textarea {
	resize: vertical;
	min-height: 80px;
}

table {
	width: 100%;
	border-collapse: collapse;
	margin-top: 15px;
	margin-bottom: 20px;
	font-size: 14px;
}

th, td {
	padding: 12px;
	border: 1px solid #e0e0e0;
	text-align: center;
}

th {
	background-color: #f2f4f6;
	font-weight: 600;
}

.image-thumb {
	width: 80px;
	border-radius: 4px;
}

.radio-box {
	border: 1px solid #ddd;
	border-radius: 6px;
	padding: 16px;
	background-color: #fafafa;
	display: flex;
	flex-wrap: wrap;
	gap: 20px;
	margin-bottom: 20px;
}

.buttons {
	display: flex;
	justify-content: center;
	gap: 16px;
	margin-top: 40px;
}

.buttons button {
	padding: 12px 28px;
	border: none;
	border-radius: 6px;
	font-size: 14px;
	cursor: pointer;
	transition: background 0.2s;
}

.buttons button[type="submit"] {
	background-color: #111;
	color: white;
}

.buttons button[type="button"] {
	background-color: #eee;
	color: #333;
}
</style>
<script>
    function toggleRejectReasons() {
      const isRejected = document.querySelector('input[name="exchangeStatus"]:checked')?.value === '반려';
      document.querySelectorAll('input[name="rejectReason"]').forEach(r => {
        r.disabled = !isRejected;
        if (!isRejected) r.checked = false;
      });
    }
    window.addEventListener('DOMContentLoaded', () => {
      document.querySelectorAll('input[name="exchangeStatus"]').forEach(r =>
        r.addEventListener('change', toggleRejectReasons)
      );
      toggleRejectReasons();
    });
  </script>
<jsp:include page="adminSideBarStyle.jsp" />
</head>
<body>
	<jsp:include page="adminSideBar.jsp" />
	<div class="container">
		<h2>교환 접수 - 상세</h2>
		<form method="post"
			action="${pageContext.request.contextPath}/adminexchangeprocess">
			<input type="hidden" name="exchangeId" value="${exchange.exchangeId}" />

			<label>계정명</label> <input type="text" value="${userId}" readonly />

			<label>회원이름</label> <input type="text" value="${userName}" readonly />

			<table>
				<tr>
					<td><strong>주문일자:</strong> ${orderDate}</td>
					<td><strong>반품신청일자:</strong> ${returnApplyDate}</td>
					<td><strong>주문번호:</strong> ${orderNumber}</td>
					<td><strong>배송방법:</strong> ${deliveryType}</td>
				</tr>
			</table>

			<h3>주문 정보</h3>
			<table>
				<tr>
					<th>상품</th>
					<th>수량</th>
					<th>주문금액</th>
				</tr>
				<tr>
					<td><img src="${productImage}" class="image-thumb"
						alt="상품 이미지" /><br> ${productName}<br>사이즈:
						${productSize}<br>색상: ${productColor}</td>
					<td>1</td>
					<td>${price}원</td>
				</tr>
			</table>

			<h3>교환 사유</h3>
			<textarea readonly>${exchangeReason}</textarea>

			<h3>교환 요청사항</h3>
			<table>
				<tr>
					<th>색상</th>
					<td>${originColor}→${requestColor}</td>
				</tr>
				<tr>
					<th>사이즈</th>
					<td>${originSize}→${requestSize}</td>
				</tr>
			</table>

			<h3>배송지 정보</h3>
			<table>
				<tr>
					<th>받는분</th>
					<td>${receiver}</td>
				</tr>
				<tr>
					<th>연락처</th>
					<td>${phone}</td>
				</tr>
				<tr>
					<th>주소</th>
					<td>${address}</td>
				</tr>
			</table>

			<label>배송 요청사항</label> <input type="text" value="${shippingMemo}"
				readonly />

			<h3>배송비 입금 상태</h3>
			<table>
				<tr>
					<th>배송비 입금 상태</th>
					<th>입금 완료 여부</th>
				</tr>
				<tr>
					<td>${shippingFeeStatus}</td>
					<td>${isFeePaid}</td>
				</tr>
			</table>

			<h3>교환 처리 상태</h3>
			<div class="radio-box">
				<label><input type="radio" name="exchangeStatus" value="허가" />
					<strong>교환 허가</strong></label> <label><input type="radio"
					name="exchangeStatus" value="반려" /> <strong>교환 반려</strong></label>
			</div>

			<h3>교환 반려 사유</h3>
			<div class="radio-box">
				<label><input type="radio" name="rejectReason"
					value="색상/사이즈 품절" /> 색상 또는 사이즈 품절</label> <label><input
					type="radio" name="rejectReason" value="사유 불충분" /> 교환 사유 불충분</label> <label><input
					type="radio" name="rejectReason" value="기타" /> 기타</label>
			</div>

			<div class="buttons">
				<button type="submit">저장하기</button>
				<!-- 절대 경로로 수정 -->
				<button type="button"
					onclick="location.href='${pageContext.request.contextPath}/admin/adminExchange.jsp'">목록으로</button>

			</div>
		</form>
	</div>
</body>
</html>
