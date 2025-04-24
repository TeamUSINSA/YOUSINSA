<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>배너 관리</title>
  <script src="https://cdn.tailwindcss.com"></script>
  <jsp:include page="adminSideBarStyle.jsp" />
</head>
<body class="bg-gray-100 p-6">
<jsp:include page="adminSideBar.jsp" />
  <div class="max-w-5xl mx-auto bg-white shadow-md p-6 rounded-md">
    <h1 class="text-xl font-bold mb-6">배너 관리</h1>

    <table class="w-full text-sm text-center border border-gray-300">
      <thead class="bg-gray-100">
        <tr>
          <th class="p-2 border">ID</th>
          <th class="p-2 border">이름</th>
          <th class="p-2 border">이미지</th>
          <th class="p-2 border">product_id</th>
          <th class="p-2 border">position</th>
          <th class="p-2 border">삭제</th>
        </tr>
      </thead>
      <tbody>
        <c:forEach var="banner" items="${bannerList}">
          <tr>
            <td class="p-2 border">${banner.id}</td>
            <td class="p-2 border">${banner.name}</td>
            <td class="p-2 border">
              <img src="${pageContext.request.contextPath}/upload/banner/${banner.img}" class="h-12 mx-auto" />
            </td>
            <td class="p-2 border">${banner.productId}</td>
            <td class="p-2 border">${banner.position}</td>
            <td class="p-2 border">
              <form action="${pageContext.request.contextPath}/adminBannerDelete" method="post" onsubmit="return confirm('정말 삭제하시겠습니까?')">
                <input type="hidden" name="bannerId" value="${banner.id}" />
                <button class="bg-red-500 text-white px-3 py-1 rounded hover:bg-red-600">삭제</button>
              </form>
            </td>
          </tr>
        </c:forEach>
      </tbody>
    </table>

    <div class="mt-6 text-right">
      <form action="${pageContext.request.contextPath}/adminbanneradd" method="get">
        <button class="bg-black text-white px-4 py-2 rounded hover:bg-gray-800">배너 등록</button>
      </form>
    </div>
  </div>
</body>
</html>
