<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8" />
  <title>주문 상세</title>
  <jsp:include page="../common/header.jsp" />
  <jsp:include page="adminSideBarStyle.jsp" />
  <script src="https://cdn.tailwindcss.com"></script>
  <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
  <style>
    body {
      margin: 0;
      font-family: 'Pretendard', sans-serif;
      background-color: #f8f8f8;
    }
    h2 {
      font-size: 24px;
      font-weight: bold;
      margin-bottom: 30px;
    }
    h3 {
      font-size: 18px;
      font-weight: bold;
      margin-top: 30px;
      margin-bottom: 10px;
      color: #333;
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
    .main-content {
      background-color: white;
      padding: 30px;
      border-radius: 12px;
      box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
      width: 100%;
      max-width: 1200px;
      flex-grow: 1;
    }
    table {
      width: 100%;
      border-collapse: collapse;
      margin-top: 10px;
      margin-bottom: 20px;
      font-size: 14px;
    }
    th, td {
      padding: 12px;
      text-align: center;
      border-bottom: 1px solid #ddd;
    }
    th {
      background-color: #f0f0f0;
      font-weight: 600;
    }
    .total-box {
      background-color: #fafafa;
      padding: 20px;
      font-size: 16px;
      text-align: right;
      border-radius: 8px;
      font-weight: bold;
      color: #e60000;
      margin-top: 20px;
    }
    input[readonly] {
      width: 100%;
      padding: 10px;
      background-color: #fafafa;
      border: 1px solid #ccc;
      border-radius: 6px;
      margin-top: 10px;
      font-size: 14px;
    }
    .buttons {
      text-align: center;
      margin-top: 40px;
    }
    .buttons button {
      padding: 12px 28px;
      font-size: 14px;
      background-color: #111;
      color: #fff;
      border: none;
      border-radius: 6px;
      cursor: pointer;
    }
  </style>
</head>
<body class="bg-gray-100 min-h-screen font-pretendard">
  <div class="content-wrapper">
    <jsp:include page="adminSideBar.jsp" />
    <div class="main-content">
      <h2 class="text-2xl font-bold mb-6">주문 상세</h2>

      <!-- ✅ 주문 기본 정보 -->
      <table>
        <tr>
          <td><strong>주문일자:</strong> ${order.orderDate}</td>
          <td><strong>주문번호:</strong> ${order.orderId}</td>
          <td><strong>배송방법:</strong> ${order.deliveryMethod}</td>
        </tr>
      </table>

      <!-- ✅ 주문자 정보 -->
      <h3>주문자 정보</h3>
      <table>
        <tr>
          <th>주문자 ID</th>
          <td>${order.userId}</td>
        </tr>
      </table>

      <!-- ✅ 배송지 정보 -->
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

      <!-- ✅ 배송 요청사항 -->
      <h3>배송 요청사항</h3>
      <input type="text" value="${order.deliveryRequest}" readonly />

      <!-- ✅ 결제 정보 -->
      <h3>결제 정보</h3>
      <table>
        <tr>
          <th>주문금액</th>
          <th>쿠폰할인금액</th>
          <th>포인트결제</th>
        </tr>
        <tr>
          <td>${order.totalPrice}원</td>
          <td>${order.couponDiscount}원</td>
          <td>${order.usedPoint}원</td>
        </tr>
      </table>

      <div class="total-box">
        총 결제금액: ${order.totalPrice - order.couponDiscount - order.usedPoint}원
      </div>

      <!-- ✅ 목록 버튼 -->
      <div class="buttons">
        <button type="button" onclick="location.href='${pageContext.request.contextPath}/adminOrderSearch'">목록으로</button>
      </div>
    </div>
  </div>

  <jsp:include page="../common/footer.jsp" />
</body>
</html>
