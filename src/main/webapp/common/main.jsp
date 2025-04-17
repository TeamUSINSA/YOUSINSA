<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>유신사 베스트 컬렉션</title>
</head>
<body>

    <!-- 메인 배너 -->
    <a href="#">
        <img src="img1.jpg" alt="메인 배너" style="width:100%; display:block;">
    </a>

    <!-- 타이틀과 설명 -->
    <a href="#" style="text-decoration: none; color: black;">
        <div style="text-align: center; margin: 40px 0;">
            <h2>유신사 베스트 컬렉션</h2>
            <p>소란스럽지 않은 일상 속 조용히 빛나는 것들<br>작은 디테일 하나까지 담은 유신사의 베스트 아이템을 만나보세요.</p>
        </div>
    </a>

    <!-- 상품 목록 -->
    <div style="display: flex; justify-content: center; gap: 40px; flex-wrap: wrap;">
        <a href="#" style="text-align: center; text-decoration: none; color: black; width: 200px;">
            <img src="img2.jpg" alt="브러쉬드 가죽 로퍼" style="width: 100%;"><br>
            <div>브러쉬드 가죽 로퍼<br>₩120,000</div>
        </a>
        <a href="#" style="text-align: center; text-decoration: none; color: black; width: 200px;">
            <img src="img3.jpg" alt="유신사 무지 맨투맨" style="width: 100%;"><br>
            <div>유신사 무지 맨투맨<br>₩20,000</div>
        </a>
        <a href="#" style="text-align: center; text-decoration: none; color: black; width: 200px;">
            <img src="img4.jpg" alt="포셋트 투고" style="width: 100%;"><br>
            <div>포셋트 투고<br>₩100,000</div>
        </a>
        <a href="#" style="text-align: center; text-decoration: none; color: black; width: 200px;">
            <img src="img5.jpg" alt="엘라스틱 스니커즈" style="width: 100%;"><br>
            <div>엘라스틱 스니커즈<br>₩50,000</div>
        </a>
    </div>

    <!-- 중간 배너 -->
    <a href="#">
        <img src="img6.jpg" alt="중간 배너" style="width:100%; display:block;">
    </a>

    <!-- 추천 타이틀 -->
    <a href="#" style="text-decoration: none; color: black;">
        <div style="text-align: center; margin: 40px 0;">
            <h2>유신사 추천상품</h2>
            <p>익숙하면서도 새로운<br>세련되면서도<br>트렌디한 검소하면서도 품위있는<br>그대를 위한 선택.</p>
        </div>
    </a>

    <!-- 추천 상품 목록 -->
    <div style="display: flex; justify-content: center; gap: 40px; flex-wrap: wrap;">
        <a href="#" style="text-align: center; text-decoration: none; color: black; width: 200px;">
            <img src="img7.jpg" alt="브러쉬드 가죽 로퍼" style="width: 100%;"><br>
            <div>브러쉬드 가죽 로퍼<br>₩120,000</div>
        </a>
        <a href="#" style="text-align: center; text-decoration: none; color: black; width: 200px;">
            <img src="img8.jpg" alt="유신사 무지 맨투맨" style="width: 100%;"><br>
            <div>유신사 무지 맨투맨<br>₩20,000</div>
        </a>
        <a href="#" style="text-align: center; text-decoration: none; color: black; width: 200px;">
            <img src="img9.jpg" alt="포셋트 투고" style="width: 100%;"><br>
            <div>포셋트 투고<br>₩100,000</div>
        </a>
        <a href="#" style="text-align: center; text-decoration: none; color: black; width: 200px;">
            <img src="img10.jpg" alt="엘라스틱 스니커즈" style="width: 100%;"><br>
            <div>엘라스틱 스니커즈<br>₩50,000</div>
        </a>
    </div>

    <!-- 2 x 2 카드 구성 -->
    <div style="display: grid; grid-template-columns: repeat(2, 1fr); gap: 20px; max-width: 1500px; margin: 60px auto;">
        <a href="#" style="text-decoration: none; color: black; position: relative; display: block;">
            <img src="img1.jpg" alt="2025 신상 컬렉션" style="width: 100%;">
            <div style="position: absolute; top: 20px; left: 20px; color: white;">
                <strong>2025 신상 컬렉션</strong><br>
                개성에 대한 관심<br>
                <span>구매하기</span>
            </div>
        </a>
        <a href="#" style="text-decoration: none; color: black; position: relative; display: block;">
            <img src="img1.jpg" alt="현대적인 감성" style="width: 100%;">
            <div style="position: absolute; top: 20px; left: 20px; color: white;">
                <strong>현대적인 감성</strong><br>
                가방의 새로운 아이콘<br>
                <span>구매하기</span>
            </div>
        </a>
        <a href="#" style="text-decoration: none; color: black; position: relative; display: block;">
            <img src="img1.jpg" alt="과감한 표현" style="width: 100%;">
            <div style="position: absolute; top: 20px; left: 20px; color: white;">
                <strong>과감한 표현</strong><br>
                새로운 시각의 슈즈<br>
                <span>구매하기</span>
            </div>
        </a>
        <a href="#" style="text-decoration: none; color: black; position: relative; display: block;">
            <img src="img1.jpg" alt="예술성과 혁신" style="width: 100%;">
            <div style="position: absolute; top: 20px; left: 20px; color: white;">
                <strong>예술성과 혁신</strong><br>
                Signs of reality<br>
                <span>구매하기</span>
            </div>
        </a>
    </div>

</body>
</html>
