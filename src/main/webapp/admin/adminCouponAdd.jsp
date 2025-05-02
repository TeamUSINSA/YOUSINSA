<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8" />
  <title>쿠폰 등록</title>
  <jsp:include page="../common/header.jsp"/>
  <jsp:include page="adminSideBarStyle.jsp"/>
  <style>
    body {
      margin: 0;
      font-family: 'Pretendard', sans-serif;
      background-color: #f8f8f8;
    }

    h2 {
      font-size: 24px;
      font-weight: bold;
      margin-bottom: 30px;
      text-align: center;
    }

    .content-wrapper {
      display: flex;
      gap: 20px;
      margin: 20px;
    }

    .sidebar {
      width: 300px;
    }

    .container {
      background-color: white;
      padding: 30px;
      border-radius: 12px;
      box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
      width: 100%;
      max-width: 1200px;
      margin: 20px;
      flex-grow: 1;
    }

    .form-group {
      margin-bottom: 20px;
    }

    label {
      display: block;
      margin-bottom: 6px;
      font-weight: 500;
    }

    input[type="text"],
    input[type="date"],
    select {
      width: 100%;
      padding: 10px;
      border: 1px solid #ccc;
      border-radius: 6px;
      box-sizing: border-box;
    }

    .radio-group {
      display: flex;
      flex-direction: column;
      gap: 10px;
    }

    .radio-inline {
      display: flex;
      align-items: center;
      gap: 10px;
    }

    .radio-inline select {
      flex-grow: 1;
    }

    .date-range {
      display: flex;
      gap: 10px;
    }

    .discount-inline {
      display: flex;
      align-items: center;
      gap: 20px;
    }

    .discount-inline input[type="text"] {
      width: 80px;
    }

    button {
      width: 100%;
      padding: 12px;
      background-color: #000;
      color: #fff;
      font-size: 16px;
      font-weight: bold;
      border: none;
      border-radius: 8px;
      cursor: pointer;
      transition: background 0.3s ease;
    }

    button:hover {
      background-color: #333;
    }
  </style>
</head>
<body>
  <div class="content-wrapper">
    <jsp:include page="adminSideBar.jsp" />
    <div class="container">
      <h2>쿠폰 등록</h2>
      <form id="couponForm" method="post" action="${pageContext.request.contextPath}/adminCouponAdd">
        <input type="hidden" name="active" value="1">

        <div class="form-group">
          <label for="name">쿠폰명</label>
          <input type="text" id="name" name="name" required>
        </div>

        <div class="form-group">
          <label>쿠폰 형식</label>
          <div class="radio-group">
            <label class="radio-inline">
              <input type="radio"id="auto" checked> 자동쿠폰
              <select id="autoCouponSelect" name="type">
                <option>선택</option>
                <option value="couponJoin">가입쿠폰</option>
                <option value="couponBirthday">생일쿠폰</option>
                <option value="couponOver5">5만원 이상</option>
                <option value="couponOver10">10만원 이상</option>
                <option value="couponOver50">50만원 이상</option>
                <option value="couponOver100">100만원 이상</option>
              </select>
            </label>
            <label class="radio-inline">
              <input type="radio" name="type" id="download" value="download"> 고객 다운로드
            </label>
          </div>
        </div>

        <div class="form-group">
          <label>사용기한</label>
          <div class="date-range">
            <input type="date" name="startDate" id="startDate" required>
            <span>~</span>
            <input type="date" name="endDate" id="endDate" required>
          </div>
        </div>

        <div class="form-group">
          <label>할인</label>
          <div class="discount-inline">
            <label class="radio-inline">
              <input type="radio" name="discount" id="amount" checked> 금액
              <input type="text" id="amountValue" name="discount_amount"> 원
            </label>
            <label class="radio-inline">
              <input type="radio" name="discount" id="rate"> 비율
              <input type="text" id="rateValue"> %
            </label>
          </div>
        </div>

        <div class="form-group">
          <label for="description">쿠폰 설명</label>
          <input type="text" id="description" name="description" required>
        </div>

        <button type="submit">쿠폰 생성</button>
      </form>
    </div>
  </div>

  <jsp:include page="../common/footer.jsp"/>

  <script>
    const amountRadio = document.getElementById('amount');
    const rateRadio = document.getElementById('rate');
    const amountInput = document.getElementById('amountValue');
    const rateInput = document.getElementById('rateValue');

    function updateDiscountName() {
      if (amountRadio.checked) {
        amountInput.setAttribute("name", "discount_amount");
        rateInput.removeAttribute("name");
      } else if (rateRadio.checked) {
        rateInput.setAttribute("name", "discount_amount");
        amountInput.removeAttribute("name");
      }
    }

    amountRadio.addEventListener('change', updateDiscountName);
    rateRadio.addEventListener('change', updateDiscountName);
    window.addEventListener('DOMContentLoaded', updateDiscountName);

    document.getElementById('couponForm').addEventListener('submit', function (e) {
      const name = document.getElementById('name').value.trim();
      const startDate = document.getElementById('startDate').value;
      const endDate = document.getElementById('endDate').value;
      const description = document.getElementById('description').value.trim();
      const amountValue = amountInput.value.trim();
      const rateValue = rateInput.value.trim();
      const autoSelect = document.getElementById('autoCouponSelect');

      if (!name || !startDate || !endDate || !description) {
        alert("모든 필드를 입력해주세요.");
        e.preventDefault();
        return;
      }

      if (amountRadio.checked && (!amountValue || isNaN(amountValue))) {
        alert("금액에는 숫자를 입력해주세요.");
        e.preventDefault();
      }

      if (rateRadio.checked && (!rateValue || isNaN(rateValue))) {
        alert("비율에는 숫자를 입력해주세요.");
        e.preventDefault();
      }

      if (document.getElementById('auto').checked && autoSelect.value === "") {
        alert("자동 쿠폰의 조건을 선택해주세요.");
        e.preventDefault();
      }
    });
  </script>
</body>
</html>
