<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!-- 공통 헤더 삽입 -->
<%@ include file="/common/header.jsp" %>

<!-- 테이블 전용 CSS 추가 -->
<style>
  /* 테이블 셀 사이 세로 구분선 */
  .restock-table td,
  .restock-table th {
    border-right: 1px solid #ddd;
  }
  /* 마지막 열에는 구분선 제거 */
  .restock-table td:last-child,
  .restock-table th:last-child {
    border-right: none;
  }
  /* 알림 취소 버튼 스타일 */
  .cancel-btn {
    background-color: #e74c3c;      /* 빨간 계열 배경 */
    color: #fff;                     /* 흰색 글자 */
    border: none;                    /* 기본 테두리 제거 */
    border-radius: 4px;              /* 모서리 둥글게 */
    padding: 6px 12px;               /* 버튼 안쪽 여백 */
    font-size: 12px;                 /* 글자 크기 */
    cursor: pointer;                 /* 마우스 포인터 */
    transition: background-color .2s ease;
  }
  .cancel-btn:hover {
    background-color: #c0392b;       /* 호버 시 진한 빨강 */
  }
</style>

<div class="layout" style="display: flex; max-width:1200px; margin:0 auto; padding:40px 20px; gap:30px;">
  <div class="sidebar" style="width:200px;">
    <%@ include file="/user/mysidebar.jsp" %>
  </div>
  <div class="content" style="flex:1;">
    <h2 style="font-size:20px; font-weight:bold; margin-bottom:20px;">재입고 알림 목록</h2>
    <table class="restock-table" style="width:100%; border-collapse:collapse; font-size:14px;">
      <thead>
        <tr style="background:#f9f9f9;">
          <!-- 상품 / 상태 / 알림취소 헤더 -->
          <th style="padding:10px; border-bottom:1px solid #ccc;">상품</th>
          <th style="padding:10px; border-bottom:1px solid #ccc;">상태</th>
          <th style="padding:10px; border-bottom:1px solid #ccc;"></th>
        </tr>
      </thead>
      <tbody>
        <c:forEach var="item" items="${restockList}">
          <tr>
            <!-- 1) 상품 컬럼: 구분선 포함 -->
            <td style="padding:10px; border-bottom:1px solid #eee;">
              <a href="${pageContext.request.contextPath}/productDetail?productId=${item.productId}"
                 style="display:flex; gap:12px; text-decoration:none; color:inherit;">
                <img src="${pageContext.request.contextPath}/image/${item.mainImage1}"
                     alt="${item.name}"
                     style="width:70px; height:90px; object-fit:cover; border:1px solid #eee; border-radius:4px;">
                <div style="display:flex; flex-direction:column; gap:4px;">
                  <strong style="text-decoration:underline;">${item.name}</strong>
                  <span>색상: ${item.color}</span>
                  <span>사이즈: ${item.size}</span>
                </div>
              </a>
            </td>

            <!-- 2) 상태 컬럼: 구분선 포함 -->
            <td style="text-align:center; padding:10px; border-bottom:1px solid #eee;">
              <c:choose>
                <c:when test="${item.stock > 0}">구매 가능</c:when>
                <c:otherwise>구매 불가</c:otherwise>
              </c:choose>
            </td>

            <!-- 3) 알림 취소 버튼 컬럼 -->
            <td style="text-align:center; padding:10px; border-bottom:1px solid #eee;">
              <c:if test="${item.stock == 0}">
                <form action="${pageContext.request.contextPath}/myRestockRequest" method="post" style="margin:0;">
                  <input type="hidden" name="action"    value="cancel"/>
                  <input type="hidden" name="requestId" value="${item.requestId}"/>
                  <!-- 꾸며진 버튼 -->
                  <button type="submit" class="cancel-btn">
                    알림 취소
                  </button>
                </form>
              </c:if>
            </td>
          </tr>
        </c:forEach>

        <!-- 신청 내역이 없으면 colspan=3 -->
        <c:if test="${empty restockList}">
          <tr>
            <td colspan="3" style="padding:10px; text-align:center;">신청 내역이 없습니다.</td>
          </tr>
        </c:if>
      </tbody>
    </table>
  </div>
</div>

<!-- 공통 푸터 삽입 -->
<%@ include file="/common/footer.jsp" %>
