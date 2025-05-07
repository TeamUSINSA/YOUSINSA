<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/header" />

<style>
/* 1) 페이지 전체 바디는 흰색 */
body {
  background: #fff;
  margin: 0;
  padding: 0;
}

/* 2) 페이지 래퍼: 흰 배경, flex-start로 정렬 */
.page-wrapper {
  display: flex;
  align-items: flex-start;
  gap: 30px;
  max-width: 1000px;
  margin: 40px auto;
  padding: 0 20px;
  background: #fff;
}

/* 3) 사이드바 너비 */
.sidebar {
  width: 200px;
}

/* 4) Q&A 컨테이너 */
.qna-detail-container {
  flex: 1;
  background: #fff;
  border-radius: 8px;
  box-shadow: 0 2px 8px rgba(0,0,0,0.1);
  overflow: hidden;
}

/* 5) 헤더만 연회색 */
.post-header {
  background: #f1f3f5;    /* 헤더 배경 */
  padding: 24px 30px;
  border-bottom: 1px solid #dee2e6;
}
.post-header h2 {
  margin: 0 0 8px;
  font-size: 28px;
  color: #343a40;
}
.meta-info {
  font-size: 14px;
  color: #6c757d;
}
.meta-info span + span::before {
  content: " | ";
  margin: 0 6px;
}

/* 6) 본문 */
.post-content {
  padding: 24px 30px;
  border-bottom: 1px solid #dee2e6;
  line-height: 1.6;
  color: #495057;
}
.post-answer {
  padding: 24px 30px;
  line-height: 1.6;
  color: #495057;
}
.post-answer h3 {
  margin-top: 0;
  font-size: 18px;
  color: #007bff;
  margin-bottom: 12px;
}

/* 7) 버튼 그룹 */
.btn-group {
  padding: 16px 30px;
  background: #f9f9f9;
  text-align: right;
}
.btn-group button {
  padding: 8px 16px;
  border-radius: 4px;
  border: none;
  cursor: pointer;
  font-size: 14px;
  margin-left: 8px;
}
.btn-back     { background: #6c757d; color: #fff; }
.btn-edit     { background: #007bff; color: #fff; }
.btn-edit[disabled] { background: #adb5bd; color: #fff; cursor: not-allowed; }
.btn-delete   { background: #dc3545; color: #fff; }
.btn-delete:hover { background: #c82333; }
</style>

<div class="page-wrapper">

    <%@ include file="mysidebar.jsp" %>


  <div class="qna-detail-container">
    <!-- 1) 연회색 헤더 -->
    <div class="post-header">
      <h2>${qna.title}</h2>
      <div class="meta-info">
        <span>구분: ${qna.type}</span>
        <span>작성일: ${qna.questionDate}</span>
        <span>
          상태:
          <c:choose>
            <c:when test="${empty qna.answer}">
              <span style="color:#d9534f;">미답변</span>
            </c:when>
            <c:otherwise>
              <span style="color:#28a745;">답변완료</span>
            </c:otherwise>
          </c:choose>
        </span>
      </div>
    </div>

    <!-- 2) 문의 내용 -->
    <div class="post-content">
      <h3>문의 내용</h3>
      <p>${qna.content}</p>
    </div>

    <!-- 3) 답변 내용 -->
    <div class="post-answer">
      <h3>답변 내용</h3>
      <p>
        <c:choose>
          <c:when test="${empty qna.answer}">
            아직 답변이 등록되지 않았습니다.
          </c:when>
          <c:otherwise>
            ${qna.answer}
          </c:otherwise>
        </c:choose>
      </p>
    </div>

    <!-- 4) 버튼 그룹 -->
    <div class="btn-group">
      <button class="btn-back"
              onclick="location.href='${pageContext.request.contextPath}/myQnAList'">
        목록으로
      </button>

      <c:if test="${empty qna.answer}">
    <button class="btn-edit"
            onclick="location.href='${pageContext.request.contextPath}/qnaEdit?id=${qna.qnaId}'">
      수정하기
    </button>
  </c:if>

      <button class="btn-delete"
              onclick="if(confirm('정말 삭제하시겠습니까?')) location.href='${pageContext.request.contextPath}/qnaDelete?id=${qna.qnaId}'">
        삭제하기
      </button>
    </div>
  </div>
</div>

<jsp:include page="/common/footer.jsp" />
