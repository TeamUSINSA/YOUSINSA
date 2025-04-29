<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:include page="/header" />

<div class="mypage-layout">
  <%@ include file="mysidebar.jsp" %>

  <div class="container">
    <h2 class="section-title">주문 취소</h2>

    <!-- 요약박스 -->
    <div class="summary-box">
      주문일자: <fmt:formatDate value="${order.orderDate}" pattern="yyyy-MM-dd"/>　
      주문번호: ${order.orderId}
    </div>

    <!-- 주문 정보 -->
    <div class="section-title">주문 정보</div>
    <table class="product-table">
      <thead>
        <tr>
          <th>상품</th>
          <th>수량</th>
          <th>주문금액</th>
          <th>상태</th>
        </tr>
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
            <td>${item.quantity * item.cost}원</td>
            <td>${order.deliveryStatus}</td>
          </tr>
        </c:forEach>
      </tbody>
    </table>

    <div class="divider-h"></div>

    <!-- 취소 사유 -->
    <div class="section-title">취소 사유</div>
    <form method="post" action="${pageContext.request.contextPath}/myCancelApply">
      <input type="hidden" name="orderId" value="${order.orderId}" />

      <div class="radio-group">
        <label class="radio-option">
          <input type="radio" name="reason" value="단순 변심"> 단순 변심
        </label>
        <label class="radio-option">
          <input type="radio" name="reason" value="결제 수단 변경"> 결제 수단 변경
        </label>
        <label class="radio-option">
          <input type="radio" name="reason" value="주문 실수"> 주문 실수
        </label>
        <label class="radio-option">
          <input type="radio" name="reason" value="기타"> 기타
          <input type="text" name="reasonEtc" placeholder="내용 입력" />
        </label>
      </div>

      <div class="divider-h"></div>

      <!-- 환불 예정 정보 -->
      <div class="section-title">환불 예정 정보</div>

      <%-- 쿠폰, 포인트 변수 세팅 --%>
      <c:set var="coupon" value="${order.couponDiscount != null ? order.couponDiscount : 0}" />
      <c:set var="point"  value="${order.usedPoint       != null ? order.usedPoint       : 0}" />

      <%-- 주문 전체 금액 계산 --%>
      <c:set var="orderAmt" value="0" />
      <c:forEach var="item" items="${order.items}">
        <c:set var="orderAmt"
               value="${orderAmt + (item.quantity * item.cost)}" />
      </c:forEach>

      <%-- 환불액 계산 --%>
      <c:set var="refund" value="${orderAmt - coupon - point}" />

      <table class="payment-table">
        <tr>
          <td>주문금액</td>
          <td style="color: #e60000;">${orderAmt}원</td>
          <td>쿠폰할인금액</td>
          <td style="color: #e60000;">-${coupon}원</td>
          <td>포인트결제</td>
          <td style="color: #e60000;">-${point}원</td>
        </tr>
        <tr class="total">
          <td colspan="6" style="text-align:right; font-weight:bold;">
            총 취소금액 ${refund}원
          </td>
        </tr>
      </table>

      <!-- 버튼 -->
      <div style="text-align:center; margin-top:40px;">
        <button type="submit" class="submit-btn">취소 신청</button>
        <a href="${pageContext.request.contextPath}/myOrders" class="back-btn">목록으로</a>
      </div>
    </form>

  </div>
</div>

<%@ include file="/common/footer.jsp" %>

<style>
  .mypage-layout { display:flex; gap:30px; max-width:1200px; margin:0 auto; }
  .summary-box { display:flex; gap:10px; margin-bottom:30px; }
  .summary-box span {
    background:#fff; padding:10px 18px; border:1px solid #ddd;
    border-radius:8px; font-size:14px;
  }
  .container {
    background:#fff; padding:40px; border-radius:12px;
    box-shadow:0 8px 20px rgba(0,0,0,0.05); width:100%;
  }
  .section-title {
    font-size:20px; font-weight:bold; margin:40px 0 20px;
    border-left:5px solid #8cc63f; padding-left:10px;
    color:#2c3e50;
  }
  .divider-h { border-top:1px solid #ddd; margin:40px 0; }
  .product-table, .payment-table {
    width:100%; border-collapse:collapse; margin-bottom:40px; font-size:15px;
  }
  .product-table th, .product-table td, .payment-table td {
    border:1px solid #e1e1e1; padding:14px 10px; background:#fff;
  }
  .product-table th { background:#f3f3f3; font-weight:600; }
  .product-info { display:flex; align-items:center; gap:12px; }
  .product-info img {
    width:60px; height:60px; object-fit:cover;
    border:1px solid #ccc; border-radius:4px;
  }
  .product-name { font-weight:bold; color:#2c3e50; text-decoration:none; }
  .product-name:hover { text-decoration:underline; }
  .radio-group {
    display:grid; grid-template-columns:repeat(2,1fr);
    gap:20px 32px; margin:20px 0 40px; max-width:600px;
  }
  .radio-option { display:flex; align-items:center; gap:10px; font-size:14px; }
  .radio-option input[type="text"] {
    flex:1; min-width:120px; padding:5px 8px; font-size:13px;
  }
  .payment-table .total td {
    font-size:20px; font-weight:bold; background:#fcfcfc;
    color:#e60000; text-align:right; padding-right:30px;
  }
  .submit-btn, .back-btn {
    display:inline-block; padding:10px 25px; margin:0 10px;
    background:#fff; border:1px solid #aaa; font-size:14px;
    color:#333; border-radius:4px; text-decoration:none; cursor:pointer;
  }
  .submit-btn:hover, .back-btn:hover { background:#f0f0f0; }
</style>
