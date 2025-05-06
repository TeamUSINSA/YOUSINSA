<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn"  uri="http://java.sun.com/jsp/jstl/functions" %>

<jsp:include page="/header" />

<style>
  .mypage-layout { display:flex; gap:30px; max-width:1200px; margin:40px auto; }
  .exchange-container { background:#fff; padding:30px; border-radius:8px; box-shadow:0 4px 15px rgba(0,0,0,0.1); flex:1; }
  .exchange-container h2 { font-size:24px; color:#007bff; border-bottom:2px solid #007bff; padding-bottom:8px; margin-bottom:20px; }
  .exchange-table { width:100%; border-collapse:collapse; margin-bottom:30px; }
  .exchange-table th, .exchange-table td { border:1px solid #e0e0e0; padding:12px; }
  .exchange-table th { background:#f9f9f9; }
  .radio-group { display:flex; gap:20px; margin-bottom:20px; }
  .radio-group label { cursor:pointer; }
  .option-fields { display:grid; grid-template-columns:1fr 1fr; gap:20px; margin-bottom:20px; }
  .option-fields label { display:block; margin-bottom:6px; font-weight:500; }
  .option-fields select, .option-fields textarea { width:100%; padding:6px; border:1px solid #ccc; border-radius:4px; }
  .option-fields textarea { resize:none; height:120px; }
  .delivery-info { margin-top:30px; }
  .delivery-info h3 { margin-bottom:10px; }
  .delivery-info-inner { display:flex; justify-content:space-between; align-items:flex-start; gap:20px; }
  .delivery-info table { border-collapse:collapse; width:100%; }
  .delivery-info th, .delivery-info td { border:1px solid #eee; padding:10px; text-align:left; }
  .delivery-request { margin-top:30px; }
  .delivery-request textarea { width:100%; height:80px; border:1px solid #ccc; border-radius:4px; resize:none; padding:8px; }
  .btn-group { text-align:center; margin-top:30px; }
  .btn-submit, .btn-cancel { padding:10px 20px; margin:0 10px; border:none; border-radius:4px; cursor:pointer; }
  .btn-submit { background:#28a745; color:#fff; }
  .btn-cancel { background:#6c757d; color:#fff; }
   /* 섹션 헤더: 제목 + 버튼 가로 정렬 */
  .section-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 10px;
  }
  .section-header h3 {
    margin: 0;
    font-size: 18px;
    color: #2c3e50;
  }

  /* 배송지 변경 버튼 꾸미기 */
  .btn-change {
    padding: 6px 12px;
    background-color: #030303;
    color: #fff;
    border: none;
    border-radius: 4px;
    font-size: 14px;
    cursor: pointer;
    transition: background-color .2s;
  }
  .btn-change:hover {
    background-color: #0056b3;
  }
</style>

<div class="mypage-layout">
  <!-- 사이드바 -->
  <div style="width:200px; flex-shrink:0;">
    <%@ include file="mysidebar.jsp" %>
  </div>

  <!-- 메인 컨테이너 -->
  <div class="exchange-container">
    <h2>주문 교환</h2>

    <form action="${pageContext.request.contextPath}/myExchangeApply" method="post">
      <input type="hidden" name="orderItemId" value="${product.orderItemId}" />

      <!-- 주문 정보 -->
      <table class="exchange-table">
        <thead>
          <tr><th>상품</th><th>수량</th><th>주문금액</th><th>상태</th></tr>
        </thead>
        <tbody>
          <tr>
            <td>
              <a href="${pageContext.request.contextPath}/productDetail?productId=${product.productId}">
                <img src="${pageContext.request.contextPath}/image/${product.mainImage1}"
                     style="width:60px;vertical-align:middle;margin-right:8px;" alt="이미지" />
                ${product.name}
              </a><br/>
              <span style="font-size:12px;color:#666;">색상: ${product.color} / 사이즈: ${product.size}</span>
            </td>
            <td style="text-align:center;">${product.quantity}</td>
            <td style="text-align:center;">
              <fmt:formatNumber value="${(product.price - product.discount) * product.quantity}" type="currency" currencySymbol="₩" maxFractionDigits="0"/>
            </td>
            <td style="text-align:center;">배송 완료</td>
          </tr>
        </tbody>
      </table>

      <!-- 교환 사유 -->
      <div class="radio-group">
        <label><input type="radio" name="reason" value="size" required/> 사이즈 변경</label>
        <label><input type="radio" name="reason" value="color" required/> 색상 변경</label>
        <label><input type="radio" name="reason" value="defect" required/> 상품 하자</label>
        <label><input type="radio" name="reason" value="other" required/> 기타</label>
      </div>

      <!-- 교환 옵션 -->
      <div class="option-fields">
        <div id="sizeField" class="hidden">
          <label for="exchangeSize">교환 사이즈</label>
          <select id="exchangeSize" name="exchangeSize">
            <c:forEach var="s" items="${availableSizes}"><option value="${s}">${s}</option></c:forEach>
          </select>
        </div>
        <div id="colorField" class="hidden">
          <label for="exchangeColor">교환 색상</label>
          <select id="exchangeColor" name="exchangeColor">
            <c:forEach var="c" items="${availableColors}"><option value="${c}">${c}</option></c:forEach>
          </select>
        </div>
        <div id="defectField" class="hidden">
          <label for="exchangeNote">하자 내용</label>
          <textarea id="exchangeNote" name="exchangeNote" rows="3"></textarea>
        </div>
        <div id="otherField" class="hidden">
          <label for="exchangeNote">기타 사유</label>
          <textarea id="exchangeNote" name="exchangeNote" rows="3"></textarea>
        </div>
      </div>

      <div class="delivery-info">
  <!-- 1) section-header로 제목과 버튼 배치 -->
  <div class="section-header">
    <h3>배송지 정보</h3>
    <button type="button"
            class="btn-change"
            onclick="location.href='${pageContext.request.contextPath}/addressBook'">
      배송지 변경
    </button>
  </div>

  <!-- 2) 테이블만 남겨서 버튼은 위로 이동 -->
  <table>
    <tr><th>받는 분</th><td>${user.name}</td></tr>
    <tr><th>연락처</th><td>${user.phone}</td></tr>
    <tr><th>주소</th><td>${user.address1}</td></tr>
  </table>
</div>

      <!-- 요청사항 -->
      <div class="delivery-request">
        <h3>배송 요청사항</h3>
        <textarea name="deliveryRequest" rows="2" placeholder="요청사항을 입력해주세요."></textarea>
      </div>

      <!-- 버튼 그룹 -->
      <div class="btn-group">
        <button type="submit" class="btn-submit">교환 요청</button>
        <button type="button" class="btn-cancel" onclick="location.href='${pageContext.request.contextPath}/myOrders'">목록으로</button>
      </div>
    </form>
  </div>
</div>

<jsp:include page="/common/footer.jsp" />
