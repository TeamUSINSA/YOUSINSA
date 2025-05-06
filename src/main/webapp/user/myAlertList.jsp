<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- ✅ 공통 헤더 삽입 -->
<jsp:include page="/header" />

<style>
  /* ─── 전체 레이아웃 ───────────────────────────────── */
  .layout {
    display: flex;
    max-width: 1200px;
    margin: 0 auto;
    padding: 40px 20px;
    gap: 30px;
  }
  /* ─── 사이드바 ───────────────────────────────────── */
  .sidebar {
    width: 200px;
  }
  /* ─── 본문 ───────────────────────────────────────── */
  .content {
    flex: 1;
  }
  .content h2 {
    font-size: 20px;
    font-weight: bold;
    margin-bottom: 20px;
  }
  /* ─── 알림 리스트 ───────────────────────────────── */
  .alert-list {
    list-style: none;
    padding: 0;
    margin: 0;
  }
  .alert-item {
    border: 1px solid #ddd;
    border-left-width: 4px;
    border-left-color: #007bff; /* 체크 안 된 알림은 파란색 강조선 */
    border-radius: 4px;
    padding: 15px 20px;
    margin-bottom: 12px;
    background: #fff;
    transition: background .2s;
  }
  .alert-item.checked {
    /* 이미 확인한 알림은 연한 회색 배경 */
    border-left-color: #ccc;
    background: #f9f9f9;
  }
  .alert-item:hover {
    background: #f1f1f1;
  }
  .alert-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 8px;
  }
  .alert-title {
    font-size: 16px;
    font-weight: bold;
  }
  .alert-info {
    font-size: 12px;
    color: #666;
  }
  .alert-content {
    font-size: 14px;
    color: #333;
    margin-bottom: 8px;
  }
</style>

<div class="layout">

  <!-- ✅ 사이드바 -->

    <%@ include file="mysidebar.jsp" %>


  <!-- ✅ 본문: 나의 알림 목록 -->
  <div class="content">
    <h2>알림 목록</h2>

    <!-- 1) 알림이 없을 때 -->
    <c:if test="${empty alertList}">
      <p>받은 알림이 없습니다.</p>
    </c:if>

    <!-- 2) 알림 리스트 반복 출력 -->
    <ul class="alert-list">
      <c:forEach var="alert" items="${alertList}">
    <li class="alert-item ${alert.checked ? 'checked' : ''}">
      <a href="${pageContext.request.contextPath}/myAlarm?action=check&alertId=${alert.alertId}"
         style="display: block; text-decoration: none; color: inherit;">
        <div class="alert-header">
          <div class="alert-title">${alert.title}</div>
          <div class="alert-info">보낸 사람: ${alert.senderName}</div>
        </div>
        <div class="alert-content">${alert.content}</div>
        <c:if test="${not empty alert.type}">
          <div class="alert-info">유형: ${alert.type}</div>
        </c:if>
      </a>
    </li>
  </c:forEach>
    </ul>
  </div>
</div>

<!-- ✅ 공통 푸터 삽입 -->
<%@ include file="/common/footer.jsp" %>
