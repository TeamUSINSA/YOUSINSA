<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <title>사이드바</title>
    <style>
        body {
            margin: 0;
            padding: 40px;
            font-family: '맑은 고딕', sans-serif;
            background-color: #f9f9f9;
        }

        .sidebar {
            width: 200px;
            background-color: #fff;
            padding: 20px 15px;
            border-radius: 8px;
            box-sizing: border-box;
        }

        .sidebar h4 {
            margin: 20px 0 10px;
            font-size: 14px;
            padding-bottom: 5px;
            border-bottom: 1px solid #ddd;
            color: #444;
        }

        .sidebar ul {
            list-style: none;
            padding: 0;
            margin: 0;
        }

        .sidebar li {
            margin: 6px 0;
        }

        .sidebar a {
            display: block;
            color: #333;
            font-size: 13px;
            text-decoration: none;
            padding: 6px 8px;
            border-radius: 4px;
            transition: background-color 0.2s;
        }

        .sidebar a:hover {
            background-color: #f0f0f0;
        }
        .content {
                    flex: 1;
                    max-width: 900px;
                    box-sizing: border-box;
                }
    </style> 
</head>

<body>

    <div class="sidebar">
        <h4>주문 및 환불/교환 처리</h4>
        <ul>
            <li><a href="#">주문내역 조회</a></li>
            <li><a href="#">반품 접수</a></li>
            <li><a href="#">교환 접수</a></li>
        </ul>

        <h4>상품 관리</h4>
        <ul>
            <li><a href="#">상품검색</a></li>
            <li><a href="#">상품 등록</a></li>
            <li><a href="#">카테고리 관리</a></li>
        </ul>

        <h4>회원/고객 관리</h4>
        <ul>
            <li><a href="#">회원검색</a></li>
            <li><a href="#">문의 창</a></li>
            <li><a href="#">신고 관리</a></li>
        </ul>

        <h4>마케팅 및 프로모션</h4>
        <ul>
            <li><a href="#">쿠폰 보기</a></li>
            <li><a href="#">쿠폰 등록</a></li>
        </ul>

        <h4>매출 분석</h4>
        <ul>
            <li><a href="#">매출 조회</a></li>
        </ul>
    </div>

</body>

</html>