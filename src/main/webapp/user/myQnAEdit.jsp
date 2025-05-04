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
  <form action="${pageContext.request.contextPath}/myQnAEdit" method="post">
    <!-- 수정용 Hidden -->
    <input type="hidden" name="qnaId" value="${qna.qnaId}" />

    <div class="form-group">
      <label for="title">제목</label>
      <input type="text" id="title" name="title" value="${qna.title}" required />
    </div>
    <div class="form-group">
    <label for="type">구분</label>
    <select id="type" name="type" required>
      <option value="">문의 유형 선택</option>
      <option value="상품문의" <c:if test="${qna.type == '상품문의'}">selected</c:if>>상품문의</option>
      <option value="배송문의" <c:if test="${qna.type == '배송문의'}">selected</c:if>>배송문의</option>
      <option value="환불문의" <c:if test="${qna.type == '환불문의'}">selected</c:if>>환불문의</option>
      <option value="교환문의" <c:if test="${qna.type == '교환문의'}">selected</c:if>>교환문의</option>
      <option value="기타"     <c:if test="${qna.type == '기타'}">selected</c:if>>기타</option>
    </select>
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