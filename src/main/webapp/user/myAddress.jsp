<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- ✅ 공통 헤더 -->
<jsp:include page="/header" />

<!-- ✅ 레이아웃 시작 -->
<div class="container" style="display:flex; max-width:1200px; margin:0 auto; padding:40px 20px; gap:30px;">

  <!-- ✅ 왼쪽 사이드바 -->
  <div class="sidebar" style="width:200px;">
    <%@ include file="mysidebar.jsp" %>
  </div>

  <!-- ✅ 본문 -->
  <div class="content" style="flex:1;">
    <h2 style="font-size:24px; font-weight:bold; margin-bottom:5px;">배송지 관리</h2>
    <p style="margin-top:0; color:#666;">귀하의 상품이 안전하게 배송될 곳입니다</p>

    <!-- Kakao Postcode API -->
    <script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
    <script>
      function openPostcode(slot) {
        new daum.Postcode({
          oncomplete: function(data) {
            document.getElementById('address' + slot).value = data.address;
            document.getElementById('address' + slot + 'Detail').focus();
          }
        }).open();
      }
    </script>

    <form action="${pageContext.request.contextPath}/myAddress" method="post">
  <c:forEach var="i" begin="1" end="3">
    <!-- 1) addressN 과 addressNDetail 프로퍼티명을 EL 변수에 설정 -->
    <c:set var="addrProp"   value="address${i}" />
    <c:set var="detailProp" value="address${i}Detail" />

    <details class="addr-slot">
      <summary>
        주소 ${i}
        <c:choose>

          <c:when test="${not empty user[addrProp]}">
            ${user[addrProp]}
          </c:when>
          <c:otherwise>미등록</c:otherwise>
        </c:choose>
      </summary>
      <div class="slot-body">

        <div class="line">
          <button type="button" onclick="openPostcode(${i})">주소 검색</button>
          <input type="text"
                 id="address${i}"
                 name="address${i}"
                 value="${user[addrProp]}"
                 readonly />
        </div>
        <div class="line">
          <label for="address${i}Detail">상세 주소</label>
          <input type="text"
                 id="address${i}Detail"
                 name="address${i}Detail"
                 value="${user[detailProp]}" />
        </div>
        <div class="line btn-group">
          <button type="submit" name="action" value="update${i}">수정</button>
          <button type="submit" name="action" value="delete${i}">삭제</button>
        </div>
      </div>
    </details>
  </c:forEach>
</form>
  </div>
</div>
<!-- ✅ 공통 푸터 -->
<jsp:include page="/common/footer.jsp" />

<style>
  .container {
    background:#fff;
    border-radius:12px;
    box-shadow:0 8px 20px rgba(0,0,0,0.05);
  }
  .addr-slot {
    border:1px solid #ddd;
    border-radius:8px;
    margin-bottom:16px;
  }
  .addr-slot summary {
    padding:12px 16px;
    font-weight:500;
    cursor:pointer;
    list-style:none;
  }
  .addr-slot summary::-webkit-details-marker { display: none; }
  .addr-slot summary::after {
    content: '▾';
    float:right;
    transition:transform .2s;
  }
  .addr-slot[open] summary::after {
    transform:rotate(180deg);
  }
  .slot-body {
    padding:16px;
    border-top:1px solid #eee;
  }
  .line {
    display:flex;
    align-items:center;
    margin-bottom:12px;
    gap:8px;
  }
  .line.btn-group {
    justify-content:flex-end;
  }
  .btn-search {
    background:#0066ff;
    color:#fff;
    border:none;
    padding:6px 12px;
    border-radius:4px;
    cursor:pointer;
  }
  .btn-group button {
    background:#333;
    color:#fff;
    border:none;
    padding:8px 16px;
    border-radius:4px;
    cursor:pointer;
    margin-left:8px;
  }
  input[type="text"] {
    flex:1;
    padding:8px;
    border:1px solid #ccc;
    border-radius:4px;
  }
  label {
    width:80px;
  }
</style>
