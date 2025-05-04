<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8" />
  <title>비밀번호 찾기</title>
  <script src="https://cdn.tailwindcss.com"></script>
  <style>
    body {
      min-width: 1000px;
    }
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
<%@ include file="scrollTop.jsp" %>
<!-- ✅ 비밀번호 찾기 메인 콘텐츠 -->
<main class="flex flex-col items-center justify-center py-24">
  <div class="bg-gray-100 rounded-lg px-8 py-10 text-center w-full max-w-md shadow">
    <h2 class="text-lg font-semibold mb-6">비밀번호 찾기</h2>
    <form action="findPassword" method="post" class="space-y-3">
      <input type="text" name="name" placeholder="이름을 입력해주세요." class="w-full border px-4 py-2 rounded text-sm" />
      <input type="text" name="userId" placeholder="아이디를 입력해주세요." class="w-full border px-4 py-2 rounded text-sm" />
      <input type="email" name="email" placeholder="이메일을 입력해주세요." class="w-full border px-4 py-2 rounded text-sm" />
      <button type="submit" class="w-full bg-black text-white py-2 rounded hover:bg-gray-800">비밀번호 찾기</button>
    </form>
  </div>
</main>
<jsp:include page="footer.jsp"/>
</body>
</html>
