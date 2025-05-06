<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="/header" />

<div class="mypage-layout">
  <%@ include file="mysidebar.jsp" %>

  <div class="container">
    <h2 class="section-title">반품 상세 정보</h2>

    <!-- 반품 요약 -->
    <div class="summary-box">
      <span>반품일자: <fmt:formatDate value="${ret.returnDate}" pattern="yyyy-MM-dd"/></span>
      <span>반품번호: ${ret.returnId}</span>
      <span>주문번호: ${order.orderId}</span>
    </div>

    <!-- 상품 정보 -->
    <div class="section-title">반품 상품 정보</div>
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
                  <a class="product-name"
                     href="${pageContext.request.contextPath}/productDetail?productId=${item.productId}">
                    ${item.name}
                  </a><br>
                  <span style="font-size:13px;color:#666;">
                    색상: ${item.color}, 사이즈: ${item.size}
                  </span>
                </div>
              </div>
            </td>
            <td>${item.quantity}</td>
            <td>${item.quantity * item.price}원</td>
            <td>반품처리중</td>
          </tr>
        </c:forEach>
      </tbody>
    </table>

    <!-- 반품 사유 -->
    <div class="section-title">반품 사유</div>
    <div class="memo-box">
      ${ret.reason}
    </div>

    <!-- 승인 상태 -->
    <div class="section-title">처리 상태</div>
    <div class="status-box">
      <c:choose>
        <c:when test="${ret.approved == 0}">처리 대기중</c:when>
        <c:when test="${ret.approved == 1}">반품 완료</c:when>
        <c:when test="${ret.approved == 2}">반려 사유: ${ret.rejectReason}</c:when>
      </c:choose>
    </div>

    <!-- 환불 예정 정보 -->
    <div class="section-title">환불 예정 정보</div>
    <c:set var="orderAmt" value="${order.totalPrice}" />
    <c:set var="coupon"   value="${order.couponDiscount != null ? order.couponDiscount : 0}" />
    <c:set var="point"    value="${order.usedPoint       != null ? order.usedPoint       : 0}" />
    <table class="payment-table">
      <tr>
        <td>주문금액</td><td style="color:#e60000;">${orderAmt}원</td>
        <td>쿠폰할인</td><td style="color:#e60000;">-${coupon}원</td>
        <td>포인트사용</td><td style="color:#e60000;">-${point}원</td>
      </tr>
      <tr class="total">
        <td colspan="6" style="text-align:right;font-weight:bold;">
          예상 환불금액 ${orderAmt - coupon - point}원
        </td>
      </tr>
    </table>

    <!-- 목록으로 -->
    <div style="text-align:center;margin-top:40px;">
      <a href="${pageContext.request.contextPath}/myCancelList" class="back-btn">목록으로</a>
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

  .product-table,
  .payment-table,
  .info-table {
    width: 100%;
    border-collapse: collapse;
    margin-bottom: 40px;
    font-size: 15px;
  }

  .product-table th,
  .product-table td,
  .payment-table td,
  .info-table td {
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

  .status-box {
    border: 1px solid #ccc;
    border-radius: 8px;
    padding: 15px;
    display: inline-block;
    font-size: 14px;
    font-weight: bold;
    text-align: center;
    margin-bottom: 40px;
  }

  .payment-table .total td {
    font-size: 20px;
    font-weight: bold;
    background: #f8f8f8;
    color: #e60000;
    text-align: right;
    padding-right: 30px;
  }

  .back-btn,
  .status-btn {
    display: inline-block;
    padding: 8px 20px;
    font-size: 14px;
    border: 1px solid #aaa;
    background-color: #fff;
    color: #333;
    border-radius: 4px;
    text-decoration: none;
    cursor: pointer;
    margin: 4px;
  }

  .back-btn:hover,
  .status-btn:hover {
    background: #f0f0f0;
    border-color: #888;
  }
</style>