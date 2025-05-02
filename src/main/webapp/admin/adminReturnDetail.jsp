<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>반품 접수 - 상세</title>
  <jsp:include page="../common/header.jsp" />
  <jsp:include page="adminSideBarStyle.jsp" />
  <style>
    body {
      margin: 0;
      font-family: 'Pretendard', sans-serif;
      background-color: #f8f8f8;
      display: flex;
      min-height: 100vh;
      flex-direction: column;
    }

    .layout {
      display: flex;
      flex-grow: 1;
    }

    .main-wrapper {
      flex-grow: 1;
      padding: 40px 60px;
      background-color: #f4f6f8;
    }

    .container {
      max-width: 900px;
      background: white;
      padding: 40px;
      border-radius: 12px;
      box-shadow: 0 8px 20px rgba(0, 0, 0, 0.05);
      margin: auto;
    }

    h2 {
      font-size: 24px;
      font-weight: bold;
      color: #333;
      margin-bottom: 30px;
    }

    h3 {
      font-size: 18px;
      color: #444;
      margin: 30px 0 10px;
    }

    label {
      display: block;
      font-weight: 600;
      margin-top: 15px;
    }

    input[type="text"], textarea {
      width: 100%;
      padding: 10px;
      border: 1px solid #ccc;
      border-radius: 6px;
      background: #fafafa;
      margin-top: 6px;
    }

    table {
      width: 100%;
      border-collapse: collapse;
      margin-top: 15px;
    }

    th, td {
      border: 1px solid #e0e0e0;
      padding: 12px;
      text-align: center;
      font-size: 14px;
    }

    th {
      background: #f2f4f6;
    }

    .radio-group {
      display: flex;
      flex-wrap: wrap;
      gap: 20px;
      margin-top: 10px;
    }

    .radio-group label {
      font-weight: 500;
    }

    .image-thumb {
      width: 80px;
      border-radius: 6px;
    }

    .total {
      text-align: right;
      margin-top: 20px;
      font-weight: bold;
      font-size: 16px;
      color: #111;
    }

    .buttons {
      display: flex;
      justify-content: center;
      gap: 20px;
      margin-top: 40px;
    }

    .buttons button {
      padding: 12px 28px;
      font-size: 14px;
      border: none;
      border-radius: 6px;
      cursor: pointer;
    }

    .buttons button[type="submit"] {
      background: #111;
      color: white;
    }

    .buttons button[type="submit"]:hover {
      background: #333;
    }

    .buttons button[type="button"] {
      background: #eee;
      color: #333;
    }

    .buttons button[type="button"]:hover {
      background: #ddd;
    }
  </style>
</head>
<body>
<div class="layout">
  <jsp:include page="adminSideBar.jsp" />

  <div class="main-wrapper">
    <div class="container">
      <h2>반품 접수 - 상세</h2>

      <form method="post" action="${pageContext.request.contextPath}/adminReturnProcess">
        <input type="hidden" name="returnId" value="${refund.returnId}" />

        <label>아이디</label>
        
        <input type="text" value="${userId}" readonly />


        <label>회원이름</label>
        <input type="text" value="${userName}" readonly />

        <table>
          <tr>
            <td><strong>주문일자:</strong> ${order.orderDate}</td>
            <td><strong>반품신청일자:</strong> ${refund.returnDate}</td>
            <td><strong>주문번호:</strong> ${order.orderId}</td>
            <td><strong>배송방법:</strong> ${order.deliveryMethod}</td>
          </tr>
        </table>

        <h3>주문 정보</h3>
        <table>
          <tr><th>상품</th><th>수량</th><th>주문금액</th></tr>
          <tr>
            <td>
              <img src="${product.image1}" class="image-thumb" alt="상품 이미지" /><br>
              ${product.name}<br>
              사이즈: ${orderItem.size}<br>
              색상: ${orderItem.color}
            </td>
            <td>${orderItem.quantity}</td>
            <td>${product.price}원</td>
          </tr>
        </table>

        <h3>반품 사유</h3>
        <textarea rows="3" readonly>${refund.reason}</textarea>

        <h3>배송지 정보</h3>
        <table>
          <tr><th>반품인</th><td>${order.receiverName}</td></tr>
          <tr><th>연락처</th><td>${order.receiverPhone}</td></tr>
          <tr><th>주소</th><td>${order.receiverAddress}</td></tr>
        </table>

        <label>배송 요청사항</label>
        <input type="text" value="${order.deliveryRequest}" readonly />

        <h3>결제 정보</h3>
        <table>
          <tr><th>총주문금액</th><th>쿠폰할인금액</th><th>포인트사용</th><th>배송비</th></tr>
          <tr>
            <td>${order.totalPrice}원</td>
            <td>${order.couponDiscount}원</td>
            <td>${order.usedPoint}원</td>
            <td>-</td>
          </tr>
        </table>

        <div class="total">총 결제금액: ${order.totalPrice - order.couponDiscount - order.usedPoint}원</div>

        <h3>반품 결정</h3>
        <div class="radio-group">
          <label><input type="radio" name="refundStatus" value="허가"> 반품 허가</label>
          <label><input type="radio" name="refundStatus" value="반려"> 반품 반려</label>
        </div>

        <h3>반품 반려 사유</h3>
        <div class="radio-group">
          <label><input type="radio" name="refundReason" value="사유 불충분"> 사유 불충분</label>
          <label><input type="radio" name="refundReason" value="상품 훼손"> 상품 훼손</label>
          <label><input type="radio" name="refundReason" value="단순 변심"> 단순 변심</label>
          <label><input type="radio" name="refundReason" value="기타"> 기타</label>
        </div>

        <div class="buttons">
          <button type="submit">저장하기</button>
          <button type="button" onclick="location.href='${pageContext.request.contextPath}/adminReturn?status=all'">목록으로</button>
        </div>
      </form>
    </div>
  </div>
</div>

<jsp:include page="../common/footer.jsp" />

<script>
function toggleRejectReasons() {
  const isRejected = document.querySelector('input[name="refundStatus"]:checked')?.value === '반려';
  document.querySelectorAll('input[name="refundReason"]').forEach(radio => {
    radio.disabled = !isRejected;
    if (!isRejected) radio.checked = false;
  });
}
window.addEventListener('DOMContentLoaded', () => {
  document.querySelectorAll('input[name="refundStatus"]').forEach(radio =>
    radio.addEventListener('change', toggleRejectReasons));
  toggleRejectReasons();
});
</script>
</body>
</html>
