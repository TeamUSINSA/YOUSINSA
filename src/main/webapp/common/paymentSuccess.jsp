<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html><html lang="ko">
<head><meta charset="UTF-8"><title>결제 완료</title></head>
<body>
  <h2>결제가 완료되었습니다 🎉</h2>
  <p>주문번호: ${paymentInfo.orderId}</p>
  <p>결제금액: ${paymentInfo.totalAmount}원</p>
  <p>승인시간: ${paymentInfo.approvedAt}</p>
  <a href="${pageContext.request.contextPath}/">메인으로</a>
</body>
</html>
