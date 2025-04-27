<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn"  uri="http://java.sun.com/jsp/jstl/functions" %>
<% 
  response.setHeader("Cache-Control","no-cache, no-store, must-revalidate");
  response.setHeader("Pragma","no-cache");
  response.setDateHeader("Expires", 0);

  int currentYear = java.util.Calendar.getInstance()
                      .get(java.util.Calendar.YEAR);
  request.setAttribute("currentYear", currentYear);
%>

<%@ include file="/common/header.jsp" %>

<style>
  .filter-box {
    border: 1px solid #ccc;
    border-radius: 10px;
    padding: 20px;
    margin-bottom: 30px;
    background-color: #fafafa;
  }
  .month-buttons {
    display: flex;
    gap: 10px;
    margin-bottom: 15px;
  }
  .month-buttons input[type="button"] {
    padding: 8px 16px;
    border: 1px solid #ccc;
    background-color: white;
    border-radius: 6px;
    font-size: 14px;
    cursor: pointer;
  }
  .month-buttons input[type="button"]:hover,
  .month-buttons input[type="button"].active {
    background-color: #8cc63f;
    color: white;
  }
  .date-selects {
    display: flex;
    align-items: center;
    gap: 8px;
  }
  .date-selects select {
    padding: 6px;
    border-radius: 5px;
    border: 1px solid #ccc;
    font-size: 14px;
  }
  .order-header {
    display: flex;
    font-weight: bold;
    background-color: #f9f9f9;
    border-top: 2px solid #444;
    border-bottom: 1px solid #ccc;
    font-size: 14px;
    padding: 12px 0;
  }
  .order-header > div { text-align: center; }
  .order-header .meta    { width: 160px; }
  .order-header .product { flex: 4; text-align: left; padding-left:20px; }
  .order-header .quantity,
  .order-header .price,
  .order-header .status  { flex: 1; }
  .order-group {
    display: flex;
    border-bottom: 2px solid #ccc;
  }
  .order-meta {
    width: 160px;
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: center;
    text-align: center;
    font-size: 13px;
    padding: 10px;
    border-right: 1px solid #eee;
    line-height: 1.8;
  }
  .order-items {
    flex: 1;
  }
  .order-item {
    display: flex;
    padding: 20px;
    align-items: center;
    border-top: 1px solid #eee;
  }
  .order-item:first-of-type { border-top: none; }
  .product-info {
    flex: 4;
    display: flex;
    align-items: center;
    gap: 10px;
  }
  .product-name {
    font-weight: bold;
    text-decoration: none;
    color: #333;
  }
  .product-name:hover { text-decoration: underline; }
  .order-image {
    width: 60px; height: 60px;
    object-fit: cover;
    border: 1px solid #ccc;
  }
  .quantity, .price, .status { flex: 1; text-align: center; }
  .detail-btn {
    padding: 4px 10px; font-size:12px; margin-top:6px;
    border:1px solid #8cc63f; background:#fff; color:#8cc63f;
    border-radius:4px; cursor:pointer; text-decoration:none;
    transition:0.2s;
  }
  .detail-btn:hover { background:#8cc63f; color:#fff; }
</style>

<div style="max-width:1200px; margin:0 auto; display:flex;">
  <!-- 사이드바 -->
  <div style="width:200px; flex-shrink:0;">
    <%@ include file="mysidebar.jsp" %>
  </div>

  <!-- 본문 -->
  <div style="flex:1; padding:40px 20px;">
    <h2 style="font-size:20px; font-weight:bold; margin-bottom:20px;">
      취소/반품 내역
    </h2>
    <p style="font-size:13px; color:#666;">
      귀하께서 취소 또는 반품하신 내역의 상품들입니다.
    </p>

    <!-- 필터 -->
    <form method="get" action="${pageContext.request.contextPath}/myCancelList"
          id="dateForm">
      <div class="filter-box">
        <div class="month-buttons">
          <input type="button" value="1개월"  onclick="setDateRangeAndSubmit(1)">
          <input type="button" value="3개월"  onclick="setDateRangeAndSubmit(3)">
          <input type="button" value="6개월"  onclick="setDateRangeAndSubmit(6)">
          <input type="button" value="12개월" onclick="setDateRangeAndSubmit(12)">
        </div>
        <div class="date-selects">
          <select name="startYear">
            <c:forEach var="y" begin="${currentYear-5}" end="${currentYear}">
              <option value="${y}"
                <c:if test="${fn:startsWith(startDate, y)}">selected</c:if>>
                ${y}년
              </option>
            </c:forEach>
          </select>
          <select name="startMonth">
            <c:forEach var="m" begin="1" end="12">
              <fmt:formatNumber var="mm" value="${m}" pattern="00"/>
              <option value="${mm}"
                <c:if test="${fn:substring(startDate,5,7)==mm}">selected</c:if>>
                ${m}월
              </option>
            </c:forEach>
          </select>
          <select name="startDay">
            <c:forEach var="d" begin="1" end="31">
              <fmt:formatNumber var="dd" value="${d}" pattern="00"/>
              <option value="${dd}"
                <c:if test="${fn:substring(startDate,8,10)==dd}">selected</c:if>>
                ${d}일
              </option>
            </c:forEach>
          </select>
          ~
          <select name="endYear">
            <c:forEach var="y" begin="${currentYear-5}" end="${currentYear}">
              <option value="${y}"
                <c:if test="${fn:startsWith(endDate, y)}">selected</c:if>>
                ${y}년
              </option>
            </c:forEach>
          </select>
          <select name="endMonth">
            <c:forEach var="m" begin="1" end="12">
              <fmt:formatNumber var="mm" value="${m}" pattern="00"/>
              <option value="${mm}"
                <c:if test="${fn:substring(endDate,5,7)==mm}">selected</c:if>>
                ${m}월
              </option>
            </c:forEach>
          </select>
          <select name="endDay">
            <c:forEach var="d" begin="1" end="31">
              <fmt:formatNumber var="dd" value="${d}" pattern="00"/>
              <option value="${dd}"
                <c:if test="${fn:substring(endDate,8,10)==dd}">selected</c:if>>
                ${d}일
              </option>
            </c:forEach>
          </select>
          <button type="submit"
                  style="margin-left:10px;background:#8cc63f;color:#fff;
                         border:none;padding:8px 18px;border-radius:5px;">
            조회
          </button>
        </div>
      </div>
    </form>

    <!-- 테이블 헤더 -->
    <div class="order-header">
      <div class="meta">주문일자</div>
      <div class="product">상품</div>
      <div class="quantity">수량</div>
      <div class="price">주문금액</div>
      <div class="status">상태</div>
    </div>

    <!-- 리스트: cancelList 로 변경 -->
    <c:forEach var="cr" items="${cancelList}">
      <div class="order-group">
        <!-- 메타 -->
        <div class="order-meta">
          <div><fmt:formatDate value="${cr.orderDate}" pattern="yyyy-MM-dd"/></div>
          <div><strong>${cr.orderId}</strong></div>
          <c:choose>
            <c:when test="${cr.orderItemId == null}">
              <a href="${pageContext.request.contextPath}/order/cancelDetail?orderId=${cr.orderId}"
                 class="detail-btn">취소 상세</a>
            </c:when>
            <c:otherwise>
              <a href="${pageContext.request.contextPath}/order/returnDetail?itemId=${cr.orderItemId}"
                 class="detail-btn">반품 상세</a>
            </c:otherwise>
          </c:choose>
        </div>
        <!-- 아이템 -->
        <div class="order-items">
          <div class="order-item">
            <div class="product-info">
              <a href="${pageContext.request.contextPath}/productDetail?productId=${cr.productId}">
                <img src="${pageContext.request.contextPath}/images/${cr.mainImage1}"
                     class="order-image"/>
              </a>
              <div>
                <a href="${pageContext.request.contextPath}/productDetail?productId=${cr.productId}"
                   class="product-name">${cr.name}</a><br>
                <span style="font-size:12px;color:#666;">
                  색상: ${cr.color} / 사이즈: ${cr.size}
                </span>
              </div>
            </div>
            <div class="quantity">${cr.quantity}</div>
            <div class="price">
              <fmt:formatNumber value="${cr.price}" pattern="#,###"/>원
            </div>
            <div class="status">
              ${cr.status}<br>
              <small>
                <fmt:formatDate value="${cr.actionDate}" pattern="yyyy-MM-dd"/>
              </small>
            </div>
          </div>
        </div>
      </div>
    </c:forEach>

  </div>
</div>

<script>
  function setDateRangeAndSubmit(monthsAgo) {
    const today = new Date(),
          start = new Date();
    start.setMonth(start.getMonth() - monthsAgo);
    const pad = n => String(n).padStart(2,'0');
    document.querySelector('select[name="startYear"]').value  = start.getFullYear();
    document.querySelector('select[name="startMonth"]').value = pad(start.getMonth()+1);
    document.querySelector('select[name="startDay"]').value   = pad(start.getDate());
    document.querySelector('select[name="endYear"]').value    = today.getFullYear();
    document.querySelector('select[name="endMonth"]').value   = pad(today.getMonth()+1);
    document.querySelector('select[name="endDay"]').value     = pad(today.getDate());
    document.getElementById('dateForm').submit();
  }
</script>

<%@ include file="/common/footer.jsp" %>
