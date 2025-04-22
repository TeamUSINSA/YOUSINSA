<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page session="true" %>
<%
  String id = (String) session.getAttribute("id");
  if (id == null) {
    response.sendRedirect(request.getContextPath() + "/user/login.jsp");
    return;
  }
%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>나의 1:1 문의</title>
  <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-50 text-sm text-gray-700">
  <%@ include file="/common/header.jsp" %>
  <%@ include file="/common/navigation_with_sidebar.jsp" %>

  <div class="flex max-w-6xl mx-auto mt-10">
    <!-- ✅ 마이페이지 사이드바 인클루드 -->
   

    <!-- ✅ 메인 문의 테이블 -->
    <main class="flex-1 pl-10">
      <h1 class="text-lg font-semibold mb-6">나의 1:1 문의 창</h1>

      <table class="w-full border text-center text-sm">
        <thead class="bg-gray-100 border-b">
          <tr>
            <th class="py-2">문의일시</th>
            <th class="py-2">문의번호</th>
            <th class="py-2">문의 카테고리</th>
            <th class="py-2">답변여부</th>
          </tr>
        </thead>
        <tbody>
          <tr class="border-b">
            <td class="py-2">2025.01.26</td>
            <td class="py-2">Q-010152</td>
            <td class="py-2">카테고리 1</td>
            <td class="py-2">답변 완료</td>
          </tr>
          <tr class="border-b">
            <td class="py-2">2025.01.25</td>
            <td class="py-2">Q-010151</td>
            <td class="py-2">카테고리 2</td>
            <td class="py-2">답변 대기</td>
          </tr>
          <!-- 반복되는 문의 항목은 JSTL or 서버 연동 시 foreach 처리 가능 -->
        </tbody>
      </table>

      <!-- ✅ 페이지네이션 -->
      <div class="mt-4 flex justify-center space-x-1">
        <button class="w-8 h-8 border rounded">1</button>
        <button class="w-8 h-8 border rounded bg-black text-white">2</button>
        <button class="w-8 h-8 border rounded">3</button>
        <span class="px-2">...</span>
        <button class="w-8 h-8 border rounded">10</button>
      </div>
    </main>
  </div>

  <%@ include file="/common/footer.jsp" %>
</body>
</html>
