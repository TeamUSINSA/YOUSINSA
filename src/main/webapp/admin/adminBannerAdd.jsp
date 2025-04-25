<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>배너 등록</title>
  <script src="https://cdn.tailwindcss.com"></script>
  <style>
    .wrapper {
      display: flex;
      min-height: 100vh;
    }

    .sidebar {
      width: 220px;
      background-color: #fff;
      border-right: 1px solid #ddd;
      padding: 20px;
      box-sizing: border-box;
    }

    .content {
      flex: 1;
      padding: 40px;
      background-color: #f9f9f9;
      box-sizing: border-box;
    }
  </style>
</head>
<body>
<div class="wrapper">
  <%@ include file="adminSideBar.jsp" %>

  <div class="content">
    <div class="max-w-3xl mx-auto bg-white p-8 rounded shadow">
      <h1 class="text-2xl font-bold mb-6">배너 등록</h1>

      <c:if test="${not empty msg}">
        <p class="text-green-600 font-semibold mb-4">${msg}</p>
      </c:if>

      <form action="${pageContext.request.contextPath}/adminbanneradd" method="post" enctype="multipart/form-data" class="space-y-4">

        <div>
          <label class="block mb-1 font-medium">배너 이미지</label>
          <input type="file" name="img" class="border p-2 w-full" required>
        </div>

        <div>
          <label class="block mb-1 font-medium">배너 이름</label>
          <input type="text" name="name" class="border p-2 w-full" required>
        </div>

        <div>
          <label class="block mb-1 font-medium">상품 ID</label>
          <input type="number" name="productId" class="border p-2 w-full" required>
        </div>

        <div>
          <label class="block mb-1 font-medium">배너 위치</label>
          <input type="text" name="position" class="border p-2 w-full" placeholder="예: 상단, 중단, 하단 등">
        </div>

        <button type="submit" class="bg-blue-600 text-white px-4 py-2 rounded hover:bg-blue-700">
          등록
        </button>
      </form>

      <div class="mt-6 text-right">
        <a href="${pageContext.request.contextPath}/admin/adminCategory.jsp"
           class="inline-block bg-gray-800 text-white px-4 py-2 rounded hover:bg-gray-700">
          관리자 메인으로 돌아가기
        </a>
      </div>
    </div>
  </div>
</div>
</body>
</html>
