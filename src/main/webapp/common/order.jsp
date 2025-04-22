<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>상품주문(결제 이전)</title>
  <style>
    body { font-family: sans-serif; font-size: 14px; color: #333; background: #fff; margin: 0; padding: 0; }
    .container { max-width: 800px; margin: 0 auto; padding: 40px 20px; }
    h2, h3 { font-weight: bold; margin-bottom: 12px; }
    table { width: 100%; border: 1px solid #ccc; border-collapse: collapse; margin-bottom: 24px; }
    th, td { border: 1px solid #ccc; padding: 8px; text-align: left; }
    input, textarea, button, select { font-size: 14px; padding: 6px; }
    .section { margin-bottom: 40px; }
    .flex { display: flex; align-items: center; }
    .space-x-2 > *:not(:last-child) { margin-right: 8px; }
    .btn { background-color: #000; color: #fff; padding: 6px 12px; border: none; border-radius: 4px; cursor: pointer; }
    .right-align { text-align: right; }
    .red { color: red; }
    .bold { font-weight: bold; }
    .coupon-dropdown { margin-top: 6px; }
    #addressListBox { border:1px solid #ccc; margin-top:10px; padding:10px; display:none; }
  </style>
  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
  <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
</head>
<body>
  <div class="container">
    <form action="${pageContext.request.contextPath}/order" method="post">

      <h2>상품 주문</h2>
      <table>
        <thead>
          <tr>
            <th>이미지/상품명</th>
            <th>가격</th>
            <th>쿠폰</th>
            <th>할인가</th>
          </tr>
        </thead>
        <tbody>
          <c:forEach var="item" items="${productList}">
            <tr>
              <td>
                <div class="flex">
                  <img src="${item.image}" alt="상품 이미지" style="width:50px;height:50px;margin-right:8px;">
                  <div>
                    <div class="bold">${item.name}</div>
                    <div>색상: ${item.color}</div>
                    <div>사이즈: ${item.size}</div>
                    <div>수량: ${item.quantity}개</div>
                  </div>
                </div>
                <input type="hidden" name="productId" value="${item.productId}">
                <input type="hidden" name="quantity"  value="${item.quantity}">
                <input type="hidden" name="color"     value="${item.color}">
                <input type="hidden" name="size"      value="${item.size}">
                <input type="hidden" name="unitPrice" value="${item.price}">
              </td>
              <td>${item.price}원</td>
              <td>
                <button type="button" class="btn apply-coupon-btn" data-product-id="${item.productId}">
                  쿠폰 사용
                </button>
                <div class="coupon-dropdown" style="display:none;">
                  <select class="coupon-select" name="couponId">
                    <option value="">적용할 쿠폰을 선택하세요</option>
                  </select>
                </div>
              </td>
              <td class="red bold">${item.discountPrice}원</td>
            </tr>
          </c:forEach>
        </tbody>
      </table>

      <h2>결제 요약</h2>
      <table>
        <tr>
          <td>총 가격</td><td>할인 가격</td><td colspan="2">총 결제금액</td>
        </tr>
        <tr>
          <td>${order.totalPrice}원</td>
          <td class="red">${order.discountAmount}원</td>
          <td colspan="2" class="red bold">${order.finalPrice}원</td>
        </tr>
      </table>

      <section>
        <h3>받으시는 분 
          <button type="button" class="btn" id="changeAddressBtn" style="float:right;">배송지 변경</button>
        </h3>
        <table>
          <tr>
            <th>이름</th>
            <td>
              <div class="flex">
                <input type="text" id="receiverName" name="receiverName" style="flex:1;" required>
                <label style="margin-left:10px;">
                  <input type="checkbox" id="sameAsUser"> 주문자와 동일
                </label>
              </div>
            </td>
          </tr>
          <tr>
            <th>연락처</th>
            <td>
              <input type="text" id="phone1" maxlength="3" style="width:60px;" name="phone1"> -
              <input type="text" id="phone2" maxlength="4" style="width:60px;" name="phone2"> -
              <input type="text" id="phone3" maxlength="4" style="width:60px;" name="phone3">
            </td>
          </tr>
          <tr>
            <th>주소</th>
            <td>
              <button type="button" class="btn" id="searchZipBtn" style="margin-bottom:6px;">주소 찾기</button><br>
              <textarea id="address1" name="baseAddress" rows="2" style="width:100%;" placeholder="기본주소" readonly required></textarea>
              <input type="text" id="address2" name="detailAddress" style="width:100%;" placeholder="상세주소" required>
            </td>
          </tr>
        </table>
        <div id="addressListBox">
          <p><strong>주소 선택</strong></p>
          <ul id="addressListUl"></ul>
        </div>
      </section>

      <section class="section">
        <h3>포인트 사용</h3>
        <p>보유 포인트: <strong>${user.point}원</strong></p>
        <div class="flex space-x-2">
          <label for="usedPoints">사용할 포인트</label>
          <input type="text" id="usedPoints" name="usedPoints" style="width:100px;" value="0">
          <button type="button" class="btn" id="useAllPointsBtn">모두사용</button>
        </div>
      </section>

      <section class="section">
        <h3>결제 수단</h3>
        <label><input type="radio" name="paymentMethod" value="PAYCO" checked> PAYCO</label>
      </section>

      <section class="section">
        <h3>결제금액 요약</h3>
        <table>
          <tr>
            <td>상품 금액</td><td class="right-align">${order.totalPrice}원</td>
          </tr>
          <tr>
            <td>할인 금액</td><td class="right-align red">-${order.discountAmount}원</td>
          </tr>
          <tr>
            <td>배송비</td><td class="right-align">3,000원</td>
          </tr>
        </table>
        <table>
          <tr>
            <td class="bold right-align">총결제 금액: ${order.finalPrice}원</td>
          </tr>
          <tr>
            <td class="bold right-align">포인트 적립: ${order.pointReward}원</td>
          </tr>
        </table>
      </section>

      <div style="text-align:center;">
        <button type="submit" class="btn">결제하기</button>
      </div>
    </form>
  </div>

  <script>
    $('#searchZipBtn').click(function() {
      new daum.Postcode({
        oncomplete: function(data) {
          $('#address1').val(data.address);
          $('#address2').focus();
        }
      }).open();
    });

    $('#sameAsUser').change(function() {
      if (this.checked) {
        $.ajax({
          url: '${pageContext.request.contextPath}/order?action=getUserInfo',
          method: 'GET',
          dataType: 'json',
          success: function(data) {
            $('#receiverName').val(data.name);
            var parts = data.phone.split('-');
            $('#phone1').val(parts[0]);
            $('#phone2').val(parts[1]);
            $('#phone3').val(parts[2]);
            $('#address1').val(data.address1);
            $('#address2').val(data.address2);
          }
        });
      } else {
        $('#receiverName,#phone1,#phone2,#phone3,#address1,#address2').val('');
      }
    });

    $('#changeAddressBtn').click(function() {
      $.ajax({
        url: '${pageContext.request.contextPath}/order?action=getAddressList',
        type: 'GET',
        dataType: 'json',
        success: function(list) {
          var ul = $('#addressListUl').empty();
          $.each(list, function(i, addr) {
            ul.append(
              '<li><button type="button" class="selectAddressBtn" ' +
              'data-name="' + addr.receiverName + '" ' +
              'data-phone="' + addr.receiverPhone + '" ' +
              'data-addr1="' + addr.baseAddress + '" ' +
              'data-addr2="' + addr.detailAddress + '">' +
              addr.baseAddress + ' ' + addr.detailAddress +
              '</button></li>'
            );
          });
          $('#addressListBox').show();
        }
      });
    });

    $(document).on('click', '.selectAddressBtn', function() {
      $('#receiverName').val($(this).data('name'));
      var p = $(this).data('phone').split('-');
      $('#phone1').val(p[0]);
      $('#phone2').val(p[1]);
      $('#phone3').val(p[2]);
      $('#address1').val($(this).data('addr1'));
      $('#address2').val($(this).data('addr2'));
      $('#addressListBox').hide();
    });

    $('.apply-coupon-btn').click(function() {
      var $btn = $(this),
          pid = $btn.data('product-id'),
          $dropdown = $btn.next('.coupon-dropdown'),
          $select = $dropdown.find('.coupon-select');

      if ($dropdown.is(':visible')) {
        return $dropdown.hide();
      }
      $.getJSON('${pageContext.request.contextPath}/couponList', { productId: pid })
        .done(function(coupons) {
          $select.empty().append('<option value="">적용할 쿠폰을 선택하세요</option>');
          $.each(coupons, function(i, c) {
            $select.append('<option value="' + c.couponId + '">' +
              c.name + ' - ' + (c.discountAmount <= 100 ? c.discountAmount + '%' : c.discountAmount + '원') +
              '</option>');
          });
          $dropdown.show();
        })
        .fail(function() { alert('쿠폰 정보를 불러오지 못했습니다.'); });
    });

    $('#useAllPointsBtn').click(function() {
      $('#usedPoints').val('${user.point}');
    });
  </script>

  <jsp:include page="/footer.jsp" />
</body>
</html>
