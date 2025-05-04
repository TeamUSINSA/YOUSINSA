<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

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
<jsp:include page="/header" />

  <!-- ✅ 회원가입 완료 메인 콘텐츠 -->
  <main class="flex flex-col items-center justify-center py-24 px-4">
    <div class="border rounded-lg px-6 py-10 w-full max-w-lg shadow-sm text-center">
      <h2 class="text-2xl font-semibold mb-6">회원가입 완료</h2>
      <img src="https://cdn-icons-png.flaticon.com/512/3159/3159066.png" alt="축하 아이콘" class="w-16 h-16 mx-auto mb-4" />
      <p class="mb-2 text-sm">${sessionScope.name}님의 회원가입이 완료되었습니다</p>
      <p class="text-sm mb-6">회원가입을 축하드립니다</p>
      <div class="flex justify-center gap-4">
        <a href="login" class="bg-black text-white text-xs px-4 py-2 rounded">로그인 하러 가기</a>
        <a href="main" class="bg-black text-white text-xs px-4 py-2 rounded">메인화면으로</a>
      </div>
    </div>
  </main>

 <jsp:include page="footer.jsp"/>
</body>
</html>
