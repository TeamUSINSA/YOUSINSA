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

#addressListBox {
	border: 1px solid #ccc;
	margin-top: 10px;
	padding: 10px;
	display: none;
}
</style>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script
	src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
</head>
<body>


	<jsp:include page="/header" />

	<div class="container">
		<form action="${pageContext.request.contextPath}/order" method="post">

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
				</table>
				<!-- 배송지 입력 부분 바로 아래에 -->
<div id="addressListBox" style="display:none; position:absolute; top:120px; right:20px; background:#fff; border:1px solid #ccc; padding:10px; z-index:100;">
  <h4>저장된 배송지</h4>
  <ul id="addressListUl" style="list-style:none; margin:0; padding:0;">
    <c:if test="${not empty user.address1}">
      <li data-base="${user.address1}" data-detail="${user.address1Detail}" style="padding:5px; cursor:pointer;">
        ${user.address1} ${user.address1Detail}
      </li>
    </c:if>
    <c:if test="${not empty user.address2}">
      <li data-base="${user.address2}" data-detail="${user.address2Detail}" style="padding:5px; cursor:pointer;">
        ${user.address2} ${user.address2Detail}
      </li>
    </c:if>
    <c:if test="${not empty user.address3}">
      <li data-base="${user.address3}" data-detail="${user.address3Detail}" style="padding:5px; cursor:pointer;">
        ${user.address3} ${user.address3Detail}
      </li>
    </c:if>
  </ul>
  <button type="button" id="closeAddressBox" class="btn" style="margin-top:8px;">닫기</button>
</div>

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
				<label><input type="radio" name="paymentMethod" value="TOSS"
					checked> Toss</label> <label><input type="radio"
					name="paymentMethod" value="CARD"> 카드결제</label> <label><input
					type="radio" name="paymentMethod" value="BANK"> 무통장입금</label>
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

			<div style="text-align: center;">
				<button type="submit" class="btn">결제하기</button>
			</div>
		</form>
	</div>

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
		  // 1) “배송지 변경” 팝업 토글
		  $('#changeAddressBtn').on('click', function(){
		    $('#addressListBox').show();
		  });
		  // 2) 주소 선택
		  $('#addressListUl').on('click', 'li', function(){
		    const base   = $(this).data('base'),
		          detail = $(this).data('detail');
		    $('#address1').val(base);
		    $('#address2').val(detail);
		    $('#addressListBox').hide();
		  });
		  // 3) 닫기 버튼
		  $('#closeAddressBox').on('click', function(){
		    $('#addressListBox').hide();
		  });
		});
</script>
</body>
</html>
