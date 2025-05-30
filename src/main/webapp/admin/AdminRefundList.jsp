<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>환불 상세</title>
  <jsp:include page="../common/header.jsp" />
  <jsp:include page="adminSideBarStyle.jsp" />
  <style>
    body {
      font-family: 'Pretendard', sans-serif;
      background-color: #f8f8f8;
      margin: 0;
    }

    .layout {
      width: 1500px;
      display: flex;
    }

    .container {
      background-color: white;
      max-width: 600px;
      margin: 40px auto;
      padding: 30px;
      border-radius: 12px;
      box-shadow: 0 0 10px rgba(0,0,0,0.1);
    }

    h2 {
      margin-bottom: 20px;
      font-size: 24px;
      font-weight: bold;
      border-bottom: 2px solid #ccc;
      padding-bottom: 10px;
    }

    .row {
      margin-bottom: 16px;
    }

    .label {
      display: block;
      font-weight: bold;
      margin-bottom: 6px;
    }

    input[type="text"], textarea, select {
      width: 100%;
      padding: 10px;
      box-sizing: border-box;
      border: 1px solid #ccc;
      border-radius: 6px;
      font-size: 14px;
    }

    button {
      margin-top: 30px;
      width: 100%;
      padding: 12px;
      font-size: 16px;
      background-color: #111;
      color: white;
      border: none;
      border-radius: 6px;
      cursor: pointer;
    }

    button:hover {
      background-color: #333;
    }
  </style>
</head>
<body>
  <div class="layout">
    <jsp:include page="adminSideBar.jsp" />
    <div class="container">
      <h2>환불 처리</h2>
      <form method="post" action="${pageContext.request.contextPath}/adminRefundProcess">
        <div class="row">
          <label class="label">주문 ID</label>
          <input type="text" name="orderId" value="${refund.orderId}" readonly />
        </div>

        <div class="row">
          <label class="label">환불 사유</label>
          <textarea name="reason" rows="4" readonly>${refund.reason}</textarea>
        </div>

        <div class="row">
          <label class="label">신청일</label>
          <input type="text" value="${refund.requestDate}" readonly />
        </div>

        <div class="row">
          <label class="label">환불 상태</label>
          <select name="status">
            <option value="대기" ${refund.status == '대기' ? 'selected' : ''}>대기</option>
            <option value="승인" ${refund.status == '승인' ? 'selected' : ''}>승인</option>
            <option value="거절" ${refund.status == '거절' ? 'selected' : ''}>거절</option>
          </select>
        </div>

        <input type="hidden" name="refundId" value="${refund.refundId}" />
        <button type="submit">환불 상태 변경</button>
      </form>
    </div>
  </div>
  <jsp:include page="../common/footer.jsp" />
</body>
</html>
