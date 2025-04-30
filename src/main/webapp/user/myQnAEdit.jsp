<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/header" />

<style>
  /* 동일한 스타일 적용 */
  .form-container { max-width:600px; margin:40px auto; background:#fff; padding:30px; border-radius:8px; box-shadow:0 4px 15px rgba(0,0,0,0.1);}  
  .form-container h2 { margin-bottom:20px; font-size:24px; }
  .form-group { margin-bottom:16px; }
  .form-group label { display:block; margin-bottom:6px; font-weight:500; }
  .form-group input[type=text], .form-group textarea {
    width:100%; padding:10px; border:1px solid #ccc; border-radius:4px;
  }
  .form-group textarea { min-height:150px; resize:vertical; }
  .btn-group { text-align:right; margin-top:20px; }
  .btn-group button {
    background:#28a745; color:#fff; border:none; padding:8px 16px; border-radius:4px; cursor:pointer;
    font-size:14px;
  }
  .btn-group a { margin-left:8px; color:#555; text-decoration:none; }
</style>

<div class="form-container">
  <h2>Q&A 수정</h2>
  <form action="${pageContext.request.contextPath}/myQnaEdit" method="post">
    <!-- 수정용 Hidden -->
    <input type="hidden" name="qnaId" value="${qna.qnaId}" />

    <div class="form-group">
      <label for="title">제목</label>
      <input type="text" id="title" name="title" value="${qna.title}" required />
    </div>
    <div class="form-group">
      <label for="type">구분</label>
      <input type="text" id="type" name="type" value="${qna.type}" required />
    </div>
    <div class="form-group">
      <label for="content">내용</label>
      <textarea id="content" name="content" required>${qna.content}</textarea>
    </div>
    <div class="btn-group">
      <button type="submit">수정</button>
      <a href="${pageContext.request.contextPath}/myQnaList">취소</a>
    </div>
  </form>
</div>

<jsp:include page="/common/footer.jsp" />