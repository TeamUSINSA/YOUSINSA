<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8"/>
  <title>공지사항 상세</title>
  <style>
    body { margin:0; padding:0; font-family:Arial,sans-serif; background:#f5f5f5; }
    .container {
      max-width:600px; margin:40px auto; padding:24px;
      background:#fff; border-radius:8px; box-shadow:0 2px 8px rgba(0,0,0,0.1);
    }
    h2 { margin-bottom:24px; font-size:22px; color:#333; text-align:center; }
    .detail p { margin:12px 0; color:#555; }
    .detail p strong { width:80px; display:inline-block; color:#333; }
    .detail .image {
      text-align:center; margin:16px 0;
    }
    .detail .image img {
      max-width:100%; max-height:240px; border-radius:4px; border:1px solid #ddd;
    }
    .detail .content {
      padding:12px; border:1px solid #eee; background:#fafafa;
      white-space:pre-wrap; color:#444; border-radius:4px;
    }
    .btn-group {
      margin-top:24px; text-align:right;
    }
    .btn {
      display:inline-block; padding:8px 16px; margin-left:8px;
      text-decoration:none; font-size:14px; border-radius:4px;
      border:1px solid #bbb; color:#333; background:#eee;
    }
    .btn:hover { background:#ddd; }
    .btn-primary {
      background:#4CAF50; border-color:#45A049; color:#fff;
    }
    .btn-primary:hover { background:#45A049; }
    .btn-danger {
      background:#E53935; border-color:#D32F2F; color:#fff;
    }
    .btn-danger:hover { background:#D32F2F; }
  </style>
</head>
<body>
<jsp:include page="/header" />
<%@ include file="scrollTop.jsp" %>
  <div class="container">
    <h2>공지사항 상세</h2>
    <div class="detail">
      <p><strong>번호:</strong> ${notice.noticeId}</p>
      <p><strong>제목:</strong> ${notice.title}</p>
      <p>
        <strong>등록일:</strong>
        <fmt:formatDate value="${notice.regDate}" pattern="yy.MM.dd"/>
      </p>
      <c:if test="${not empty notice.image}">
        <div class="image">
          <img src="${pageContext.request.contextPath}/image/${notice.image}"
               alt="공지 이미지"/>
        </div>
      </c:if>
      <div class="content">${notice.content}</div>
    </div>

    <div class="btn-group">
      <a href="${pageContext.request.contextPath}/notice" class="btn">목록</a>
      <c:if test="${sessionScope.isSeller}">
        <a href="${pageContext.request.contextPath}/noticeModify?noticeId=${notice.noticeId}"
           class="btn btn-primary">수정</a>
        <a href="${pageContext.request.contextPath}/noticeDelete?noticeId=${notice.noticeId}"
           class="btn btn-danger"
           onclick="return confirm('정말 삭제하시겠습니까?');">삭제</a>
      </c:if>
    </div>
  </div>
<jsp:include page="footer.jsp"/>
</body>
</html>
