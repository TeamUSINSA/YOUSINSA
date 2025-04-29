<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!-- 공통 헤더 -->
<%@ include file="/common/header.jsp" %>

<!-- 페이지 전용 스타일 -->
<style>
  /* 전체 레이아웃 중앙정렬 */
  .layout {
    display: flex;
    max-width: 1200px;
    margin: 0 auto;
    padding: 40px 20px;
    gap: 30px;
  }

  /* 본문 카드 스타일 */
  .coupon-card {
    display: flex;
    justify-content: space-between;
    align-items: center;
    border: 1px solid #ddd;
    border-radius: 8px;
    padding: 15px 20px;
    margin-bottom: 15px;
    box-shadow: 0 4px 10px rgba(0,0,0,0.03);
  }

  /* 왼쪽: 이미지 + 상세 */
  .coupon-info {
    display: flex;
    align-items: center;
    gap: 12px;
  }
  .coupon-info img {
    width: 80px;
    height: 80px;
    object-fit: cover;
    border-radius: 6px;
    flex-shrink: 0;
  }
  .coupon-details {
    display: flex;
    flex-direction: column;
    gap: 6px;
  }
  .coupon-details .title {
    font-size: 16px;
    font-weight: bold;
  }
  .coupon-details .desc {
    font-size: 13px;
    color: #555;
  }
  .coupon-details .expiry {
    font-size: 12px;
    color: #999;
  }

  /* 수직 구분선 */
  .coupon-discount {
    font-size: 20px;
    font-weight: bold;
    padding-left: 20px;
    border-left: 1px solid #ddd;
    min-width: 80px;
    text-align: center;
  }

  /* 쿠폰 다운로드 버튼 */
  .btn-download {
    padding: 8px 16px;
    border: 1px solid #333;
    background: #fff;
    border-radius: 4px;
    cursor: pointer;
    transition: background .2s;
  }
  .btn-download:hover {
    background: #f9f9f9;
  }

  /* 페이지네이션 */
  .pagination {
    text-align: center;
    margin-top: 30px;
  }
  .pagination a {
    margin: 0 5px;
    text-decoration: none;
    color: #333;
    padding: 6px 10px;
    border-radius: 4px;
  }
  .pagination a.current {
    background: #333;
    color: #fff;
  }
</style>

<div class="layout">

  <!-- 사이드바 -->
  <div class="sidebar" style="width:200px;">
    <%@ include file="mysidebar.jsp" %>
  </div>

  <!-- 본문 -->
  <div class="content" style="flex:1;">

    <!-- 상단 타이틀 + 다운로드 -->
    <div style="display:flex; justify-content:space-between; align-items:center; margin-bottom:20px;">
      <h2 style="font-size:20px; font-weight:bold;">쿠폰 조회</h2>
      <button
	  class="btn-download"
	  type="button"
	  onclick="location.href='${pageContext.request.contextPath}/coupon'">
	  쿠폰 다운로드
	</button>
    </div>
    <p style="font-size:13px; color:#666; margin-bottom:20px;">
      귀하께서 보유하신 Yousinsa의 쿠폰 목록입니다 (중복사용 불가)
    </p>

    <!-- 쿠폰 카드 반복 -->
    <c:forEach var="coupon" items="${couponList}">
      <div class="coupon-card">
        <!-- 왼쪽: 이미지 + 텍스트 -->
        <div class="coupon-info">
          <img src="${pageContext.request.contextPath}/image/coupon.png" alt="${coupon.coupon.name}" />
          <div class="coupon-details">
            <div class="title">${coupon.coupon.name}</div>
            <div class="desc">${coupon.coupon.description}</div>
            <div class="expiry">
              유효기간: 
              <fmt:formatDate value="${coupon.issueDate}" pattern="yyyy.MM.dd" />
              –
              <fmt:formatDate value="${coupon.expireDate}" pattern="yyyy.MM.dd" />
            </div>
          </div>
        </div>
        <!-- 오른쪽: 할인액/퍼센트 (구분선 포함) -->
        <div class="coupon-discount">
          <c:choose>
    
    <c:when test="${coupon.coupon.discountAmount < 100}">
      ${coupon.coupon.discountAmount}%
    </c:when>
    
    <c:otherwise>
      <fmt:formatNumber value="${coupon.coupon.discountAmount}" type="number"/>원
    </c:otherwise>
  </c:choose>
        </div>
      </div>
    </c:forEach>

    <!-- 페이지네이션 -->
    <div class="pagination">
      <c:forEach var="i" begin="1" end="${totalPages}">
        <a href="?page=${i}" class="${i == currentPage ? 'current' : ''}">
          ${i}
        </a>
      </c:forEach>
    </div>

  </div>
</div>

<!-- 공통 푸터 -->
<%@ include file="/common/footer.jsp" %>
