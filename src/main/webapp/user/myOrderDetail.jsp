<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/header" />

<div class="mypage-layout">
  <%@ include file="mysidebar.jsp" %>

  <div class="container">
    <h2 style="font-size: 28px; font-weight: bold; margin-bottom: 30px; text-align: left; color: #2c3e50;">주문 상세 정보</h2>

    <!-- 주문 요약 -->
    <div class="summary-box">
      <span>주문일자 : ${order.orderDate}</span>
      <span>주문번호 : ${order.orderId}</span>
    </div>

    <!-- 상품 정보 -->
    <div class="section-title">주문 상품 정보</div>
    <table class="product-table">
      <thead>
        <tr><th>상품</th><th>수량</th><th>주문금액</th><th>상태</th></tr>
      </thead>
      <tbody>
        <c:forEach var="item" items="${order.items}">
          <tr>
            <td>
              <div class="product-info">
                <a href="${pageContext.request.contextPath}/productDetail?productId=${item.productId}">
                  <img src="/yousinsa/image/${item.mainImage1}" alt="상품이미지">
                </a>
                <div>
                  <a class="product-name" href="${pageContext.request.contextPath}/productDetail?productId=${item.productId}">${item.name}</a><br>
                  <span style="font-size: 13px; color: #666;">색상: ${item.color}, 사이즈: ${item.size}</span>
                </div>
              </div>
            </td>
            <td>${item.quantity}</td>
            <td>${item.quantity * item.price}원</td>
            <td>
              ${item.status}<br>
              <c:choose>
                <c:when test="${item.status eq '배송준비중'}">
                  <button class="status-btn" onclick="location.href='cancel.jsp?itemId=${item.orderItemId}'">주문 취소</button>
                </c:when>
                <c:when test="${item.status eq '배송중'}">
                  <button class="status-btn" onclick="location.href='tracking.jsp?itemId=${item.orderItemId}'">배송 조회</button>
                  <button class="status-btn" onclick="location.href='cancel.jsp?itemId=${item.orderItemId}'">취소 요청</button>
                </c:when>
                <c:when test="${item.status eq '배송완료'}">
                  <button class="status-btn" onclick="location.href='exchange.jsp?itemId=${item.orderItemId}'">교환 신청</button>
                  <button class="status-btn" onclick="location.href='return.jsp?itemId=${item.orderItemId}'">반품 신청</button>
                </c:when>
              </c:choose>
            </td>
          </tr>
        </c:forEach>
      </tbody>
    </table>

    <!-- 배송지 정보 -->
    <div class="section-title">배송지 정보</div>
    <table class="info-table">
      <tr><td>받는 분</td><td>${order.receiverName}</td></tr>
      <tr><td>연락처</td><td>${order.receiverPhone}</td></tr>
      <tr><td>주소</td><td>${order.receiverAddress}</td></tr>
    </table>

    <!-- 요청 사항 -->
    <div class="section-title">배송 요청사항</div>
    <div class="memo-box">${order.deliveryRequest}</div>

    <!-- 결제 정보 -->
    <div class="section-title">결제 정보</div>
    <div style="margin-bottom: 10px; font-size: 15px;">
      <strong>결제 수단:</strong> ${order.paymentMethod}
    </div>
    <table class="payment-table">
      <tr>
        <td>주문금액</td>
        <td style="color: #e60000;">${order.totalPrice}원</td>
        <td>쿠폰할인</td>
        <td style="color: #e60000;">-${order.couponDiscount != null ? order.couponDiscount : 0}원</td>
        <td>포인트 사용</td>
        <td style="color: #e60000;">-${order.usedPoint != null ? order.usedPoint : 0}원</td>
      </tr>
      <tr class="total">
        <td colspan="6" style="text-align: center;">총 결제금액 ${order.totalPrice 
        - (order.couponDiscount != null ? order.couponDiscount : 0) 
        - (order.usedPoint != null ? order.usedPoint : 0)}원</td>
      </tr>
    </table>

    <!-- 목록으로 -->
    <div style="text-align: center; margin-top: 40px;">
      <a href="${pageContext.request.contextPath}/myOrders" class="back-btn">목록으로</a>
    </div>
  </div>
</div>

<%@ include file="/common/footer.jsp" %>

<style>
  .mypage-layout {
    display: flex;
    align-items: flex-start;
    gap: 30px;
    max-width: 1200px;
    margin: 0 auto;
  }

  .summary-box {
    display: flex;
    gap: 10px;
    margin-bottom: 30px;
  }
  .summary-box span {
    background: #fefefe;
    padding: 10px 18px;
    border-radius: 8px;
    border: 1px solid #ccc;
    font-size: 14px;
  }

  .container {
    width: 100%;
    background-color: #ffffff;
    padding: 40px;
    border-radius: 12px;
    box-shadow: 0 8px 20px rgba(0, 0, 0, 0.05);
  }

  .section-title {
    font-size: 22px;
    font-weight: bold;
    margin: 40px 0 20px;
    text-align: left;
    color: #2c3e50;
    border-left: 5px solid #8cc63f;
    padding-left: 10px;
  }

  .product-table, .payment-table, .info-table {
    width: 100%;
    border-collapse: collapse;
    margin-bottom: 40px;
  }

  .product-table th, .product-table td,
  .payment-table td, .info-table td {
    border: 1px solid #e1e1e1;
    padding: 14px 10px;
    background-color: #fff;
  }

  .product-table th {
    background-color: #f3f3f3;
    font-weight: 600;
  }

  .product-info {
    display: flex;
    align-items: center;
    gap: 12px;
  }

  .product-info img {
    width: 60px;
    height: 60px;
    object-fit: cover;
    border: 1px solid #ccc;
    border-radius: 4px;
  }

  .product-name {
    font-weight: bold;
    color: #2c3e50;
    text-decoration: none;
  }

  .product-name:hover {
    text-decoration: underline;
  }

  .memo-box {
    background: #f9f9f9;
    border: 1px solid #ddd;
    padding: 16px;
    font-size: 14px;
    border-radius: 6px;
    max-width: 700px;
  }

  .payment-table .total td {
    font-size: 20px;
    font-weight: bold;
    background: #f8f8f8;
    color: #e60000;
  }

  .status-btn {
    padding: 6px 12px;
    font-size: 13px;
    margin-top: 6px;
    margin-right: 4px;
    background-color: #fff;
    border: 1px solid #aaa;
    border-radius: 4px;
    cursor: pointer;
  }

  .status-btn:hover {
    background: #f0f0f0;
  }

  .back-btn {
    display: inline-block;
    padding: 8px 20px;
    font-size: 14px;
    border: 1px solid #aaa;
    background-color: #fff;
    color: #333;
    border-radius: 4px;
    text-decoration: none;
  }

  .back-btn:hover {
    background-color: #f0f0f0;
    border-color: #888;
  }
</style>
