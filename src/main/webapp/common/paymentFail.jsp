<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="ko">
<head><meta charset="UTF-8"><title>결제 실패</title></head>
<body>
  <h2>결제에 실패했습니다</h2>
  <p>주문번호: <strong>${rawOrderId}</strong></p>
  <p>오류 코드: <strong>${code}</strong></p>
  <p>오류 메시지: <strong>${message}</strong></p>
  <p>죄송합니다. 다시 시도하거나 고객센터에 문의해주세요.</p>

  <button onclick="location.href='${pageContext.request.contextPath}/order?orderId=${rawOrderId}'">
    다시 결제하기
  </button>
  <button onclick="location.href='${pageContext.request.contextPath}/';">
    메인으로
  </button>
</body>
</html>
