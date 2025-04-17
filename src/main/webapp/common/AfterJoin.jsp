<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    String id = request.getParameter("id");
%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8" />
  <title>회원가입 이후</title>
  <script src="https://cdn.tailwindcss.com"></script>
  <style>
    .menu-item:hover {
      background-color: #f5f5f5;
    }
    .group:hover .group-hover\:block {
      display: block;
    }
  </style>
</head>
<body class="bg-white text-sm text-gray-700">
  <!-- ✅ 전체 카테고리 사이드 메뉴 -->
  <div id="sideMenu" class="fixed top-0 left-0 h-full w-72 bg-white shadow-lg transform -translate-x-full transition-transform duration-300 z-50 overflow-y-auto">
    <div class="p-4 text-sm">
      <h2 class="text-lg font-bold mb-4">전체 카테고리</h2>
      <div class="mb-4">
        <input type="text" placeholder="카테고리 검색" class="w-full border px-3 py-2 rounded text-sm">
      </div>
      <div class="mb-4">
        <h3 class="font-semibold text-gray-800 mb-2">베스트</h3>
        <ul class="space-y-1 text-gray-600">
          <li><a href="#" class="block px-2 py-1 hover:bg-gray-100">인기상품</a></li>
          <li><a href="#" class="block px-2 py-1 hover:bg-gray-100">후기많은 상품</a></li>
        </ul>
      </div>
      <div class="mb-4">
        <h3 class="font-semibold text-gray-800 mb-2">신상품</h3>
        <ul class="space-y-1 text-gray-600">
          <li><a href="#" class="block px-2 py-1 hover:bg-gray-100">이번주 신상</a></li>
          <li><a href="#" class="block px-2 py-1 hover:bg-gray-100">이달의 신상</a></li>
        </ul>
      </div>
      <div class="mb-4">
        <h3 class="font-semibold text-gray-800 mb-2">추천상품</h3>
        <ul class="space-y-1 text-gray-600">
          <li><a href="#" class="block px-2 py-1 hover:bg-gray-100">유신사 추천</a></li>
        </ul>
      </div>
      <div class="mb-4">
        <h3 class="font-semibold text-gray-800 mb-2">상의</h3>
        <ul class="space-y-1 text-gray-600">
          <li><a href="#" class="block px-2 py-1 hover:bg-gray-100">티셔츠</a></li>
          <li><a href="#" class="block px-2 py-1 hover:bg-gray-100">셔츠</a></li>
          <li><a href="#" class="block px-2 py-1 hover:bg-gray-100">니트</a></li>
        </ul>
      </div>
      <div class="mb-4">
        <h3 class="font-semibold text-gray-800 mb-2">하의</h3>
        <ul class="space-y-1 text-gray-600">
          <li><a href="#" class="block px-2 py-1 hover:bg-gray-100">청바지</a></li>
          <li><a href="#" class="block px-2 py-1 hover:bg-gray-100">슬랙스</a></li>
          <li><a href="#" class="block px-2 py-1 hover:bg-gray-100">조거팬츠</a></li>
        </ul>
      </div>
      <div class="mb-4">
        <h3 class="font-semibold text-gray-800 mb-2">아우터</h3>
        <ul class="space-y-1 text-gray-600">
          <li><a href="#" class="block px-2 py-1 hover:bg-gray-100">자켓</a></li>
          <li><a href="#" class="block px-2 py-1 hover:bg-gray-100">코트</a></li>
          <li><a href="#" class="block px-2 py-1 hover:bg-gray-100">패딩</a></li>
        </ul>
      </div>
      <div class="mb-4">
        <h3 class="font-semibold text-gray-800 mb-2">신발 / 가방</h3>
        <ul class="space-y-1 text-gray-600">
          <li><a href="#" class="block px-2 py-1 hover:bg-gray-100">스니커즈</a></li>
          <li><a href="#" class="block px-2 py-1 hover:bg-gray-100">로퍼</a></li>
          <li><a href="#" class="block px-2 py-1 hover:bg-gray-100">백팩</a></li>
          <li><a href="#" class="block px-2 py-1 hover:bg-gray-100">크로스백</a></li>
        </ul>
      </div>
    </div>
  </div>

  <!-- ✅ 네비게이션 바 -->
  <div class="flex items-center justify-between px-4 py-3 border-b relative">
    <div class="flex items-center space-x-4">
      <button id="menuToggle" class="text-2xl">☰</button>
      <div class="relative group">
        <a href="#" class="menu-item px-4 py-2 rounded">상의</a>
        <div class="absolute top-full left-0 hidden group-hover:block bg-white shadow-md w-40 z-10">
          <a href="#" class="block px-4 py-2 hover:bg-gray-100">티셔츠</a>
          <a href="#" class="block px-4 py-2 hover:bg-gray-100">셔츠</a>
          <a href="#" class="block px-4 py-2 hover:bg-gray-100">니트</a>
        </div>
      </div>
      <div class="relative group">
        <a href="#" class="menu-item px-4 py-2 rounded">하의</a>
        <div class="absolute top-full left-0 hidden group-hover:block bg-white shadow-md w-40 z-10">
          <a href="#" class="block px-4 py-2 hover:bg-gray-100">청바지</a>
          <a href="#" class="block px-4 py-2 hover:bg-gray-100">슬랙스</a>
          <a href="#" class="block px-4 py-2 hover:bg-gray-100">조거팬츠</a>
        </div>
      </div>
      <div class="relative group">
        <a href="#" class="menu-item px-4 py-2 rounded">아우터</a>
        <div class="absolute top-full left-0 hidden group-hover:block bg-white shadow-md w-40 z-10">
          <a href="#" class="block px-4 py-2 hover:bg-gray-100">자켓</a>
          <a href="#" class="block px-4 py-2 hover:bg-gray-100">코트</a>
          <a href="#" class="block px-4 py-2 hover:bg-gray-100">패딩</a>
        </div>
      </div>
      <div class="relative group">
        <a href="#" class="menu-item px-4 py-2 rounded">신발</a>
        <div class="absolute top-full left-0 hidden group-hover:block bg-white shadow-md w-40 z-10">
          <a href="#" class="block px-4 py-2 hover:bg-gray-100">스니커즈</a>
          <a href="#" class="block px-4 py-2 hover:bg-gray-100">부츠</a>
          <a href="#" class="block px-4 py-2 hover:bg-gray-100">샌들</a>
        </div>
      </div>
      <div class="relative group">
        <a href="#" class="menu-item px-4 py-2 rounded">가방</a>
        <div class="absolute top-full left-0 hidden group-hover:block bg-white shadow-md w-40 z-10">
          <a href="#" class="block px-4 py-2 hover:bg-gray-100">백팩</a>
          <a href="#" class="block px-4 py-2 hover:bg-gray-100">숄더백</a>
          <a href="#" class="block px-4 py-2 hover:bg-gray-100">크로스백</a>
        </div>
      </div>
      <div class="relative group">
        <a href="#" class="menu-item px-4 py-2 rounded">베스트</a>
        <div class="absolute top-full left-0 hidden group-hover:block bg-white shadow-md w-40 z-10">
          <a href="#" class="block px-4 py-2 hover:bg-gray-100">인기상품</a>
        </div>
      </div>
      <div class="relative group">
        <a href="#" class="menu-item px-4 py-2 rounded">신상품</a>
      </div>
      <div class="relative group">
        <a href="#" class="menu-item px-4 py-2 rounded">추천상품</a>
      </div>
    </div>
    <div class="ml-auto">
      <div class="flex items-center">
        <input type="text" placeholder="검색어를 입력하세요." class="border px-3 py-1 rounded w-60 text-sm">
        <button class="ml-1 text-lg">🔍</button>
      </div>
    </div>
  </div>

  <!-- ✅ 회원가입 완료 메인 콘텐츠 -->
  <main class="flex flex-col items-center justify-center py-24 px-4">
    <div class="border rounded-lg px-6 py-10 w-full max-w-lg shadow-sm text-center">
      <h2 class="text-2xl font-semibold mb-6">회원가입 완료</h2>
      <img src="https://cdn-icons-png.flaticon.com/512/3159/3159066.png" alt="축하 아이콘" class="w-16 h-16 mx-auto mb-4" />
      <p class="mb-2 text-sm"><%= id %> 님의 회원가입이 완료되었습니다</p>
      <p class="text-sm mb-6">회원가입을 축하드립니다</p>
      <div class="flex justify-center gap-4">
        <a href="login.jsp" class="bg-black text-white text-xs px-4 py-2 rounded">로그인 하러 가기</a>
        <a href="index.jsp" class="bg-black text-white text-xs px-4 py-2 rounded">메인화면으로</a>
      </div>
    </div>
  </main>

  <!-- ✅ 푸터 -->
  <footer class="bg-white border-t text-sm text-gray-700">
    <div class="max-w-7xl mx-auto px-4 py-8">
      <div class="flex flex-col md:flex-row justify-between mb-6">
        <div>
          <h3 class="font-bold text-gray-900 mb-1">고객센터 1234-1234</h3>
          <p class="text-xs text-gray-500 mb-2">운영시간: 평일 09:00 ~ 18:00 (점심시간 12:00 ~ 13:00 제외)</p>
          <div class="space-x-2">
            <button class="bg-black text-white text-xs px-3 py-1 rounded">Q&A</button>
            <button class="bg-black text-white text-xs px-3 py-1 rounded">1:1 문의</button>
          </div>
        </div>
        <div class="flex items-center justify-end mt-4 md:mt-0 text-xs text-gray-500 space-x-2">
          <a href="#" class="hover:underline">개인정보처리방침</a> |
          <a href="#" class="hover:underline">이용약관</a> |
          <a href="#" class="hover:underline">분쟁해결기준</a> |
          <a href="#" class="hover:underline">안전거래센터</a> |
          <a href="#" class="hover:underline">결제대행위탁사</a>
        </div>
      </div>
      <div class="text-[11px] text-gray-500 space-y-1">
        <p>상호명: ****** &nbsp;&nbsp; 사업장소재지: 서울특별시 금천구 가산디지털1로 70 호서벤처타워 9층 &nbsp;&nbsp; 팩스:070-1234-1234 &nbsp;&nbsp; 사업자등록번호: ***-**-***** &nbsp;&nbsp; 통신판매업신고 2025-서울금천-1710</p>
        <p>전화번호: ****-**** &nbsp;&nbsp; 이메일: daecham124@gmail.com &nbsp;&nbsp; 대표: 신대혁</p>
        <p>해당 사이트에서 판매되는 모든 상품에 관한 모든 민형의 책임은 유신사에 있습니다.</p>
        <p class="pt-2">© YOUSINSA Corp. All rights reserved.</p>
      </div>
      <div class="flex justify-end mt-6 space-x-2 opacity-60">
        <img src="https://cdn-icons-png.flaticon.com/512/25/25231.png" class="w-5 h-5" alt="공정거래위원회">
        <img src="https://cdn-icons-png.flaticon.com/512/732/732221.png" class="w-5 h-5" alt="결제로고">
        <img src="https://cdn-icons-png.flaticon.com/512/888/888879.png" class="w-5 h-5" alt="인증로고">
      </div>
    </div>
  </footer>
</body>
</html>
