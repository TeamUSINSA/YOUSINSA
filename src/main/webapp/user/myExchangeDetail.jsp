<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="/header" />

<style>
  .mypage-layout { display:flex; gap:30px; max-width:1200px; margin:40px auto; }
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
  <!-- 사이드바 -->
  <div style="width:200px; flex-shrink:0;">
    <%@ include file="mysidebar.jsp" %>
  </div>

  <!-- 메인 컨테이너 -->
  <div class="container">
    <h2 style="font-size:24px; font-weight:bold; color:#2c3e50; margin-bottom:20px;">
      교환 상세
    </h2>

    <!-- 교환 요약 -->
    <div class="summary-box">
      <span>교환일자: 
        <fmt:formatDate value="${exchange.exchangeDate}" pattern="yyyy-MM-dd"/>
      </span>
      <span>교환번호: ${exchange.exchangeId}</span>
    </div>

    <!-- 상품 정보 -->
    <div class="section-title">상품 정보</div>
    <table class="product-table">
      <thead>
        <tr>
          <th>상품</th><th>수량</th><th>단가</th><th>합계금액</th>
        </tr>
      </thead>
      <tbody>
        <tr>
          <td>
            <div class="product-info">
              <a href="${pageContext.request.contextPath}/productDetail?productId=${product.productId}">
                <img src="${pageContext.request.contextPath}/image/${product.mainImage1}" alt="상품이미지"/>
              </a>
              <div>
                <a class="product-name"
                   href="${pageContext.request.contextPath}/productDetail?productId=${product.productId}">
                  ${product.name}
                </a><br/>
                <span style="font-size:13px;color:#666;">
                  색상: ${product.color} / 사이즈: ${product.size}
                </span>
              </div>
            </div>
          </td>
          <td>${product.quantity}</td>
          <td>
            <fmt:formatNumber value="${product.price - product.discount}" pattern="#,###"/>원
          </td>
          <td>
            <fmt:formatNumber
              value="${(product.price - product.discount) * product.quantity}" pattern="#,###"/>원
          </td>
        </tr>
      </tbody>
    </table>

    <!-- 교환 정보 -->
    <div class="section-title">교환 정보</div>
    <table class="info-table">
      <tr>
        <th>교환 사유</th>
        <td>${exchange.reason}</td>
      </tr>
      <tr>
        <th>교환 옵션</th>
        <td>
          <c:choose>
            <c:when test="${not empty exchange.size}">사이즈 → ${exchange.size}</c:when>
            <c:when test="${not empty exchange.color}">색상 → ${exchange.color}</c:when>
            <c:otherwise>–</c:otherwise>
          </c:choose>
        </td>
      </tr>
      <tr>
        <th>처리 상태</th>
        <td>
          <c:choose>
            <c:when test="${exchange.approved == 0}">대기중</c:when>
            <c:when test="${exchange.approved == 1}">승인</c:when>
            <c:when test="${exchange.approved == 2}">반려</c:when>
          </c:choose>
        </td>
      </tr>
      <c:if test="${exchange.approved == 2}">
        <tr>
          <th>반려 사유</th>
          <td>${exchange.rejectReason}</td>
        </tr>
      </c:if>
    </table>

    <!-- 배송지 정보 -->
    <div class="section-title">배송지 정보</div>
    <table class="info-table">
      <tr><th>받는 분</th><td>${user.name}</td></tr>
      <tr><th>연락처</th><td>${user.phone}</td></tr>
      <tr><th>주소</th><td>${user.address1}</td></tr>
    </table>

    <!-- 버튼 -->
    <div style="text-align:center; margin-top:30px;">
      <a href="${pageContext.request.contextPath}/myExchangeList" class="back-btn">목록으로</a>
    </div>
  </div>
</div>

<jsp:include page="/common/footer.jsp" />
