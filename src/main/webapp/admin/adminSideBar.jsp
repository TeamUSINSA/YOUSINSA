<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<div class="sidebar">
  <h4>주문 및 환불/교환 처리</h4>
  <ul class="menu-section">
    <li class="menu-item"><a href="${pageContext.request.contextPath}/adminOrderSearch">주문조회</a></li>
    <li class="menu-item"><a href="${pageContext.request.contextPath}/adminreturn">반품 접수</a></li>
    <li class="menu-item"><a href="${pageContext.request.contextPath}/adminExchange">교환 접수</a></li>
  </ul>

  <h4>상품 관리</h4>
  <ul class="menu-section">
    <li class="menu-item"><a href="${pageContext.request.contextPath}/adminproductsearch">상품검색</a></li>
    <li class="menu-item"><a href="${pageContext.request.contextPath}/adminproductadd">상품 등록</a></li>
    <li class="menu-item"><a href="${pageContext.request.contextPath}/adminCategory">카테고리 관리</a></li>
    <li class="menu-item"><a href="${pageContext.request.contextPath}/adminbanner">배너사진 관리</a></li>
  </ul>

  <h4>회원/고객 관리</h4>
  <ul class="menu-section">
    <li class="menu-item"><a href="${pageContext.request.contextPath}/adminsearchmember">회원검색</a></li>
    <li class="menu-item"><a href="${pageContext.request.contextPath}/admininquiry">문의 창</a></li>
 
  </ul>

  <h4>마케팅 및 프로모션</h4>
  <ul class="menu-section">
    <li class="menu-item"><a href="${pageContext.request.contextPath}/admincouponlist">쿠폰 보기</a></li>
    <li class="menu-item"><a href="${pageContext.request.contextPath}/admincouponadd">쿠폰 등록</a></li>
  </ul>

  <h4>매출 분석</h4>
  <ul class="menu-section">
    <li class="menu-item"><a href="${pageContext.request.contextPath}/adminsales">매출 조회</a></li>
  </ul>
</div>