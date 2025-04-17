<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String userId = (String) session.getAttribute("resetUserId");
    if (userId == null) {
        // 세션에 사용자 ID가 없다면 비정상 접근 → 리디렉션
        response.sendRedirect(request.getContextPath() + "/findPassword");
        return;
    }
%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8" />
  <title>비밀번호 변경</title>
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

<main class="flex flex-col items-center justify-center py-24">
  <div class="border rounded-lg px-10 py-10 w-full max-w-lg shadow-sm">
    <h2 class="text-2xl font-semibold text-center mb-10">비밀번호 변경</h2>
    
    <form action="changePassword" method="post" class="space-y-6">
      <!-- 숨겨진 사용자 아이디 전달 -->
      <input type="hidden" name="userId" value="<%= userId %>" />

      <div class="flex items-center">
        <label for="new-password" class="w-32 font-semibold text-black">비밀번호</label>
        <input id="new-password" name="newPassword" type="password" placeholder="비밀번호" class="flex-1 border px-3 py-2 rounded" required />
      </div>

      <div class="flex items-center">
        <label for="confirm-password" class="w-32 font-semibold text-black">비밀번호 확인</label>
        <input id="confirm-password" name="confirmPassword" type="password" placeholder="비밀번호 확인" class="flex-1 border px-3 py-2 rounded" required />
      </div>

      <div class="flex justify-center">
        <button type="submit" class="bg-black text-white px-6 py-2 rounded hover:bg-gray-800">변경하기</button>
      </div>
    </form>
  </div>
</main>

</body>
</html>
