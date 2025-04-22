<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!-- ✅ 네비게이션 바 -->
<div class="flex items-center justify-between px-4 py-3 border-b relative">
  <div class="flex items-center space-x-4">
    <button id="menuToggle" class="text-2xl">☰</button>

    <!-- Hover 드롭다운 메뉴 -->
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

  <!-- 검색창 -->
  <div class="ml-auto flex items-center">
    <input type="text" placeholder="검색어를 입력하세요." class="border px-3 py-1 rounded w-60 text-sm">
    <button class="ml-1 text-lg">🔍</button>
  </div>
</div>

<!-- ✅ 왼쪽 슬라이드 사이드바 -->
<div id="sideMenu"
     class="fixed top-0 left-0 h-full w-72 bg-white shadow-lg transform -translate-x-full transition-transform duration-300 z-50 overflow-y-auto">
  <div class="p-4 text-sm">
    <div class="flex justify-between items-center mb-4">
      <h2 class="text-lg font-bold">전체 카테고리</h2>
      <button id="closeMenu" class="text-lg">X</button>
    </div>

    <div class="mb-4">
      <h3 class="font-semibold text-gray-800 mb-2">인기상품</h3>
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

<!-- ✅ JS: 슬라이드 토글 -->
<script>
  document.addEventListener("DOMContentLoaded", function () {
    const toggleBtn = document.getElementById("menuToggle");
    const closeBtn = document.getElementById("closeMenu");
    const sideMenu = document.getElementById("sideMenu");

    toggleBtn.addEventListener("click", () => {
      sideMenu.classList.remove("-translate-x-full");
      sideMenu.classList.add("translate-x-0");
    });

    closeBtn.addEventListener("click", () => {
      sideMenu.classList.remove("translate-x-0");
      sideMenu.classList.add("-translate-x-full");
    });
  });
</script>
