<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/header" />

<style>
  /* 레이아웃 중앙정렬 및 여백 */
  .page-wrapper {
    display: flex;
    max-width: 1200px;
    margin: 0 auto;
    padding: 40px 20px;
    gap: 30px;
  }

  /* sidebar column */
  .sidebar {
    width: 200px;
  }

  /* main Q&A area */
  .qna-container {
    flex: 1;
    background: #fff;
    border-radius: 12px;
    box-shadow: 0 8px 20px rgba(0,0,0,0.05);
    padding: 40px;
  }

  .qna-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 20px;
  }
  .qna-header h2 {
    margin: 0;
    font-size: 24px;
  }
  .btn-new {
    background: #007bff;
    color: #fff;
    border: none;
    padding: 8px 16px;
    border-radius: 4px;
    cursor: pointer;
  }

  .qna-table {
    width: 100%;
    border-collapse: collapse;
    font-size: 14px;
  }
  .qna-table th,
  .qna-table td {
    padding: 12px;
    border-bottom: 1px solid #eee;
    text-align: center;
  }
  .qna-table thead {
    background: #f8f8f8;
  }

  .qna-row { cursor: pointer; }
  .qna-detail { display: none; }

  .qna-detail-content {
    padding: 20px;
    background: #fafafa;
    border-bottom: 1px solid #ddd;
  }
  .qna-detail-content h4 {
    margin-top: 0;
    font-size: 16px;
    color: #333;
  }
  .qna-detail-content p {
    line-height: 1.6;
    color: #555;
    margin-bottom: 16px;
  }

  .qna-actions {
    text-align: right;
    padding: 8px 20px;
    background: #fafafa;
  }
  .qna-actions button {
    background: #fff;
    border: 1px solid #ccc;
    padding: 6px 12px;
    border-radius: 4px;
    margin-left: 8px;
    cursor: pointer;
  }
  .qna-actions button:hover {
    background: #f0f0f0;
  }

  /* pagination: coupon page와 동일한 디자인 */
  .pagination {
    text-align: center;
    margin-top: 30px;
  }
  .pagination a {
    margin: 0 5px;
    text-decoration: none;
    color: #333;
    padding: 6px 10px;
    border-radius: 4px;
  }
  .pagination a.current {
    background: #333;
    color: #fff;
  }

  /* answer status colors */
  .answered { color: #28a745; }
  .not-answered { color: #d9534f; }

  @media (max-width: 800px) {
    .page-wrapper { flex-direction: column; }
    .sidebar { width: 100%; }
  }
</style>

<div class="page-wrapper">

  <%@ include file="mysidebar.jsp" %>

  <div class="qna-container">
    <div class="qna-header">
      <h2>나의 Q&amp;A 목록</h2>
      <button class="btn-new" onclick="location.href='${pageContext.request.contextPath}/myQnAWrite'">문의 작성</button>
    </div>

    <table class="qna-table">
      <thead>
        <tr>
          <th>번호</th>
          <th>구분</th>
          <th>제목</th>
          <th>작성일</th>
          <th>상태</th>
        </tr>
      </thead>
      <tbody>
  <c:choose>
    <c:when test="${not empty qnaList}">
      <c:forEach var="q" items="${qnaList}" varStatus="st">
        <tr class="qna-row" onclick="location.href='${pageContext.request.contextPath}/myQnADetail?id=${q.qnaId}'">
          <td>${(pageInfo.curPage - 1) * 10 + st.index + 1}</td>
          <td>${q.type}</td>
          <td>${q.title}</td>
          <td>${q.questionDate}</td>
          <td>
            <c:choose>
              <c:when test="${not empty q.answer}">
                <span class="answered">답변 완료</span>
              </c:when>
              <c:otherwise>
                <span class="not-answered">미답변</span>
              </c:otherwise>
            </c:choose>
          </td>
        </tr>
        <tr class="qna-detail">
          <td colspan="5">
            <div class="qna-detail-content">
              <h4>문의 내용</h4>
              <p>${q.content}</p>
              <h4 style="margin-top:20px;">답변 내용</h4>
              <p>${empty q.answer ? '아직 답변이 등록되지 않았습니다.' : q.answer}</p>
            </div>
            <div class="qna-actions">
              <button onclick="location.href='${pageContext.request.contextPath}/qnaEdit?id=${q.qnaId}'">수정</button>
              <button onclick="if(confirm('삭제하시겠습니까?')) location.href='${pageContext.request.contextPath}/qnaDelete?id=${q.qnaId}'">삭제</button>
            </div>
          </td>
        </tr>
      </c:forEach>
    </c:when>
    <c:otherwise>
      <tr>
        <td colspan="5" style="padding: 20px; text-align:center;">
          QnA가 없습니다.
        </td>
      </tr>
    </c:otherwise>
  </c:choose>
</tbody>

    </table>

    <div class="pagination">
      <c:forEach var="i" begin="${pageInfo.startPage}" end="${pageInfo.endPage}">
        <a href="?page=${i}" class="${i == pageInfo.curPage ? 'current' : ''}">${i}</a>
      </c:forEach>
    </div>

  </div>
</div>

<jsp:include page="/common/footer.jsp" />
