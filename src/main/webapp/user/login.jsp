<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page session="true"%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8" />
  <title>로그인</title>
  <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="flex flex-col min-h-screen bg-white text-sm text-gray-700">

  <%-- 공통 레이아웃 include --%>
   <%@ include file="/common/header.jsp"%>
 
  <%@ include file="/common/navigation_with_sidebar.jsp"%>

  <main class="flex-grow max-w-md mx-auto my-20 text-center">
    <h1 class="text-2xl font-semibold mb-6">LOGIN</h1>

    <!-- ✅ 로그인 폼 카드 디자인 적용 -->
    <div class="border border-gray-300 rounded-lg shadow-sm p-6 bg-white">
      <form action="${pageContext.request.contextPath}/login" method="post" class="space-y-4">
        
        <!-- 아이디 입력 -->
        <input type="text" name="userId" placeholder="아이디"
               class="w-full border px-4 py-2 rounded" required />

        <!-- 비밀번호 입력 -->
        <input type="password" name="password" placeholder="비밀번호"
               class="w-full border px-4 py-2 rounded" required />

        <!-- 아이디 저장 -->
        <div class="flex items-center">
          <input type="checkbox" id="saveId" name="saveId" class="mr-2" />
          <label for="saveId" class="text-sm">아이디 저장</label>
        </div>

        <!-- 로그인 버튼 -->
        <button type="submit" class="w-full bg-black text-white py-2 rounded">로그인</button>
      </form>
    </div>

    <!-- 추가 링크 -->
    <div class="mt-3 text-xs text-gray-500">
      <a href="#">아이디 찾기</a> | <a href="#">비밀번호 찾기</a> | 
      <a href="<c:url value='/user/join.jsp' />">회원가입</a>
    </div>
  </main>

  <%@ include file="/common/footer.jsp"%>
</body>
</html>
