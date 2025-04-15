<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <title>쿠폰 등록</title>
    <style>
        body {
            font-family: 'Pretendard', sans-serif;
            margin: 0;
            padding: 0;
            background: linear-gradient(to bottom right, #f2f4f8, #dce1e7);
            display: block;
            height: 100vh;
        }
        h2 {
            width: 500px;
            margin: 50px auto 10px auto;
            text-align: left;
            font-size: 20px;
            font-weight: bold;
        }

        .container {
            background-color: white;
            padding: 40px 50px;
            border-radius: 12px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
            width: 500px;
            margin: 0 auto;
        }

        .form-group {
            margin-bottom: 20px;
        }

        .form-group label {
            display: block;
            margin-bottom: 6px;
            font-weight: 500;
        }

        input[type="text"],
        input[type="date"],
        select {
            width: 100%;
            padding: 8px 10px;
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
            margin-top: 10px;
        }

        .discount-inline .radio-inline {
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .discount-inline input[type="text"] {
            width: 80px;
        }

        .discount-options {
            display: flex;
            flex-direction: column;
            gap: 10px;
            margin-top: 10px;
        }

        .discount-options input[type="text"] {
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
    <h2>쿠폰 등록</h2>
    <div class="container">
        <form id="couponForm">
            <div class="form-group">
                <label for="name">쿠폰명</label>
                <input type="text" id="name" name="name">
            </div>

            <div class="form-group">
                <label>쿠폰 형식</label>
                <div class="radio-group">
                    <label class="radio-inline">
                        <input type="radio" name="type" id="auto" checked>
                        자동쿠폰
                        <select id="autoCouponSelect">
                            <option value="">선택</option>
                            <option>가입쿠폰</option>
                            <option>생일쿠폰</option>
                            <option>5만원 이상</option>
                            <option>10만원 이상</option>
                            <option>50만원 이상</option>
                            <option>100만원 이상</option>
                        </select>
                    </label>
                    <label class="radio-inline">
                        <input type="radio" name="type" id="download">
                        고객 다운로드
                    </label>
                </div>
            </div>

            <div class="form-group">
                <label>사용기한</label>
                <div class="date-range">
                    <input type="date" name="startDate" id="startDate">
                    <span>~</span>
                    <input type="date" name="endDate" id="endDate">
                </div>
            </div>

            <div class="form-group">
                <label>할인</label>
                <div class="discount-inline">
                    <label class="radio-inline">
                        <input type="radio" name="discount" id="amount">
                        금액
                        <input type="text" id="amountValue"> 원
                    </label>
                    <label class="radio-inline">
                        <input type="radio" name="discount" id="rate">
                        비율
                        <input type="text" id="rateValue"> %
                    </label>
                </div>
            </div>

            <div class="form-group">
                <label for="description">쿠폰 설명</label>
                <input type="text" id="description" name="description">
            </div>

            <button type="submit">쿠폰생성</button>
        </form>
    </div>

    <script>
        document.getElementById('couponForm').addEventListener('submit', function (e) {
            const name = document.getElementById('name').value.trim();
            const startDate = document.getElementById('startDate').value;
            const endDate = document.getElementById('endDate').value;
            const description = document.getElementById('description').value.trim();
            const discountType = document.querySelector('input[name="discount"]:checked');
            const amountValue = document.getElementById('amountValue').value.trim();
            const rateValue = document.getElementById('rateValue').value.trim();

            if (!name || !startDate || !endDate || !description || !discountType) {
                alert("모든 필드를 입력해주세요.");
                e.preventDefault();
                return;
            }

            if (discountType.id === "amount") {
                if (!amountValue || isNaN(amountValue)) {
                    alert("금액 항목에는 숫자만 입력해주세요.");
                    e.preventDefault();
                    return;
                }
            }

            if (discountType.id === "rate") {
                if (!rateValue || isNaN(rateValue)) {
                    alert("비율 항목에는 숫자만 입력해주세요.");
                    e.preventDefault();
                    return;
                }
            }

            if (document.getElementById('auto').checked) {
                const autoSelect = document.getElementById('autoCouponSelect');
                if (autoSelect.value === "") {
                    alert("자동쿠폰 옵션을 선택해주세요.");
                    e.preventDefault();
                    return;
                }
            }
        });
    </script>

</body>

</html>