<%@ page contentType="text/html; charset=UTF-8" language="java"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>상품주문(결제 이전)</title>
<style>
body {
	font-family: sans-serif;
	font-size: 14px;
	color: #333;
	background: #fff;
	margin: 0;
	padding: 0;
}

.container {
	max-width: 800px;
	margin: 0 auto;
	padding: 40px 20px;
	position: relative;
}

h2, h3 {
	font-weight: bold;
	margin-bottom: 12px;
}

table {
	width: 100%;
	border: 1px solid #ccc;
	border-collapse: collapse;
	margin-bottom: 24px;
}

th, td {
	border: 1px solid #ccc;
	padding: 8px;
	text-align: left;
}

input, textarea, button, select {
	font-size: 14px;
	padding: 6px;
}

.section {
	margin-bottom: 40px;
}

.flex {
	display: flex;
	align-items: center;
}

.space-x-2>*:not(:last-child) {
	margin-right: 8px;
}

.btn {
	background-color: #000;
	color: #fff;
	padding: 6px 12px;
	border: none;
	border-radius: 4px;
	cursor: pointer;
}

.right-align {
	text-align: right;
}

.red {
	color: red;
}

.bold {
	font-weight: bold;
}

.coupon-dropdown {
	margin-top: 6px;
}

/* overlay 기본 숨김 */
#modalOverlay {
  display: none;
  position: fixed;
  inset: 0;                       /* top:0; right:0; bottom:0; left:0; */
  background: rgba(0,0,0,0.5);
  z-index: 1000;

  /* 중앙 배치 */
  align-items: center;
  justify-content: center;
}
/* show 클래스가 붙으면 flex로 보임 */
#modalOverlay.show {
  display: flex;
}

#addressModal {
  background: #fff;
  width: 80%;
  max-width: 500px;
  max-height: 70vh;
  overflow-y: auto;
  padding: 20px;
  border-radius: 8px;
  box-shadow: 0 2px 10px rgba(0,0,0,0.3);
}
#addressModal h4 {
  margin-top: 0;
  font-size: 1.2em;
}
#addressListUl {
  list-style: none;
  margin: 10px 0;
  padding: 0;
}
#addressListUl li {
  padding: 8px;
  border-bottom: 1px solid #eee;
  cursor: pointer;
}
#addressListUl li:hover {
  background: #f0f0f0;
}
#closeAddressBox {
  display: block;
  margin: 10px auto 0;
}

  

</style>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script
	src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	 <script src="https://js.tosspayments.com/v2/standard"></script>
</head>
<body>


	<jsp:include page="/header" />

	<div class="container">
	

			<h2>상품 주문</h2>
			<table>
				<thead>
					<tr>
						<th>이미지/상품명</th>
						<th>가격</th>
						<th>쿠폰</th>
						<th>합계</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="item" items="${productList}">
						<tr data-unit-price="${item.unitPrice}"
							data-quantity="${item.quantity}">
							<td>
								<div class="flex">
									<img
										src="${pageContext.request.contextPath}/image/${item.image}"
										alt="${item.name}"
										style="width: 50px; height: 50px; margin-right: 8px;">
									<div>
										<div class="bold">${item.name}</div>
										<div>색상: ${item.color}</div>
										<div>사이즈: ${item.size}</div>
										<div>수량: ${item.quantity}개</div>
									</div>
								</div> <input type="hidden" name="productId" value="${item.productId}" />
								<input type="hidden" name="quantity" value="${item.quantity}" />
								<input type="hidden" name="color" value="${item.color}" /> <input
								type="hidden" name="size" value="${item.size}" /> <input
								type="hidden" name="unitPrice" value="${item.unitPrice}" />
							</td>
							<td><fmt:formatNumber
									value="${item.unitPrice * item.quantity}" type="number" />원</td>
							<td>
								<!-- order.jsp --> <select class="coupon-select" name="couponId">
									<option value="" data-discount="0" data-percent="false">
										쿠폰 없음</option>
									<c:forEach var="c" items="${couponList}">
										<option value="${c.couponId}"
											data-discount="${c.discountAmount}"
											data-percent="${c.discountAmount le 100}">${c.name}
											—
											<c:choose>
												<c:when test="${c.discountAmount le 100}">
        ${c.discountAmount}%
      </c:when>
												<c:otherwise>
        ${c.discountAmount}원
      </c:otherwise>
											</c:choose>
										</option>
									</c:forEach>
							</select>

							</td>
							<td><span class="rowTotal"> <fmt:formatNumber
										value="${item.unitPrice * item.quantity}" type="number" />
							</span>원</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>

			<!-- 주문 요약 영역 -->
			<div id="orderSummary"
				style="padding: 16px; background: #f5f5f5; text-align: center; font-size: 16px; margin-bottom: 24px;">
				총 수량 <span id="totalQty">0</span>개&nbsp;&nbsp; 총 원가 <span
					id="totalOriginal">0</span>원&nbsp;&nbsp; 총 쿠폰 할인 <span
					id="totalDiscount">0</span>원&nbsp;&nbsp; 결제 금액 <span id="totalPay">0</span>원
			</div>

			<!-- 배송지 입력 -->
			<section>
				<h3>
					받으시는 분
					<button type="button" class="btn" id="changeAddressBtn"
						style="float: right;">배송지 변경</button>
				</h3>
				<table>
					<tr>
						<th>이름</th>
						<td>
							<div class="flex">
								<input type="text" id="receiverName" name="receiverName"
									required style="flex: 1;"> <label><input
									type="checkbox" id="sameAsUser"> 주문자와 동일</label>
							</div>
						</td>
					</tr>
					<tr>
						<th>연락처</th>
						<td><input type="text" id="phone1" name="phone1"
							maxlength="3" style="width: 60px;"> - <input type="text"
							id="phone2" name="phone2" maxlength="4" style="width: 60px;">
							- <input type="text" id="phone3" name="phone3" maxlength="4"
							style="width: 60px;"></td>
					</tr>
					<tr>
						<th>주소</th>
						<td>
							<button type="button" class="btn" id="searchZipBtn">주소
								찾기</button> <br> <textarea id="address1" name="baseAddress" rows="2"
								required style="width: 100%;"></textarea> <input type="text"
							id="address2" name="detailAddress" required style="width: 100%;">
						</td>
					</tr>
					<tr>
  <th>배송 요청사항</th>
  <td>
    <textarea id="deliveryRequest" name="deliveryRequest"
      rows="3" style="width:100%;"
      placeholder="배송 시 요청사항을 입력하세요."></textarea>
  </td>
</tr>
				</table>


			</section>

			<!-- 포인트 사용 -->
			<section class="section">
				<h3>포인트 사용</h3>
				<p>
					보유 포인트: <strong>${user.totalPoint}원</strong>
				</p>
				<div class="flex space-x-2">
					<label for="usedPoints">사용할 포인트</label> <input type="text"
						id="usedPoints" name="usedPoints" value="0" style="width: 100px;">
					<button type="button" class="btn" id="useAllPointsBtn">모두사용</button>
				</div>
			</section>

			<!-- 결제 수단 -->
			<section class="section">
				<h3>결제 수단</h3>
				<label><input type="radio" name="paymentMethod" value="TOSS" checked> Toss</label> 
			</section>

			<div id="finalSummary"
				style="padding: 16px; border: 1px solid #ccc; margin-bottom: 24px;">
				<p>
					총 원가: <strong><span id="fsOriginal">0</span>원</strong>
				</p>
				<p>
					쿠폰 할인금액: <strong><span id="fsCoupon">0</span>원</strong>
				</p>
				<p>
					포인트 사용: <strong><span id="fsUsePoints">0</span>원</strong>
				</p>
				<p class="bold">
					최종 결제금액: <span id="fsPay">0</span>원
				</p>
				<p>
					예정 적립 포인트 (5%): <strong><span id="fsEarn">0</span>원</strong>
				</p>
			</div>

			
			<div id="payment-method"></div>
<div id="agreement"></div>

<div style="text-align: center;">
				 <button type="button" id="payBtn" class="btn">결제하기</button>
			</div>
			
	</div>

<div id="modalOverlay">
  <div id="addressModal">
    <h4>저장된 배송지</h4>
    <ul id="addressListUl">
      <c:if test="${not empty user.address1}">
        <li data-base="${user.address1}" data-detail="${user.address1Detail}">
          ${user.address1} ${user.address1Detail}
        </li>
      </c:if>
      <c:if test="${not empty user.address2}">
        <li data-base="${user.address2}" data-detail="${user.address2Detail}">
          ${user.address2} ${user.address2Detail}
        </li>
      </c:if>
      <c:if test="${not empty user.address3}">
        <li data-base="${user.address3}" data-detail="${user.address3Detail}">
          ${user.address3} ${user.address3Detail}
        </li>
      </c:if>
    </ul>
    <button type="button" id="closeAddressBox" class="btn">닫기</button>
  </div>
</div>

    <script type="module" src="./index.js"></script>


<jsp:include page="/footer" />

	<script>
	$(function(){
		  const ctx        = '${pageContext.request.contextPath}';
		  const userId     = '${user.userId}';
		  const totalPoint = ${user.totalPoint};

		  function calcRow($tr) {
			    const unit   = +$tr.data('unit-price'),
			          qty    = +$tr.data('quantity'),
			          orig   = unit * qty,
			          $opt   = $tr.find('option:selected'),
			          amt    = +$opt.data('discount'),
			          isPct  = $opt.data('percent')===true,
			          disc   = isPct ? Math.floor(orig*amt/100) : amt,
			          total  = orig - disc;
			    $tr.find('.rowTotal').text(total.toLocaleString());
			    $tr.data('orig', orig).data('disc', disc);
			  }

			  // 2) 요약 계산
			   function calcSummary() {
    let sumQty=0, sumOrig=0, sumDisc=0;
    $('tbody tr').each(function(){
      const $r   = $(this),
            qty = +$r.data('quantity') || 0,
            orig= +$r.data('orig')      || 0,
            disc= +$r.data('disc')      || 0;
      sumQty  += qty;
      sumOrig += orig;
      sumDisc += disc;
    });
    $('#totalQty').text(sumQty);
    $('#totalOriginal').text(sumOrig.toLocaleString());
    $('#totalDiscount').text(sumDisc.toLocaleString());
    $('#totalPay').text((sumOrig-sumDisc).toLocaleString());
  }



		  function enforceCoupons() {
			    const used = $('select.coupon-select')
			                   .map((i,s)=>s.value).get().filter(v=>v);
			    $('select.coupon-select').each(function(){
			      const my = this.value;
			      $(this).find('option').each(function(){
			        const v = this.value;
			        $(this).prop('disabled', v && used.includes(v) && v!==my);
			      });
			    });
			  }

  // change 이벤트 바인딩
   $('select.coupon-select').on('change', function(){
    const $tr = $(this).closest('tr');
    calcRow($tr);
    enforceCoupons();
    calcSummary();
    updateFinalSummary();
  });

  function updateSummary() {
    let sumQty = 0, sumOrig = 0, sumDisc = 0;
    $('tbody tr').each(function(){
      const $r = $(this);
      sumQty  += Number($r.data('quantity'));
      sumOrig += Number($r.data('orig')) || (Number($r.data('unit-price')) * Number($r.data('quantity')));
      sumDisc += Number($r.data('disc'));
    });
    $('#totalQty').text(sumQty);
    $('#totalOriginal').text(sumOrig.toLocaleString() + '원');
    $('#totalDiscount').text(sumDisc.toLocaleString() + '원');
    $('#totalPay').text((sumOrig - sumDisc).toLocaleString() + '원');
  }

  function updateFinalSummary() {
	    calcSummary();
	    const orig  = Number($('#totalOriginal').text().replace(/,/g,'')),
	          coup  = Number($('#totalDiscount').text().replace(/,/g,'')),
	          useP  = Number($('#usedPoints').val())||0,
	          earn  = Math.floor((orig-coup-useP)*0.05),
	          pay   = orig-coup-useP;
	    $('#fsOriginal').text(orig.toLocaleString());
	    $('#fsCoupon').text(coup.toLocaleString());
	    $('#fsUsePoints').text(useP.toLocaleString());
	    $('#fsEarn').text(earn.toLocaleString());
	    $('#fsPay').text(pay.toLocaleString());
	  }

  function enforceCoupons() {
	    const used = $('select.coupon-select').map((i,s)=>s.value).get().filter(v=>v);
	    $('select.coupon-select').each(function(){
	      const my = this.value;
	      $(this).find('option').each(function(){
	        const v = this.value;
	        $(this).prop('disabled', v && used.includes(v) && v!==my);
	      });
	    });
	  }


  // --- 2) 쿠폰 셀렉트 초기화 & change 바인딩 ---
  $('select.coupon-select').each(function(){
    const $sel = $(this),
          $tr  = $sel.closest('tr'),
          pid  = $tr.find('input[name="productId"]').val();
    $.getJSON(`${ctx}/couponList`, { userId, productId: pid })
      .done(list => {
        $sel.empty()
            .append('<option value="" data-discount="0" data-percent="false">쿠폰 없음</option>');
        list.forEach(c => {
          const pct = c.discountAmount <= 100;
          $sel.append(`
            <option value="${c.couponId}"
                    data-discount="${c.discountAmount}"
                    data-percent="${pct}">
              ${c.name} — ${c.discountAmount}${pct?'%':'원'}
            </option>`);
        });
        // 로드 직후 계산·바인딩
        calcRow($tr);
        enforceCoupons();
        calcSummary();
        updateFinalSummary();
        $sel.on('change', ()=>{
          calcRow($tr);
          enforceCoupons();
          calcSummary();
          updateFinalSummary();
        });
      });
  });

// 6) 초기 실행
$('tbody tr').each(function(){ calcRow($(this)); });
enforceCoupons();
calcSummary();
updateFinalSummary();

$('#useAllPointsBtn').click(()=>{
    $('#usedPoints').val(totalPoint);
    updateFinalSummary();
  });
  $('#usedPoints').on('input change', function(){
    this.value = this.value.replace(/[^0-9]/g,'');
    updateFinalSummary();
  });
});


$('#sameAsUser').change(function(){
	  if (this.checked) {
	    // 1) 이름
	    $('#receiverName').val('${user.name}');
	    // 2) 전화번호 분리
	    const parts = '${user.phone}'.split('-');
	    $('#phone1').val(parts[0] || '');
	    $('#phone2').val(parts[1] || '');
	    $('#phone3').val(parts[2] || '');
	    // 3) 주소
	    $('#address1').val('${user.address1}');
	    $('#address2').val('${user.address1Detail}');
	  } else {
	    // 해제 시 초기화
	    $('#receiverName').val('');
	    $('#phone1, #phone2, #phone3').val('');
	    $('#address1, #address2').val('');
	  }
	});

	$(function(){
		  const box = $('#addressListBox');

		  // 1) “배송지 변경” 클릭 → 팝업 토글 & 위치 계산
		  $('#changeAddressBtn').on('click', function(e){
		    e.preventDefault();
		    const btn    = $(this);
		    const ofs    = btn.position();        // container 기준 버튼 위치
		    const height = btn.outerHeight();     // 버튼 높이
		    box.css({
		      position: 'absolute',
		      top:    ofs.top + height + 5 + 'px',
		      left:   ofs.left + 'px'
		    }).toggle();
		  });

		  // 2) 팝업 내 주소 선택
		  $('#addressListUl').on('click', 'li', function(){
		    $('#address1').val($(this).data('base'));
		    $('#address2').val($(this).data('detail'));
		    box.hide();
		  });

		  // 3) 팝업 닫기
		  $('#closeAddressBox').on('click', function(){
		    box.hide();
		  });

		  // 4) “주소 찾기” 버튼(다음 우편번호 API)
		  $('#searchZipBtn').on('click', function(e){
		    e.preventDefault();
		    new daum.Postcode({
		      oncomplete: function(data) {
		        const baseAddr = data.roadAddress || data.jibunAddress;
		        $('#address1').val(baseAddr);
		        $('#address2').val('').focus();
		      }
		    }).open();
		  });
		});
		$(function(){
			  // 모달 열기
			  $('#changeAddressBtn').on('click', function(e){
			    e.preventDefault();
			    $('#modalOverlay').addClass('show');
			  });

			  // 주소 선택하면 폼에 채우고 모달 닫기
			  $('#addressListUl').on('click', 'li', function(){
			    $('#address1').val($(this).data('base'));
			    $('#address2').val($(this).data('detail'));
			    $('#modalOverlay').removeClass('show');
			  });

			  // 닫기 버튼
			  $('#closeAddressBox').on('click', function(){
			    $('#modalOverlay').removeClass('show');
			  });
			});

</script>

<script>

function makeOrderItemsJson() {
	  const items = $('tbody tr').toArray().map(tr => {
	    const $r = $(tr);
	    const pid = $r.find('input[name="productId"]').val();
	    if (!pid) return null;                   // productId 없으면 null 반환
	    return {
	      product_id: Number(pid),
	      quantity:   Number($r.find('input[name="quantity"]').val()),
	      status:     'PENDING',
	      coupon_id:  $r.find('select.coupon-select').val() || null,
	      color:      $r.find('input[name="color"]').val(),
	      size:       $r.find('input[name="size"]').val()
	    };
	  })
	  .filter(item => item);                     // null인 항목 제거
	  return JSON.stringify(items);
	}

  
  $(function(){
	const userid     = '${user.userId}';   
    const PENDING_ORDER_ID      = '${pendingOrderId}';
    const basePath              = '${pageContext.request.contextPath}';
    const customerName          = '${user.name}';
    const customerEmail         = '${user.email}';
    const customerMobilePhone   = '${user.phone}'.replace(/\D/g,'');
    const EXTERNAL_ORDER_ID = 'ORDER_' + PENDING_ORDER_ID;

    function getAmount(){
      return parseInt($('#fsPay').text().replace(/[^0-9]/g,''), 10) || 0;
    }

    const GATEWAY_KEY = 'test_gck_docs_Ovk5rk1EwkEbP0W43n07xlzm';
    const tossPayments = TossPayments(GATEWAY_KEY);
    const widgets = tossPayments.widgets({ customerKey: TossPayments.ANONYMOUS });

    (async () => {
      const amt = getAmount();
      if (amt <= 0) return;
      try {
        await widgets.setAmount({ currency:'KRW', value:amt });
        await widgets.renderPaymentMethods({ selector:'#payment-method', variantKey:'DEFAULT' });
        await widgets.renderAgreement({ selector:'#agreement', variantKey:'AGREEMENT' });
      } catch(e) {
        console.error('위젯 초기화 실패', e);
        alert('결제 위젯 로딩에 실패했습니다.');
      }
    })();

    $('#coupon-box').on('change', async function(){
      const discount = this.checked ? parseInt($(this).data('discount'),10)||0 : 0;
      const newAmt = Math.max(0, getAmount() - discount);
      try { await widgets.setAmount({ currency:'KRW', value:newAmt }); }
      catch(e) { console.error('금액 업데이트 실패', e); }
    });

    $('#payBtn').on('click', async e => {
    	  e.preventDefault();
    	  const amt = getAmount();
    	  if (amt <= 0) return alert('유효한 결제 금액이 아닙니다.');

    	  // 폼 데이터
    	  const receiverName    = $('#receiverName').val();
    	  const receiverPhone   = [$('#phone1').val(),$('#phone2').val(),$('#phone3').val()].join('-');
    	  const receiverAddress = $('#address1').val() + ' ' + $('#address2').val();
    	  const deliveryRequest = $('#deliveryRequest').val();
    	  const couponDiscount = Number($('#fsCoupon').text().replace(/[^0-9]/g, ''));
    	  const usedPoints = Number($('#fsUsePoints').text().replace(/[^0-9]/g,'')) || 0;
          const pay = Number($('#fsPay').text().replace(/[^0-9]/g,'')) || 0;
          const earnedPoints = Math.floor(pay * 0.05);

    	  // 모든 주문정보를 하나로 묶음
    	  const orderInfo = JSON.stringify({
    	    total_price:      amt,               // total_price
    	    delivery_request: deliveryRequest,   // delivery_request
    	    payment_method:   'TOSS',            // payment_method
    	    user_id:          userid,            // user_id
    	    receiver_name:    receiverName,      // receiver_name
    	    receiver_phone:   receiverPhone,     // receiver_phone
    	    receiver_address: receiverAddress,   // receiver_address
    	    used_point:       usedPoints,        // used_point
    	    coupon_discount:  couponDiscount     // coupon_discount
    	  });
    	  
    	  const pointPayload = JSON.stringify({
    	        used:   -usedPoints,   // 사용한 포인트는 음수
    	        earned:  earnedPoints  // 적립될 포인트는 양수
    	      });
    	  
    	  const orderItemsJson = makeOrderItemsJson();
    	  
    	  
    	  const urlParams       = new URLSearchParams(window.location.search);
    	  const selectedCartIds = urlParams.getAll('cartId');
    	  const cartIdsJson = JSON.stringify(selectedCartIds);

    	  try {
    	    await widgets.setAmount({ currency:'KRW', value:amt });
    	    await widgets.requestPayment({
    	      orderId:             EXTERNAL_ORDER_ID,
    	      orderName:           '주문 ' + PENDING_ORDER_ID,
    	      successUrl:          window.location.origin + basePath + '/paymentSuccess',
    	      failUrl:             window.location.origin + basePath + '/paymentFail',
    	      customerName,
    	      customerEmail,
    	      customerMobilePhone,
    	      windowTarget:        'self',
    	      metadata: {
    	        order_info: orderInfo,
    	        point: pointPayload,
    	        order_items: orderItemsJson,
    	        cart_ids: cartIdsJson
    	      }
    	    });
    	  } catch(err) {
    	    console.error('결제 요청 실패', err);
    	    alert('결제 요청 중 오류가 발생했습니다.');
    	  }
    	});

  });
</script>


</body>
</html>
