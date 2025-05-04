<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8"/>
  <title>결제 실패</title>
  <style>
    body {
      margin: 0;
      padding: 0;
      font-family: 'Segoe UI', sans-serif;
      background: #f2f2f2;
      color: #333;
    }
    .container {
      max-width: 500px;
      margin: 80px auto;
      padding: 24px;
      background: #fff;
      border-radius: 8px;
      box-shadow: 0 2px 8px rgba(0,0,0,0.1);
      text-align: center;
    }
    h2 {
      font-size: 24px;
      color: #e53935;
      margin-bottom: 16px;
    }
    .info {
      margin: 16px 0;
      text-align: left;
    }
    .info p {
      margin: 8px 0;
      font-size: 16px;
    }
    .info p strong {
      color: #000;
    }
    .message {
      font-size: 14px;
      color: #666;
      margin-bottom: 24px;
    }
    .btn-group {
      margin-top: 24px;
    }
    .btn {
      display: inline-block;
      padding: 10px 20px;
      margin: 0 8px;
      border: none;
      border-radius: 4px;
      font-size: 16px;
      cursor: pointer;
      text-decoration: none;
      color: #fff;
    }
    .btn-retry {
      background: #1976d2;
    }
    .btn-retry:hover {
      background: #115293;
    }
    .btn-home {
      background: #757575;
    }
    .btn-home:hover {
      background: #5a5a5a;
    }
  </style>
</head>
<body>
  <jsp:include page="/header" />
  <%@ include file="scrollTop.jsp" %>
  <div class="container">
    <h2>결제에 실패했습니다</h2>
    <div class="info">
      <p>주문번호: <strong>${rawOrderId}</strong></p>
      <p>오류 코드: <strong>${code}</strong></p>
      <p>오류 메시지: <strong>${message}</strong></p>
    </div>
    <p class="message">죄송합니다. 다시 시도하거나 고객센터에 문의해주세요.</p>
    <div class="btn-group">
      <a href="${pageContext.request.contextPath}/cart"
         class="btn btn-retry">다시 결제하기</a>
      <a href="${pageContext.request.contextPath}/main"
         class="btn btn-home">메인으로</a>
    </div>
  </div>
<jsp:include page="footer.jsp"/>
</body>
</html>
