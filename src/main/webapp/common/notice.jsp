<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8" />
  <title>공지사항</title>
  <style>
    body {
      margin: 0; padding: 0;
      font-family: Arial, sans-serif;
      font-size: 14px; color: #333;
      background: #fff;
    }
    .container {
      max-width: 800px;
      margin: 40px auto;
      padding: 0 20px;
    }
    table {
      width: 100%; border-collapse: collapse;
    }
    th, td {
      padding: 8px 12px; border: 1px solid #ddd;
      text-align: left;
    }
    th {
      background: #f4f4f4; font-weight: normal;
    }
    tbody tr:hover {
      background: #fafafa; cursor: pointer;
    }
    .right {
      text-align: right;
      margin-top: 10px;
    }
    .btn {
      display: inline-block;
      padding: 6px 16px;
      border: 1px solid #ccc;
      background: #eee;
      text-decoration: none;
      color: #333;
      font-size: 14px;
      border-radius: 4px;
    }
    .btn:hover {
      background: #ddd;
    }
  </style>
</head>
<body>
	<jsp:include page="/header" />
	<%@ include file="scrollTop.jsp" %>
  <div class="container">
    <h2>공지사항</h2>
    <table>
      <thead>
        <tr>
          <th style="width:60px;">번호</th>
          <th>제목</th>
          <th style="width:100px;">등록일</th>
        </tr>
      </thead>
      <tbody>
        <c:forEach var="notice" items="${notices}">
          <tr
            onclick="location.href='${pageContext.request.contextPath}/noticeDetail?noticeId=${notice.noticeId}'"
          >
            <td>${notice.noticeId}</td>
            <td>${notice.title}</td>
            <td>
              <fmt:formatDate value="${notice.regDate}" pattern="yy.MM.dd"/>
            </td>
          </tr>
        </c:forEach>
      </tbody>
    </table>

    <c:if test="${sessionScope.isSeller}">
      <div class="right">
        <a href="${pageContext.request.contextPath}/noticeAdd" class="btn">등록</a>
      </div>
    </c:if>
  </div>
<jsp:include page="footer.jsp"/>
</body>
</html>
