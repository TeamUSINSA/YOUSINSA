<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/common/header.jsp" %>

<style>
  .status-box {
    border: 1px solid #ccc;
    border-radius: 8px;
    padding: 15px;
    display: flex;
    justify-content: space-around;
    margin-bottom: 30px;
    font-weight: bold;
    text-align: center;
  }
  .filter-box {
    border: 1px solid #ccc;
    border-radius: 8px;
    padding: 15px;
    margin-bottom: 20px;
  }
  .filter-header { font-weight: bold; margin-bottom: 10px; }
  .month-buttons { display: flex; gap: 10px; margin-bottom: 10px; }
  .date-selects { display: flex; gap: 8px; align-items: center; }
  .order-header {
    display: flex;
    font-weight: bold;
    padding: 12px 0;
    border-top: 2px solid #444;
    border-bottom: 1px solid #ccc;
    background-color: #f9f9f9;
    font-size: 14px;
  }
  .order-item {
    display: flex;
    gap: 10px;
    padding: 15px 0;
    border-bottom: 1px solid #eee;
    align-items: center;
    font-size: 14px;
  }
  .order-image {
    width: 60px;
    height: 60px;
    object-fit: cover;
    border: 1px solid #ccc;
    cursor: pointer;
  }
  .product-name {
    font-weight: bold;
    text-decoration: none;
    color: #333;
  }
  .product-name:hover { text-decoration: underline; }
  .action-btn {
    padding: 4px 8px;
    font-size: 12px;
    margin: 2px;
    border: 1px solid #aaa;
    background: #fff;
    border-radius: 4px;
    cursor: pointer;
  }
  .action-btn:hover { background: #f5f5f5; }
  .container {
  width: 100%;
  max-width: 900px;
  background-color: #ffffff;
  padding: 40px;
  border-radius: 12px;
  box-shadow: 0 8px 20px rgba(0, 0, 0, 0.05);
  margin: 0 auto; /* 중앙 정렬 */
}
</style>

<div class="container" style="display: flex; max-width: 1200px; margin: 0 auto; padding: 40px 20px; gap: 30px;">
  <div style="width: 200px;">
    <%@ include file="mysidebar.jsp" %>
  </div>

  <div style="flex: 1;">
    <h2 style="font-size: 20px; font-weight: bold; margin-bottom: 20px;">주문/배송 조회</h2>

    <div class="status-box">
      <div>${countReady}<br><span style="font-size: 13px;">배송준비중</span></div>
      <div>→</div>
      <div>${countShipping}<br><span style="font-size: 13px;">배송중</span></div>
      <div>→</div>
      <div>${countComplete}<br><span style="font-size: 13px;">배송완료</span></div>
    </div>

    <form method="get" action="order_list.jsp">
      <div class="filter-box">
        <div class="filter-header">구매 기간</div>
        <div class="month-buttons">
          <button name="range" value="1">1개월</button>
          <button name="range" value="3">3개월</button>
          <button name="range" value="6">6개월</button>
          <button name="range" value="12">12개월</button>
        </div>
        <div style="display: flex; justify-content: space-between; align-items: center;">
          <div class="date-selects">
            <select name="startYear"><option>2025</option></select>
            <select name="startMonth"><option>01</option></select>
            <select name="startDay"><option>01</option></select>
            ~
            <select name="endYear"><option>2025</option></select>
            <select name="endMonth"><option>12</option></select>
            <select name="endDay"><option>31</option></select>
          </div>
          <div>
            <button type="submit" style="background-color: #8cc63f; color: white; border: none; padding: 10px 25px;">조회</button>
          </div>
        </div>
      </div>
    </form>

    <!-- 주문 헤더 -->
    <div class="order-header">
      <div style="flex: 1;">주문일자</div>
      <div style="flex: 4;">상품</div>
      <div style="flex: 1; text-align: center;">수량</div>
      <div style="flex: 1; text-align: center;">주문금액</div>
      <div style="flex: 2; text-align: center;">상태</div>
    </div>

    <!-- 주문 목록 -->
    <c:forEach var="order" items="${orderList}">
      <c:forEach var="item" items="${order.items}">
        <div class="order-item">
          <div style="flex: 1;">
            <div>${order.date}</div>
            <a href="order_detail.jsp?no=${order.no}" style="font-size: 12px; text-decoration: underline;">주문상세</a>
          </div>
          <div style="flex: 4; display: flex; gap: 10px; align-items: center;">
            <a href="product_detail.jsp?no=${item.productNo}">
              <img src="${item.image}" class="order-image">
            </a>
            <div>
              <a href="product_detail.jsp?no=${item.productNo}" class="product-name">${item.name}</a><br>
              <span style="font-size: 12px; color: #666;">색상: ${item.color} / 사이즈: ${item.size}</span>
            </div>
          </div>
          <div style="flex: 1; text-align: center;">${item.quantity}</div>
          <div style="flex: 1; text-align: center;">${item.price}원</div>
          <div style="flex: 2; text-align: center;">
            ${item.status}<br>
            <c:choose>
              <c:when test="${item.status eq '배송중'}">
                <button class="action-btn" onclick="location.href='tracking.jsp?itemId=${item.id}'">배송 조회</button>
                <button class="action-btn" onclick="location.href='cancel.jsp?itemId=${item.id}'">취소 신청</button>
              </c:when>
              <c:when test="${item.status eq '배송완료'}">
                <button class="action-btn" onclick="location.href='exchange.jsp?itemId=${item.id}'">교환 신청</button>
                <button class="action-btn" onclick="location.href='return.jsp?itemId=${item.id}'">반품 신청</button>
              </c:when>
            </c:choose>
          </div>
        </div>
      </c:forEach>
    </c:forEach>

    <!-- 페이징 -->
    <div style="text-align: center; margin-top: 30px;">
      <c:forEach var="i" begin="1" end="${totalPages}">
        <c:choose>
          <c:when test="${i == currentPage}">
            <strong style="margin: 0 6px;">${i}</strong>
          </c:when>
          <c:otherwise>
            <a href="?page=${i}" style="margin: 0 6px;">${i}</a>
          </c:otherwise>
        </c:choose>
      </c:forEach>
    </div>
  </div>
</div>

<%@ include file="/common/footer.jsp" %>
