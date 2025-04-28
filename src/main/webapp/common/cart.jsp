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
	<h2 class="cart-title">장바구니</h2>

	<c:if test="${empty cartList}">
		<p style="text-align: center;">장바구니에 상품이 없습니다.</p>
	</c:if>

	<c:if test="${not empty cartList}">
		<div class="cart-container">
			<div class="cart-top-actions">
				<button onclick="deleteSelected()">선택항목 삭제</button>
			</div>

			<form id="cartForm" method="post">
				<table class="cart-table">
					<thead>
						<tr>
							<th><input type="checkbox" id="selectAll"
								onclick="toggleAll(this)"></th>
							<th>상품정보</th>
							<th>수량</th>
							<th>금액</th>
							<th>삭제</th>
						</tr>
					</thead>
					<tbody>
<c:forEach var="item" items="${cartList}">
  <tr
    data-cart-id="${item.cartId}"
    data-product-id="${item.productId}"
    data-color="${item.color}"
    data-size="${item.size}"
    data-quantity="${item.quantity}"
    data-unit="${item.price}">
    <td>
      <input type="checkbox" class="itemCheckbox">
    </td>
    <td>
      <!-- 기존 코드 유지 -->
      <div class="cart-item">
        <img src="${pageContext.request.contextPath}/image/${item.mainImage1}" alt="${item.name}">
        <div class="cart-info">
          <div><b>${item.name}</b></div>
          <div>옵션: ${item.color} / ${item.size}</div>
        </div>
      </div>
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
<button id="orderSelectedBtn" class="button" onclick="orderSelected()">선택상품 주문</button>
  <button id="orderAllBtn" class="button button-black" onclick="orderAll()">전체상품 주문</button>
			</div>
			<div class="cart-total"
				style="max-width: 1000px; margin: 0 auto 40px; text-align: right; font-size: 16px; font-weight: bold;">
				선택 합계: <span id="selectedSum">0</span>원
			</div>
		</div>
	</c:if>

	<jsp:include page="/footer" />

	<script>
	const ctx = '<%=request.getContextPath()%>';
const contextPath = '<%=request.getContextPath()%>';

function toggleAll(master) {
  document.querySelectorAll('.itemCheckbox').forEach(cb => cb.checked = master.checked);
}

function getSelectedIds() {
  return Array.from(document.querySelectorAll('.itemCheckbox:checked')).map(cb => cb.value);
}

function deleteSelected() {
  const selected = getSelectedIds();
  if (selected.length === 0) return alert("삭제할 항목을 선택해주세요.");
  if (!confirm("정말 삭제하시겠습니까?")) return;

  const form = document.createElement('form');
  form.method = 'post';
  form.action = contextPath + '/cartSelectDelete';

  selected.forEach(id => {
    const input = document.createElement('input');
    input.type = 'hidden';
    input.name = 'cartIds';
    input.value = id;
    form.appendChild(input);
  });

  document.body.appendChild(form);
  form.submit();
}

function orderSelected() {
    const rows = Array.from(
      document.querySelectorAll('.itemCheckbox:checked')
    ).map(cb => cb.closest('tr'));
    if (rows.length === 0) {
      return alert('주문할 항목을 선택해주세요.');
    }
    submitOrderForm(rows);
  }


function changeQty(btn, delta) {
	  const row     = btn.closest("tr");
	  const qtySpan = row.querySelector(".qty");
	  const priceSpan = row.querySelector(".price");

	  // data‑ 속성에서 읽기
	  const cartId = row.getAttribute("data-cart-id");
	  const unit   = parseInt(row.getAttribute("data-unit"), 10);

	  // 화면에 수량·금액 갱신
	  let qty = Math.max(1, parseInt(qtySpan.innerText, 10) + delta);
	  qtySpan.innerText = qty;
	  priceSpan.innerText = new Intl.NumberFormat().format(qty * unit);

	  // 요청 URL과 바디 확인
	  const url = `${contextPath}/yousinsa/cartUpdate`;
	  console.log("▶ Request URL →", url);
	  console.log("▶ Request Body →", `cartId=${cartId}&quantity=${qty}`);

	  // URLSearchParams 로 POST
	  const params = new URLSearchParams();
	  params.append("cartId", cartId);
	  params.append("quantity", qty);

	  fetch(url, {
	    method: "POST",
	    headers: { "Content-Type": "application/x-www-form-urlencoded; charset=UTF-8" },
	    body: params
	  })
	  .then(res => {
	    console.log("▶ Status:", res.status);
	    return res.text();
	  })
	  .then(text => {
	    console.log("▶ Response Text:", text);
	    if (text !== "ok") {
	      alert("수량 변경 실패");
	      location.reload();
	    }
	  })
	  .catch(err => {
	    console.error(err);
	    alert("네트워크 오류");
	  });
	}


function orderAll() {
    const rows = Array.from(
      document.querySelectorAll('.itemCheckbox')
    ).map(cb => cb.closest('tr'));
    if (rows.length === 0) {
      return alert('장바구니에 상품이 없습니다.');
    }
    submitOrderForm(rows);
  }
  
function deleteSingle(cartId) {
  if (!confirm("해당 상품을 삭제하시겠습니까?")) return;

  const form = document.createElement('form');
  form.method = 'post';
  form.action = contextPath + '/cartDelete';

  const input = document.createElement('input');
  input.type = 'hidden';
  input.name = 'cartId';
  input.value = cartId;

  form.appendChild(input);
  document.body.appendChild(form);
  form.submit();
}
</script>

	<script>
document.addEventListener('DOMContentLoaded', () => {
  const totalPriceEl    = document.getElementById('selectedSum');

  // 1) 합계 계산 함수
  function updateSelectedSum() {
    let sum = 0;
    document.querySelectorAll('tbody tr').forEach(row => {
      const cb = row.querySelector('.itemCheckbox');
      if (cb && cb.checked) {
        const unit = parseInt(row.getAttribute('data-unit'), 10);
        const qty  = parseInt(row.querySelector('.qty').innerText, 10);
        sum += unit * qty;
      }
    });
    totalPriceEl.innerText = new Intl.NumberFormat().format(sum);
  }

  // 2) 체크박스 개별 바인딩
  document.querySelectorAll('.itemCheckbox').forEach(cb => {
    cb.addEventListener('change', updateSelectedSum);
  });

  // 3) 전체 선택박스 바인딩
  const selectAll = document.getElementById('selectAll');
  if (selectAll) {
    selectAll.addEventListener('change', function() {
      document.querySelectorAll('.itemCheckbox')
              .forEach(cb => cb.checked = this.checked);
      updateSelectedSum();
    });
  }

  // 4) 수량 변경 함수에도 호출 삽입
  window.changeQty = function(btn, delta) {
    const row      = btn.closest("tr");
    const qtySpan  = row.querySelector(".qty");
    const priceSpan= row.querySelector(".price");
    const unit     = parseInt(row.getAttribute("data-unit"), 10);

    let qty = Math.max(1, parseInt(qtySpan.innerText, 10) + delta);
    qtySpan.innerText   = qty;
    priceSpan.innerText = new Intl.NumberFormat().format(qty * unit);

    // (기존 fetch 로직 생략)
    updateSelectedSum();
  };

  // 5) 페이지 로드 직후 초기 계산
  updateSelectedSum();
});
</script>
<script>
document.addEventListener('DOMContentLoaded', () => {
  const buyBtn = document.getElementById('buyNowBtn');
  if (!buyBtn) return;

  buyBtn.addEventListener('click', () => {
    // 1) 선택된 옵션 수집
    const items = Array.from(
      document.querySelectorAll('.selected-item')
    ).map(div => ({
      cartId:    div.dataset.cartId,
      productId: '<c:out value="${product.productId}"/>',
      color:     div.dataset.color,
      size:      div.dataset.size,
      quantity:  parseInt(div.querySelector('.count').textContent, 10)
    }));

    if (items.length === 0) {
      alert('옵션을 하나 이상 선택해주세요.');
      return;
    }

    // 2) GET 폼 생성
    const form = document.createElement('form');
    form.method = 'get';
    form.action = '<c:url value="/order" />';

    // 3) hidden inputs 추가
    items.forEach(it => {
  ['cartId','productId','color','size','quantity'].forEach(name => {
    const input = document.createElement('input');
    input.type  = 'hidden';
    input.name  = name;
    input.value = it[name];
    form.appendChild(input);
  });
});

    // 4) 전송
    document.body.appendChild(form);
    form.submit();
  });
});

function submitOrderForm(rows) {
    const form = document.createElement('form');
    form.method = 'get';
    form.action = ctx + '/order';

    rows.forEach(row => {
      // 1) 상품 정보
      ['productId','color','size','quantity'].forEach(name => {
        const input = document.createElement('input');
        input.type  = 'hidden';
        input.name  = name;
        input.value = row.dataset[name];
        form.appendChild(input);
      });
      // 2) (선택 주문이라면) cartId도 함께 넘겨서 주문 후 삭제할 수 있게
      const cartInput = document.createElement('input');
      cartInput.type  = 'hidden';
      cartInput.name  = 'cartId';
      cartInput.value = row.dataset.cartId;
      form.appendChild(cartInput);
    });

    document.body.appendChild(form);
    form.submit();
  }

  // 버튼에 이벤트 걸기
  document.addEventListener('DOMContentLoaded', () => {
    document.getElementById('orderSelectedBtn')
            .addEventListener('click', orderSelected);
    document.getElementById('orderAllBtn')
            .addEventListener('click', orderAll);
  });
</script>



</body>
</html>
