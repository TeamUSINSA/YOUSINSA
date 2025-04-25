<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <!DOCTYPE html>
        <html lang="ko">

        <head>
            <meta charset="UTF-8" />
            <title>주문 상세</title>
            <style>
                * {
                    box-sizing: border-box;
                }

                body {
                    font-family: 'Segoe UI', 'Noto Sans KR', sans-serif;
                    background-color: #f4f6f8;
                    margin: 0;
                    padding: 40px 20px;
                    display: block;
                }

                .container {
                    width: 100%;
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

                label {
                    font-weight: bold;
                    display: inline-block;
                    margin-right: 10px;
                }

                table {
                    width: 100%;
                    border-collapse: collapse;
                    margin-top: 15px;
                    margin-bottom: 20px;
                    font-size: 14px;
                }

                th,
                td {
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

                .note {
                    text-align: center;
                    color: #777;
                    margin-bottom: 30px;
                }

                .total-box {
                    background-color: #fafafa;
                    padding: 20px;
                    font-size: 16px;
                    text-align: right;
                    border-radius: 8px;
                    font-weight: bold;
                    color: #e60000;
                }

                .payment-box th,
                .payment-box td {
                    text-align: center;
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
            <jsp:include page="adminSideBarStyle.jsp" />
        </head>

        <body>
        <jsp:include page="adminSideBar.jsp" />
            <div class="container">
                <h2>주문상세</h2>

                <table>
                    <tr>
                        <td><strong>주문일자:</strong> ${orderDate}</td>
                        <td><strong>주문번호:</strong> ${orderNumber}</td>
                        <td><strong>배송방법:</strong> ${deliveryType}</td>
                    </tr>
                </table>

                <h3>상품 정보</h3>
                <table>
                    <tr>
                        <th>상품</th>
                        <th>수량</th>
                        <th>주문금액</th>
                        <th>상태</th>
                    </tr>
                    <c:forEach var="item" items="${orderItems}">
                        <tr>
                            <td>
                                <img src="${item.image}" class="image-thumb" alt="상품 이미지" /><br>
                                ${item.name}<br>
                                색상: ${item.color}<br>
                                사이즈: ${item.size}s
                            </td>
                            <td>${item.quantity}</td>
                            <td>${item.price}원</td>
                            <td>${item.status}</td>
                        </tr>
                    </c:forEach>
                </table>

                <h3>주문자 정보</h3>
                <table>
                    <tr>
                        <th>주문자 이름</th>
                        <td>${ordererName}</td>
                    </tr>
                    <tr>
                        <th>연락처</th>
                        <td>${ordererPhone}</td>
                    </tr>
                    <tr>
                        <th>이메일</th>
                        <td>${ordererEmail}</td>
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

                <h3>배송 요청사항</h3>
                <input type="text" value="${shippingMemo}" readonly
                    style="width:100%; padding:10px; background-color:#fafafa; border:1px solid #ccc; border-radius:6px; margin-top:10px;">

                <h3>결제 정보</h3>
                <table class="payment-box">
                    <tr>
                        <th>주문금액</th>
                        <th>쿠폰할인금액</th>
                        <th>포인트결제</th>
                    </tr>
                    <tr>
                        <td>${totalAmount}원</td>
                        <td>${discountAmount}원</td>
                        <td>${pointAmount}원</td>
                    </tr>
                </table>

                <div class="total-box">
                    총 결제금액: ${finalAmount}원
                </div>

                <div class="buttons">
                    <button type="button" onclick="location.href='orderList.jsp'">목록으로</button>
                </div>
            </div>
        </body>

        </html>