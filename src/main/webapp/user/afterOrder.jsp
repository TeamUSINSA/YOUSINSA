<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<title>결제 완료</title>
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

	<!-- ✅ 헤더 include -->
	  <%@ include file="/common/header.jsp"%>
 
  <%@ include file="/common/navigation_with_sidebar.jsp"%>

	<!-- ✅ 결제 완료 메인 콘텐츠 -->
	<main
		class="max-w-md mx-auto my-20 p-10 border border-gray-300 rounded-lg text-center bg-white">
		<h2 class="text-xl font-bold mb-6">결제가 완료되었습니다</h2>
		<div class="mb-6">
			<img src="https://cdn-icons-png.flaticon.com/512/1170/1170678.png"
				alt="결제완료" class="mx-auto w-20 h-20">
		</div>
		<div class="flex justify-center space-x-4">
			<a href="/main.jsp"
				class="border px-4 py-2 text-sm bg-gray-100 hover:bg-gray-200">메인페이지로
				돌아가기</a> <a href="/orderStatus.jsp"
				class="border px-4 py-2 text-sm bg-gray-100 hover:bg-gray-200">주문/배송
				조회</a>
		</div>
	</main>

	<!-- ✅ 푸터 include -->
	<%@ include file="/common/footer.jsp"%>

	<!-- ✅ JS 스크립트 (필요 시 header.jsp에 병합 가능) -->
	<script>
    let isLoggedIn = false;
    let notifications = 0;

    const loginBtn = document.getElementById("loginBtn");
    const menuToggle = document.getElementById("menuToggle");
    const sideMenu = document.getElementById("sideMenu");

    loginBtn?.addEventListener("click", () => {
      isLoggedIn = !isLoggedIn;
      loginBtn.textContent = isLoggedIn ? "로그아웃" : "로그인";
    });

    menuToggle?.addEventListener("mouseenter", () => {
      sideMenu.classList.remove("-translate-x-full");
    });

    sideMenu?.addEventListener("mouseleave", () => {
      sideMenu.classList.add("-translate-x-full");
    });

    document.getElementById('all-agree')?.addEventListener('change', function () {
      const checked = this.checked;
      document.querySelectorAll('.terms').forEach(checkbox => {
        checkbox.checked = checked;
      });
    });
  </script>
</body>
</html>
