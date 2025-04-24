<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8" />
  <title>반품 접수 - 상세</title>
  <style>
    * {
      box-sizing: border-box;
    }
  
    body {
  font-family: 'Segoe UI', 'Noto Sans KR', sans-serif;
  background-color: #f4f6f8;
  margin: 0;
  padding: 40px 20px;
  display: block; /* 또는 flex 제거 */
}
  
.container {
  width: 100%;
  max-width: 900px;
  background-color: #ffffff;
  padding: 40px;
  border-radius: 12px;
  box-shadow: 0 8px 20px rgba(0, 0, 0, 0.05);
  margin: 0 auto; /* 중앙 정렬 */
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
  
    input[type="text"],
    textarea {
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
  
    .info-row {
      display: flex;
      flex-wrap: wrap;
      gap: 20px;
      margin-bottom: 20px;
    }
  
    .info-box {
      flex: 1 1 45%;
      display: flex;
      flex-direction: column;
    }
  
    .image-thumb {
      width: 80px;
      border-radius: 6px;
    }
  
    .radio-group {
      display: flex;
      flex-wrap: wrap;
      gap: 20px;
      margin-top: 10px;
    }
  
    .radio-group label {
      font-weight: 500;
      color: #333;
    }
  
    .total {
      font-weight: bold;
      text-align: right;
      margin-top: 10px;
      font-size: 16px;
      color: #111;
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
  
    .buttons button[type="submit"]:hover {
      background-color: #333;
    }
  
    .buttons button[type="button"] {
      background-color: #eee;
      color: #333;
    }
  
    .buttons button[type="button"]:hover {
      background-color: #ddd;
    }
  
    .info-table-row {
      background-color: #fafafa;
      border: 1px solid #ddd;
      border-radius: 6px;
      padding: 16px;
      display: flex;
      flex-wrap: wrap;
      gap: 20px;
      font-size: 14px;
      margin-bottom: 20px;
    }
  
    .info-table-row div {
      flex: 1 1 45%;
    }
  
    .info-table-row div strong {
      color: #555;
    }

  </style>
  

  <script>
    function toggleRejectReasons() {
      const rejectRadios = document.getElementsByName('refundReason');
      const isRejected = document.querySelector('input[name="refundStatus"]:checked')?.value === '반려';

      rejectRadios.forEach(radio => {
        radio.disabled = !isRejected;
        if (!isRejected) {
          radio.checked = false;
        }
      });
    }

    window.addEventListener('DOMContentLoaded', () => {
      const statusRadios = document.getElementsByName('refundStatus');
      statusRadios.forEach(radio => {
        radio.addEventListener('change', toggleRejectReasons);
      });
      toggleRejectReasons(); // 초기 상태 적용
    });
  </script>
  <jsp:include page="adminSideBarStyle.jsp" />
</head>
<body>
<jsp:include page="adminSideBar.jsp" />
<div class="container">
  <h2>반품 접수 - 상세</h2>

  <div class="info-box">
    <label>아이디</label>
    <input type="text" value="${userId}" readonly />
    <label>회원이름</label>
    <input type="text" value="${userName}" readonly />
  </div>

  <table class="info-table">
    <tr>
      <td><strong>주문일자:</strong> ${orderDate}</td>
      <td><strong>반품신청일자:</strong> ${returnApplyDate}</td>
      <td><strong>주문번호:</strong> ${orderNumber}</td>
      <td><strong>배송방법:</strong> ${deliveryType}</td>
    </tr>
  </table>

  <h3>주문 정보</h3>
  <table>
    <tr><th>상품</th><th>수량</th><th>주문금액</th></tr>
    <tr>
      <td>
        <img src="${productImage}" class="image-thumb" alt="상품 이미지" /><br>
        ${productName}<br>
        ${productSize}<br>
        ${productColor}
      </td>
      <td>${quantity}</td>
      <td>${price}원</td>
    </tr>
  </table>

  <h3>반품 사유</h3>
  <textarea rows="3" readonly>${returnReason}</textarea>

  <h3>배송지 정보</h3>
  <table>
    <tr><th>반품인</th><td>${receiver}</td></tr>
    <tr><th>연락처</th><td>${phone}</td></tr>
    <tr><th>주소</th><td>${address}</td></tr>
  </table>

  <label>배송 요청사항</label>
  <input type="text" value="${shippingMemo}" readonly />

  <h3>결제 정보</h3>
  <h3>결제 정보</h3>
<table>
  <tr>
    <th>총주문금액</th>
    <th>쿠폰할인금액</th>
    <th>포인트사용</th>
    <th>배송비</th>
  </tr>
  <tr>
    <td>${totalAmount}원</td>
    <td>${discount}원</td>
    <td>${usedPoint}원</td>
    <td>${deliveryFee}원</td>
  </tr>
</table>

  <div class="total">총 결제금액: ${finalAmount}원</div>

  <h3>반품 결정</h3>
  <fieldset class="radio-group">
    <label><input type="radio" name="refundStatus" value="허가" /> 반품 허가</label>
    <label><input type="radio" name="refundStatus" value="반려" /> 반품 반려</label>
  </fieldset>

  <h3>반품 반려 사유</h3>
  <fieldset class="radio-group">
    <label><input type="radio" name="refundReason" value="사유 불충분" /> 반품 사유 불충분</label>
    <label><input type="radio" name="refundReason" value="상품 훼손" /> 상품 훼손</label>
    <label><input type="radio" name="refundReason" value="단순 변심" /> 고객 단순변심</label>
    <label><input type="radio" name="refundReason" value="기타" /> 기타</label>
  </fieldset>

  <div class="buttons">
    <button type="submit">저장하기</button>
    <button type="button" onclick="location.href='returnList.jsp'">목록으로</button>
  </div>
</div>
</body>
</html>
