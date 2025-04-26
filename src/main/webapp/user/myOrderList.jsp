<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<% 
  response.setHeader("Cache-Control","no-cache, no-store, must-revalidate");
  response.setHeader("Pragma","no-cache");
  response.setDateHeader("Expires", 0);
%>
<%
int currentYear = java.util.Calendar.getInstance().get(java.util.Calendar.YEAR);
request.setAttribute("currentYear", currentYear);
%>

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

  .month-buttons input[type="button"]:hover {
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

  .order-header > div {
    text-align: center;
  }

 .order-header .meta    { width: 160px; text-align: center; }
.order-header .product { flex: 4; text-align: left; padding-left: 20px; }
.order-header .quantity,
.order-header .price,
.order-header .status  { flex: 1; text-align: center; }

  .order-group {
    display: flex;
    border-bottom: 2px solid #ccc;
  }

  .order-meta {
  width: 160px;
  display: flex;
  flex-direction: column;  /* 세로 정렬 */
  justify-content: center; /* 전체 중앙 정렬 */
  align-items: center;     /* 텍스트 가운데 정렬 */
  text-align: center;
  font-size: 13px;
  padding: 10px;
  border-right: 1px solid #eee;
  line-height: 1.8; /* 줄 간격 */
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

  .order-item:first-of-type {
    border-top: none;
  }

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
    width: 60px;
    height: 60px;
    object-fit: cover;
    border: 1px solid #ccc;
  }

  .quantity, .price, .status {
    flex: 1;
    text-align: center;
  }

  .action-btn {
    padding: 4px 8px;
    font-size: 12px;
    margin: 2px;
    border: 1px solid #aaa;
    background: #fff;
    border-radius: 4px;
    cursor: pointer;
  }

  .action-btn:hover {
    background-color: #f5f5f5;
  }
  .detail-btn {
  padding: 4px 10px;
  font-size: 12px;
  margin-top: 6px;
  border: 1px solid #8cc63f;
  background-color: white;
  border-radius: 4px;
  color: #8cc63f;
  cursor: pointer;
  text-decoration: none;
  display: inline-block;
  transition: 0.2s ease-in-out;
}

.detail-btn:hover {
  background-color: #8cc63f;
  color: white;
}
</style>

<div style="max-width: 1200px; margin: 0 auto; display: flex;">
  <!-- 사이드바 영역 -->
  <div style="width: 200px; flex-shrink: 0;">
    <%@ include file="mysidebar.jsp" %>
  </div>
<div style="flex: 1; padding: 40px 20px;">
  <h2 style="font-size: 20px; font-weight: bold; margin-bottom: 20px;">주문/배송 조회</h2>

  <div class="status-box">
    <div>${countReady}<br><span style="font-size: 13px;">배송준비중</span></div>
    <div>→</div>
    <div>${countShipping}<br><span style="font-size: 13px;">배송중</span></div>
    <div>→</div>
    <div>${countComplete}<br><span style="font-size: 13px;">배송완료</span></div>
  </div>

  <form method="get" action="${pageContext.request.contextPath}/myOrders" id="dateForm">
    <div class="filter-box">
      <div class="month-buttons">
        <input type="button" value="1개월" onclick="setDateRangeAndSubmit(1)">
        <input type="button" value="3개월" onclick="setDateRangeAndSubmit(3)">
        <input type="button" value="6개월" onclick="setDateRangeAndSubmit(6)">
        <input type="button" value="12개월" onclick="setDateRangeAndSubmit(12)">
      </div>
      <div class="date-selects">
        <!-- start date -->
        <select name="startYear">
          <c:forEach var="y" begin="${currentYear - 5}" end="${currentYear}">
            <option value="${y}" <c:if test="${fn:startsWith(startDate, y)}">selected</c:if>>${y}년</option>
          </c:forEach>
        </select>
        <select name="startMonth">
          <c:forEach var="m" begin="1" end="12">
            <fmt:formatNumber var="mm" value="${m}" pattern="00"/>
            <option value="${mm}" <c:if test="${fn:substring(startDate, 5, 7) eq mm}">selected</c:if>>${m}월</option>
          </c:forEach>
        </select>
        <select name="startDay">
          <c:forEach var="d" begin="1" end="31">
            <fmt:formatNumber var="dd" value="${d}" pattern="00"/>
            <option value="${dd}" <c:if test="${fn:substring(startDate, 8, 10) eq dd}">selected</c:if>>${d}일</option>
          </c:forEach>
        </select>
        ~
        <!-- end date -->
        <select name="endYear">
          <c:forEach var="y" begin="${currentYear - 5}" end="${currentYear}">
            <option value="${y}" <c:if test="${fn:startsWith(endDate, y)}">selected</c:if>>${y}년</option>
          </c:forEach>
        </select>
        <select name="endMonth">
          <c:forEach var="m" begin="1" end="12">
            <fmt:formatNumber var="mm" value="${m}" pattern="00"/>
            <option value="${mm}" <c:if test="${fn:substring(endDate, 5, 7) eq mm}">selected</c:if>>${m}월</option>
          </c:forEach>
        </select>
        <select name="endDay">
          <c:forEach var="d" begin="1" end="31">
            <fmt:formatNumber var="dd" value="${d}" pattern="00"/>
            <option value="${dd}" <c:if test="${fn:substring(endDate, 8, 10) eq dd}">selected</c:if>>${d}일</option>
          </c:forEach>
        </select>
        <button type="submit" style="margin-left: 10px; background-color: #8cc63f; color: white; border: none; padding: 8px 18px;">조회</button>
      </div>
    </div>
  </form>

  <!-- 헤더 -->
  <div class="order-header">
    <div class="meta">주문일자</div>
    <div class="product">상품</div>
    <div class="quantity">수량</div>
    <div class="price">주문금액</div>
    <div class="status">상태</div>
  </div>

  <!-- 주문 리스트 -->
  <c:forEach var="order" items="${orderList}">
    <div class="order-group">
      <div class="order-meta">
        <div>${order.orderDate}</div>
  <div><strong>${order.orderId}</strong></div>
  <a href="myOrderDetail?no=${order.orderId}" class="detail-btn">주문상세</a>
      </div>
      <div class="order-items">
        <c:forEach var="item" items="${order.items}">
          <div class="order-item">
            <div class="product-info">
              <a href="${pageContext.request.contextPath}/productDetail?productId=${item.productId}">
                <img src="/yousinsa/image/${item.mainImage1}" class="order-image">
              </a>
              <div>
                <a href="${pageContext.request.contextPath}/productDetail?productId=${item.productId}" class="product-name">${item.name}</a><br>
                <span style="font-size: 12px; color: #666;">색상: ${item.color} / 사이즈: ${item.size}</span>
              </div>
            </div>
            <div class="quantity">${item.quantity}</div>
            <div class="price">${item.quantity * item.price}원</div>
            <div class="status">
              ${order.deliveryStatus}<br>
              <c:choose>
                <c:when test="${order.deliveryStatus eq '배송준비중'}">
                  <button class="action-btn" onclick="location.href='cancel.jsp?itemId=${item.orderItemId}'">취소 신청</button>
                </c:when>
                <c:when test="${order.deliveryStatus eq '배송중'}">
                  <button class="action-btn" onclick="location.href='tracking.jsp?itemId=${item.orderItemId}'">배송 조회</button>
                  <button class="action-btn" onclick="location.href='cancel.jsp?itemId=${item.orderItemId}'">취소 신청</button>
                </c:when>
                <c:when test="${order.deliveryStatus eq '배송완료'}">
                  <c:choose>
				    <%-- 아직 리뷰가 없으면 → 리뷰 작성으로 --%>
				    <c:when test="${!item.hasReview}">
				      <button class="action-btn"
				              onclick="location.href='${pageContext.request.contextPath}/myReviewWrite?orderId=${order.orderId}&orderItemId=${item.orderItemId}&productId=${item.productId}'">
				        후기 작성
				      </button>
				    </c:when>
				    <%-- 이미 리뷰가 있으면 → 안내 후 내 리뷰 목록으로 --%>
				    <c:otherwise>
				      <button class="action-btn"
				              onclick="location.href='${pageContext.request.contextPath}/myReviewList';">
				        후기 확인
				      </button>
				    </c:otherwise>
				  </c:choose>
				</c:when>
              </c:choose>
            </div>
          </div>
        </c:forEach>
      </div>
    </div>
  </c:forEach>

  <!-- 페이징 -->
  <div style="text-align: center; margin-top: 30px;">
    <c:forEach var="i" begin="1" end="${totalPages != null ? totalPages : 1}">
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
<script>
  function setDateRangeAndSubmit(monthsAgo) {
    const today = new Date();
    const endDate = today;
    const startDate = new Date(today);
    startDate.setMonth(today.getMonth() - monthsAgo);

    const pad = (n) => n.toString().padStart(2, '0');

    document.querySelector('select[name="startYear"]').value = startDate.getFullYear();
    document.querySelector('select[name="startMonth"]').value = pad(startDate.getMonth() + 1);
    document.querySelector('select[name="startDay"]').value = pad(startDate.getDate());

    document.querySelector('select[name="endYear"]').value = endDate.getFullYear();
    document.querySelector('select[name="endMonth"]').value = pad(endDate.getMonth() + 1);
    document.querySelector('select[name="endDay"]').value = pad(endDate.getDate());

    document.getElementById("dateForm").submit();
  }
</script>
<script>
// 뒤로 가기로 돌아올 때(bfcache) 페이지 새로고침
window.addEventListener("pageshow", function(e) {
  if (e.persisted) window.location.reload();
});
</script>
<%@ include file="/common/footer.jsp" %>
