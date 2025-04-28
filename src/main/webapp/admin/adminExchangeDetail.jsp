<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<title>교환 접수 - 상세</title>
<jsp:include page="../common/header.jsp" />
<style>
body {
  font-family: 'Pretendard', sans-serif;
  background-color: #f8f8f8;
  margin: 0;
}

h2, h3 {
  color: #333;
}

h2 {
  font-size: 24px;
  font-weight: bold;
  margin-bottom: 30px;
}

h3 {
  font-size: 18px;
  margin-top: 30px;
  margin-bottom: 10px;
}

.content-wrapper {
  display: flex;
  gap: 20px;
  margin: 20px;
}

.sidebar {
  width: 300px;
  flex-shrink: 0;
}

.container {
  background-color: white;
  padding: 40px;
  border-radius: 12px;
  box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
  flex-grow: 1;
  width: 100%;
  max-width: 1200px;
}

label {
  font-weight: 600;
  margin-top: 15px;
  display: block;
  color: #555;
}

input[type="text"], textarea {
  width: 100%;
  padding: 10px;
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
</head>

<body>
<div class="content-wrapper">
  
  <div class="sidebar">
    <jsp:include page="adminSideBar.jsp" />
  </div>

  <div class="container">
    <h2>교환 접수 - 상세</h2>
    <form method="post" action="${pageContext.request.contextPath}/adminExchangeProcess">
      <input type="hidden" name="exchangeId" value="${exchange.exchangeId}" />

      <label>계정명</label>
      <input type="text" value="${user.userId}" readonly />

      <label>회원이름</label>
      <input type="text" value="${user.name}" readonly />

      <table>
        <tr>
          <td><strong>주문일자:</strong> ${order.orderDate}</td>
          <td><strong>교환신청일자:</strong> ${exchange.exchangeDate}</td>
          <td><strong>주문번호:</strong> ${order.orderId}</td>
          <td><strong>배송방법:</strong> ${order.deliveryMethod}</td>
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
          <td>
            <c:choose>
              <c:when test="${not empty product.imageList}">
                <img src="${product.imageList[0]}" class="image-thumb" alt="상품 이미지" />
              </c:when>
              <c:otherwise>
                <img src="/images/no-image.png" class="image-thumb" alt="이미지 없음" />
              </c:otherwise>
            </c:choose><br> 
            ${product.name}<br> 사이즈: ${orderItem.size}<br>
            색상: ${orderItem.color}
          </td>
          <td>${orderItem.quantity}</td>
          <td>${orderItem.price}원</td>
        </tr>
      </table>

      <h3>교환 사유</h3>
      <textarea readonly>${exchange.reason}</textarea>

      <h3>교환 요청사항</h3>
      <table>
        <tr>
          <th>색상</th>
          <td>${orderItem.color} → ${exchange.color}</td>
        </tr>
        <tr>
          <th>사이즈</th>
          <td>${orderItem.size} → ${exchange.size}</td>
        </tr>
      </table>

      <h3>배송지 정보</h3>
      <table>
        <tr>
          <th>받는분</th>
          <td>${order.receiverName}</td>
        </tr>
        <tr>
          <th>연락처</th>
          <td>${order.receiverPhone}</td>
        </tr>
        <tr>
          <th>주소</th>
          <td>${order.receiverAddress}</td>
        </tr>
      </table>

      <label>배송 요청사항</label>
      <input type="text" value="${order.deliveryRequest}" readonly />

      <h3>배송비 입금 상태</h3>
      <table>
        <tr>
          <th>배송비</th>
          <th>입금 여부</th>
        </tr>
        <tr>
          <td>${exchange.shippingFee}</td>
          <td>${exchange.shippingFeePaid}</td>
        </tr>
      </table>

      <h3>교환 처리 상태</h3>
      <div class="radio-box">
        <label><input type="radio" name="exchangeStatus" value="허가" /> <strong>교환 허가</strong></label>
        <label><input type="radio" name="exchangeStatus" value="반려" /> <strong>교환 반려</strong></label>
      </div>

      <h3>교환 반려 사유</h3>
      <div class="radio-box">
        <label><input type="radio" name="rejectReason" value="색상/사이즈 품절" /> 색상 또는 사이즈 품절</label>
        <label><input type="radio" name="rejectReason" value="사유 불충분" /> 교환 사유 불충분</label>
        <label><input type="radio" name="rejectReason" value="기타" /> 기타</label>
      </div>

      <div class="buttons">
        <button type="submit">저장하기</button>
        <button type="button" onclick="location.href='${pageContext.request.contextPath}/admin/adminExchange.jsp'">목록으로</button>
      </div>
    </form>
  </div>
</div>

<jsp:include page="../common/footer.jsp" />
</body>
</html>
