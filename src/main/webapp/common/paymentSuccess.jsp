<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>결제 완료</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f9;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            flex-direction: column;
        }
        .container {
            background-color: white;
            padding: 40px;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            text-align: center;
            width: 80%;
            max-width: 500px;
        }
        h2 {
            color: #4CAF50;
            font-size: 24px;
            margin-bottom: 10px;
        }
        .celebration-icon {
            font-size: 80px; /* 🎉 이모지를 크게 */
            margin-bottom: 20px;
        }
        .emoji {
            font-size: 50px; /* 🎉 이모지 아래에 추가된 이모지 */
            margin-top: 10px;
        }
        p {
            font-size: 18px;
            margin: 10px 0;
        }
        .button-container {
    display: flex;
    justify-content: space-evenly; /* 버튼 간격을 고르게 분배 */
    margin-top: 20px;
    width: 100%;  /* 버튼 컨테이너가 전체 너비를 차지하도록 설정 */
}
        .button {
            background-color: #4CAF50;
            color: white;
            padding: 12px 20px;
            border: none;
            border-radius: 5px;
            font-size: 16px;
            text-decoration: none;
            width: auto;
            min-width: 120px;
            text-align: center;
        }
        .button:hover {
            background-color: #45a049;
        }
        .back-link {
            display: block;
            margin-top: 15px;
            font-size: 16px;
            text-decoration: none;
            color: #007BFF;
        }
        .back-link:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
	<jsp:include page="/header" />
    <div class="container">


        <h2>결제가 완료되었습니다</h2>

        <!-- 결제 완료 메시지 아래에 추가할 이모지 -->
        <span class="emoji">🎉</span>

        <p>주문번호: ${paymentInfo.orderId}</p>
        <p>결제금액: ${paymentInfo.totalAmount}원</p>
        <p>승인시간: ${paymentInfo.approvedAt}</p>

        <!-- 버튼을 양옆으로 배치 -->
        <div class="button-container">
            <a href="${pageContext.request.contextPath}/main" class="button">메인페이지로 돌아가기</a>
            <a href="${pageContext.request.contextPath}/myOrders" class="button">주문/배송 조회</a>
        </div>
    </div>
    	<jsp:include page="/footer" />
</body>
</html>
