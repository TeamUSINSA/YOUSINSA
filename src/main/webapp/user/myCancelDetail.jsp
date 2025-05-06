<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="/header" />

<style>
  .mypage-layout { display:flex; gap:30px; max-width:1200px; margin:0 auto; }
  .container {
    background:#fff; padding:40px; border-radius:12px;
    box-shadow:0 8px 20px rgba(0,0,0,0.05); width:100%;
  }
  .section-title {
    font-size:20px; font-weight:bold; margin:40px 0 20px;
    border-left:5px solid #8cc63f; padding-left:10px; color:#2c3e50;
  }
  .summary-box span {
    display:inline-block; background:#fefefe; padding:10px 18px;
    border:1px solid #ddd; border-radius:8px; font-size:14px; margin-right:10px;
  }
  .info-table, .product-table {
    width:100%; border-collapse:collapse; margin-bottom:40px;
  }
  .info-table th, .info-table td,
  .product-table th, .product-table td {
    border:1px solid #e1e1e1; padding:14px; background:#fff;
  }
  .info-table th { width:150px; background:#f3f3f3; text-align:left; }
  .product-table th { background:#f3f3f3; font-weight:600; }
  .product-info { display:flex; align-items:center; gap:12px; }
  .product-info img {
    width:60px; height:60px; object-fit:cover; border:1px solid #ccc; border-radius:4px;
  }
  .product-name { font-weight:bold; color:#2c3e50; text-decoration:none; }
  .product-name:hover { text-decoration:underline; }
  .back-btn {
    display:inline-block; padding:10px 25px; margin:0 auto; border:1px solid #aaa;
    border-radius:4px; background:#fff; color:#333; text-decoration:none; cursor:pointer;
  }
  .back-btn:hover { background:#f0f0f0; }
</style>

<div class="mypage-layout">
  <div style="width:200px; flex-shrink:0;">
    <%@ include file="mysidebar.jsp" %>
  </div>
  <div class="container">
    <h2 style="font-size:24px; font-weight:bold; color:#2c3e50; margin-bottom:20px;">
      취소 상세
    </h2>

    <!-- 주문 요약 -->
    <div class="summary-box">
      <span>주문일자: 
        <fmt:formatDate value="${cancel.order.orderDate}" pattern="yyyy-MM-dd"/>
      </span>
      <span>주문번호: ${cancel.order.orderId}</span>
    </div>
    
<!-- 상품 정보 -->
    <div class="section-title">상품 정보</div>
    <table class="product-table">
      <thead>
        <tr>
          <th>상품</th>
          <th>수량</th>
          <th>상품단가</th>
          <th>합계금액</th>
        </tr>
      </thead>
      <tbody>
        <c:forEach var="item" items="${cancel.orderItems}">
          <tr>
            <td>
              <div class="product-info">
                <a href="${pageContext.request.contextPath}/productDetail?productId=${item.productId}">
                  <img src="${pageContext.request.contextPath}/image/${item.mainImage1}" alt="상품이미지"/>
                </a>
                <div>
                  <a class="product-name"
                     href="${pageContext.request.contextPath}/productDetail?productId=${item.productId}">
                    ${item.name}
                  </a><br/>
                  <span style="font-size:13px; color:#666;">
                    색상: ${item.color} / 사이즈: ${item.size}
                  </span>
                </div>
              </div>
            </td>
            <td>${item.quantity}</td>
            <td>
              <fmt:formatNumber value="${item.price - item.discount}" pattern="#,###"/>원
            </td>
            <td>
              <fmt:formatNumber
                value="${(item.price - item.discount) * item.quantity}" pattern="#,###"/>원
            </td>
          </tr>
        </c:forEach>
      </tbody>
    </table>
    
    <!-- 취소 정보 -->
    <div class="section-title">취소 정보</div>
    <table class="info-table">
      <tr>
        <th>취소일자</th>
        <td>
          <fmt:formatDate value="${cancel.cancelDate}" pattern="yyyy-MM-dd"/>
        </td>
      </tr>
      <tr>
        <th>취소 사유</th>
        <td>${cancel.reason}</td>
      </tr>
      <tr>
    <th>완료 일시</th>
    <td>
      <fmt:formatDate
        value="${cancel.cancelDate}"
        pattern="yyyy-MM-dd"/>
    </td>
  </tr>
    </table>

<!-- 환불 정보 -->
<div class="section-title">환불 정보</div>
<table class="info-table">
  <tr>
    <th>주문금액</th>
    <c:forEach var="item" items="${cancel.orderItems}">
    <td style="color:red;">
      <fmt:formatNumber 
        value="${(item.price - item.discount) * item.quantity}" 
        pattern="#,###"/>원
    </td>
    </c:forEach>
  </tr>
  <tr>
    <th>쿠폰할인금액</th>
    <td style="color:red;">
      -<fmt:formatNumber 
         value="${cancel.order.couponDiscount}" 
         pattern="#,###"/>원
    </td>
  </tr>
  <tr>
    <th>포인트결제</th>
    <td style="color:red;">
      <fmt:formatNumber 
        value="${cancel.order.usedPoint}" 
        pattern="#,###"/>원
    </td>
  </tr>
  <tr>
    <th>총 취소금액</th>
    <c:forEach var="item" items="${cancel.orderItems}">
    <td style="font-weight:bold;">
      <fmt:formatNumber
        value="${(item.price - item.discount) * item.quantity
                 - cancel.order.couponDiscount 
                 - cancel.order.usedPoint}"
        pattern="#,###"/>원
    </td>
  </c:forEach>
  </tr>
</table>
    

    <!-- 목록 버튼 -->
    <div style="text-align:center; margin-top:30px;">
      <a href="${pageContext.request.contextPath}/myCancelList" class="back-btn">
        목록으로
      </a>
    </div>
  </div>
</div>

<%@ include file="/common/footer.jsp" %>
