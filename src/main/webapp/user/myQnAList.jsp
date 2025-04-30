<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/header" />

<style>
  .page-wrapper {
    display: flex;
    gap: 30px;
    max-width: 1200px;
    margin: 40px auto;
    padding: 0 20px;
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

  .pagination {
    text-align: center;
    margin-top: 20px;
  }
  .pagination a,
  .pagination strong {
    margin: 0 6px;
    color: #333;
    text-decoration: none;
  }
  .pagination strong {
    font-weight: bold;
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
<div class="sidebar">
    <%@ include file="mysidebar.jsp" %>
  </div>
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
      <c:forEach var="q" items="${qnaList}" varStatus="st">
        <!-- 요약 행 -->
        <tr class="qna-row">
          <td>${(pageInfo.curPage - 1) * 10 + st.index + 1}</td>
          <td>${q.type}</td>
          <td>${q.title}</td>
          <td>${q.questionDate}</td>
          <td>
            <c:choose>
              <c:when test="${not empty q.answer}">
                <span style="color:#28a745;">답변 완료</span>
              </c:when>
              <c:otherwise>
                <span style="color:#d9534f;">미답변</span>
              </c:otherwise>
            </c:choose>
          </td>
        </tr>
        <!-- 상세 행 -->
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
    </tbody>
  </table>

  <!-- 페이지네이션 -->
  <div class="pagination">
    <c:forEach var="i" begin="${pageInfo.startPage}" end="${pageInfo.endPage}">
      <c:choose>
        <c:when test="${i == pageInfo.curPage}">
          <strong>${i}</strong>
        </c:when>
        <c:otherwise>
          <a href="?page=${i}">${i}</a>
        </c:otherwise>
      </c:choose>
    </c:forEach>
  </div>
</div>
</div>
<script>
  // 상세내용 토글
  document.querySelectorAll('.qna-row').forEach(row => {
    row.addEventListener('click', () => {
      const detail = row.nextElementSibling;
      if (!detail || !detail.classList.contains('qna-detail')) return;
      detail.style.display = detail.style.display === 'none' ? '' : 'none';
    });
  });
</script>

<jsp:include page="/common/footer.jsp" />
