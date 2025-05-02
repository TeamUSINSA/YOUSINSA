<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<title>장바구니</title>
<style>
body {
	margin: 0;
	font-family: 'Noto Sans KR', sans-serif;
	background: #fff;
	color: #222;
}

.cart-container {
	max-width: 1000px;
	margin: 40px auto;
	padding: 0 20px;
}

.cart-title {
	font-size: 24px;
	font-weight: bold;
	text-align: center;
	margin-bottom: 24px;
}

.cart-table {
	width: 100%;
	border-collapse: collapse;
}

.cart-table thead th {
	padding: 14px 8px;
	border-bottom: 1px solid #ddd;
	background-color: #fafafa;
	font-weight: bold;
	text-align: center;
}

.cart-table tbody td {
	padding: 16px 8px;
	border-bottom: 1px solid #eee;
	text-align: center;
	vertical-align: middle;
}

.cart-item {
	display: flex;
	align-items: center;
	gap: 16px;
	text-align: left;
}

.cart-item img {
	width: 60px;
	height: 60px;
	border: 1px solid #ddd;
	object-fit: cover;
}

.cart-info {
	display: flex;
	flex-direction: column;
	font-size: 14px;
}

.cart-qty {
	display: flex;
	justify-content: center;
	align-items: center;
	gap: 6px;
}

.cart-actions {
	text-align: right;
}

button {
	background: #333;
	color: #fff;
	border: none;
	padding: 6px 10px;
	border-radius: 4px;
	cursor: pointer;
	font-size: 13px;
}

button:hover {
	background: #000;
}

.cart-top-actions, .cart-bottom-actions {
	display: flex;
	justify-content: flex-end;
	max-width: 1000px;
	margin: 20px auto;
	gap: 10px;
}
</style>
</head>
<body>
<jsp:include page="/header" />
	<c:if test="${not empty cartList}">
  <div class="cart-container">

    <form id="cartForm" method="post">
      <table class="cart-table">
        <thead>
          <tr>
            <th><input type="checkbox" id="selectAll" onclick="toggleAll(this)"></th>
            <th>상품정보</th>
            <th>수량</th>
            <th>금액</th>
            <th>삭제</th>
          </tr>
        </thead>
        <tbody>
          <c:forEach var="item" items="${cartList}">
            <!-- 상품 상세 URL 미리 생성 -->
            <c:url var="detailUrl" value="/productDetail">
              <c:param name="productId" value="${item.productId}" />
            </c:url>

            <tr
              data-cart-id="${item.cartId}"
              data-product-id="${item.productId}"
              data-color="${item.color}"
              data-size="${item.size}"
              data-quantity="${item.quantity}"
              data-unit="${item.price}"
            >
              <td>
                <input type="checkbox" class="itemCheckbox" value="${item.cartId}">
              </td>
              <td>
                <a href="${detailUrl}" style="display:flex; text-decoration:none; color:inherit;">
                  <div class="cart-item">
                    <img src="${pageContext.request.contextPath}/image/${item.mainImage1}" alt="${item.name}">
                    <div class="cart-info">
                      <div><b>${item.name}</b></div>
                      <div>옵션: ${item.color} / ${item.size}</div>
                    </div>
                  </div>
                </a>
              </td>
              <td>
                <div class="cart-qty">
                  <button type="button" onclick="changeQty(this, -1)">-</button>
                  <span class="qty">${item.quantity}</span>
                  <button type="button" onclick="changeQty(this, 1)">+</button>
                </div>
              </td>
              <td>
                <span class="price">
                  <fmt:formatNumber value="${item.price * item.quantity}" type="number"/>원
                </span>
              </td>
              <td class="cart-actions">
                <button type="button" onclick="deleteSingle(${item.cartId})">삭제</button>
              </td>
            </tr>
          </c:forEach>
        </tbody>
      </table>
    </form>

    <div class="cart-bottom-actions">
    <button onclick="deleteSelected()">선택항목 삭제</button>
      <button id="orderSelectedBtn" class="button">선택상품 주문</button>
      <button id="orderAllBtn" class="button button-black" onclick="orderAll()">전체상품 주문</button>
    </div>
    <div class="cart-total"
      style="max-width: 1000px; margin: 0 auto 40px; text-align: right; font-size: 16px; font-weight: bold;">
      선택 합계: <span id="selectedSum">0</span>원
    </div>
  </div>
</c:if>

<c:if test="${empty cartList}">
  <div class="cart-empty" style="text-align:center; margin:60px 0; font-size:18px; color:#000;">
    <p>장바구니에 담긴 상품이 없습니다.</p>
    <a href="${pageContext.request.contextPath}/productList?popular"
       style="display:inline-block; margin-top:12px; padding:8px 16px; background:#000; color:#fff; text-decoration:none; border-radius:4px;">
      상품 보러 가기
    </a>
  </div>
</c:if>
	<jsp:include page="/footer" />


<script>
/* ------------------------------------------------------------------
   ★ 서버 URL (컨텍스트 경로 포함) – JSP 가 정확히 생성해 줌
------------------------------------------------------------------ */
const URLS = {
  update : '<c:url value="/cartUpdate"/>',
  delSel : '<c:url value="/cartSelectDelete"/>',
  delOne : '<c:url value="/cartDelete"/>',
  order  : '<c:url value="/order"/>'
};

/* ------------------------------------------------------------------
   공통 유틸
------------------------------------------------------------------ */
function numberFormat(n){ return new Intl.NumberFormat().format(n); }

/* ------------------------------------------------------------------
   체크박스 전체‑선택
------------------------------------------------------------------ */
function toggleAll(master){
  document.querySelectorAll('.itemCheckbox')
          .forEach(cb => cb.checked = master.checked);
  updateSelectedSum();
}

/* ------------------------------------------------------------------
   선택합계 계산
------------------------------------------------------------------ */
function updateSelectedSum(){
  let sum = 0;
  document.querySelectorAll('tbody tr').forEach(row=>{
    const cb = row.querySelector('.itemCheckbox');
    if(cb && cb.checked){
      const unit = +row.dataset.unit;
      const qty  = +row.querySelector('.qty').innerText;
      sum += unit*qty;
    }
  });
  document.getElementById('selectedSum').innerText = numberFormat(sum);
}

/* ------------------------------------------------------------------
   수량 +/− (inline onclick 에서 호출)
------------------------------------------------------------------ */
function changeQty(btn, delta){
  const row       = btn.closest('tr');
  const qtySpan   = row.querySelector('.qty');
  const priceSpan = row.querySelector('.price');
  const cartId    = row.dataset.cartId;
  const unit      = +row.dataset.unit;

  const qty = Math.max(1, +qtySpan.innerText + delta);
  qtySpan.innerText   = qty;
  priceSpan.innerText = numberFormat(qty*unit) + '원';
  row.dataset.quantity = qty;
  updateSelectedSum();

  const params = new URLSearchParams({ cartId, quantity: qty });
  fetch(URLS.update, { method:'POST', body:params })
      .then(r=>r.text())
      .then(t=>{ if(t!=='ok'){ alert('수량 변경 실패'); location.reload(); }})
      .catch(()=>{ alert('네트워크 오류'); location.reload(); });
}

/* ------------------------------------------------------------------
   선택 삭제 (버튼 onclick)
------------------------------------------------------------------ */
function deleteSelected(){
  const ids = Array.from(document.querySelectorAll('.itemCheckbox:checked'))
                    .map(cb=>cb.value);
  if(!ids.length){ alert('삭제할 항목을 선택해주세요.'); return; }
  if(!confirm('정말 삭제하시겠습니까?')) return;

  const f = document.createElement('form');
  f.method='post'; f.action = URLS.delSel;
  ids.forEach(id=>{
    const i=document.createElement('input');
    i.type='hidden'; i.name='cartIds'; i.value=id; f.appendChild(i);
  });
  document.body.appendChild(f); f.submit();
}

/* ------------------------------------------------------------------
   개별 삭제 (inline onclick 에서 호출)
------------------------------------------------------------------ */
function deleteSingle(cartId){
  if(!confirm('해당 상품을 삭제하시겠습니까?')) return;
  const f=document.createElement('form');
  f.method='post'; f.action=URLS.delOne;
  const i=document.createElement('input');
  i.type='hidden'; i.name='cartId'; i.value=cartId; f.appendChild(i);
  document.body.appendChild(f); f.submit();
}

/* ------------------------------------------------------------------
   주문 (선택/전체)
------------------------------------------------------------------ */
function orderSelected(){
  const rows = Array.from(
      document.querySelectorAll('.itemCheckbox:checked'))
      .map(cb=>cb.closest('tr'));
  if(!rows.length){ alert('주문할 항목을 선택해주세요.'); return; }
  submitOrderForm(rows);
}

function orderAll(){
  const rows = Array.from(
      document.querySelectorAll('.itemCheckbox'))
      .map(cb=>cb.closest('tr'));
  if(!rows.length){ alert('장바구니에 상품이 없습니다.'); return; }
  submitOrderForm(rows);
}

function submitOrderForm(rows){
  const f=document.createElement('form');
  f.method='get'; f.action = URLS.order;
  rows.forEach(r=>{
    ['productId','color','size','quantity','cartId']
      .forEach(n=>{
        const i=document.createElement('input');
        i.type='hidden'; i.name=n; i.value=r.dataset[n]; f.appendChild(i);
      });
  });
  document.body.appendChild(f); f.submit();
}

/* ------------------------------------------------------------------
   초기 바인딩
------------------------------------------------------------------ */
document.addEventListener('DOMContentLoaded',()=>{
  document.getElementById('selectAll')
          ?.addEventListener('change',e=>toggleAll(e.target));
  document.querySelectorAll('.itemCheckbox')
          .forEach(cb=>cb.addEventListener('change', updateSelectedSum));
  document.getElementById('orderSelectedBtn')
          ?.addEventListener('click', orderSelected);
  document.getElementById('orderAllBtn')
          ?.addEventListener('click', orderAll);
  updateSelectedSum();
});
</script>



</body>
</html>
