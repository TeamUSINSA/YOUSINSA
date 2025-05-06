<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="/header" />

<style>
  /* 페이지 전체 래퍼 */
  .page-wrapper {
    display: flex;
    max-width: 1200px;
    margin: 40px auto;
    padding: 40px 20px;
    gap: 30px;
  }

  /* 사이드바 */
  .sidebar { width: 200px; }

  /* 본문 영역 */
  .address-container {
    flex: 1;
    background: #fff;
    border-radius: 12px;
    box-shadow: 0 8px 20px rgba(0,0,0,0.05);
    padding: 32px;
  }
  .address-header h2 {
    margin: 0 0 8px;
    font-size: 24px;
    font-weight: bold;
  }
  .address-header p {
    margin: 0 0 24px;
    color: #666;
    font-size: 14px;
  }

  /* 주소 슬롯 */
  .addr-slot {
    border: 1px solid #ddd;
    border-radius: 8px;
    margin-bottom: 16px;
    overflow: hidden;
  }
  .addr-slot summary {
    padding: 12px 16px;
    background: #f9f9f9;
    font-weight: 500;
    cursor: pointer;
    list-style: none;
    position: relative;
  }
  .addr-slot summary::-webkit-details-marker { display: none; }
  .addr-slot summary::after {
    content: '▾';
    position: absolute;
    right: 16px;
    transition: transform 0.2s;
  }
  .addr-slot[open] summary::after { transform: rotate(180deg); }

  .slot-body {
    padding: 16px;
    border-top: 1px solid #eee;
    background: #fff;
  }
  .slot-body .line {
    display: flex;
    align-items: center;
    gap: 12px;
    margin-bottom: 12px;
  }
  .slot-body .line label {
    width: 90px;
    font-size: 14px;
  }
  .slot-body .line input[type='text'] {
    flex: 1;
    padding: 8px 12px;
    border: 1px solid #ccc;
    border-radius: 4px;
    font-size: 14px;
  }

  .btn-search {
    background: #0066ff;
    color: #fff;
    border: none;
    padding: 8px 16px;
    border-radius: 4px;
    cursor: pointer;
    transition: background 0.2s;
  }
  .btn-search:hover { background: #0055dd; }

  /* 버튼 그룹 */
  .slot-body .btn-group {
    display: flex;
    justify-content: flex-end;
    gap: 12px;
    margin-top: 16px;
  }
  .slot-body .btn-group button {
    background: #333;
    color: #fff;
    border: none;
    padding: 8px 16px;
    border-radius: 4px;
    cursor: pointer;
    transition: background 0.2s;
  }
  .slot-body .btn-group button.delete { background: #d9534f; }
  .slot-body .btn-group button:hover { opacity: 0.9; }

  @media (max-width: 800px) {
    .page-wrapper { flex-direction: column; padding: 20px; }
    .sidebar { width: 100%; }
  }
</style>

<div class="page-wrapper">
  <%@ include file="mysidebar.jsp" %>

  <div class="address-container">
    <div class="address-header">
      <h2>배송지 관리</h2>
      <p>귀하의 상품이 안전하게 배송될 곳입니다</p>
    </div>

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
        <c:set var="addrProp"   value="address${i}" />
        <c:set var="detailProp" value="address${i}Detail" />

        <details class="addr-slot">
          <summary>
            주소 ${i}
            <c:choose>
              <c:when test="${not empty user[addrProp]}">${user[addrProp]}</c:when>
              <c:otherwise>미등록</c:otherwise>
            </c:choose>
          </summary>
          <div class="slot-body">
            <div class="line">
              <button type="button" class="btn-search" onclick="openPostcode(${i})">주소 검색</button>
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
            <div class="btn-group">
              <button type="submit" name="action" value="update${i}">수정</button>
              <button type="submit" name="action" value="delete${i}" class="delete">삭제</button>
            </div>
          </div>
        </details>
      </c:forEach>
    </form>
  </div>
</div>

<jsp:include page="/common/footer.jsp" />
