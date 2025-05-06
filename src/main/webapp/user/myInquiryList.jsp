<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:include page="/header" />

<style>
  /* 전체 레이아웃 중앙정렬 및 크기 통일 */
  .page-wrapper {
    display: flex;
    max-width: 1200px;
    margin: 40px auto;
    padding: 40px 20px;
    gap: 30px;
  }
  /* 사이드바 */
  .sidebar { width: 200px; }
  /* 본문 영역 */
  .content { flex: 1; }

  /* 문의 목록 테이블 */
  .tbl-inquiry {
    width: 100%;
    border-collapse: collapse;
    font-size: 14px;
  }
  .tbl-inquiry th,
  .tbl-inquiry td {
    padding: 12px;
    border-bottom: 1px solid #eee;
    text-align: center;
  }
  .tbl-inquiry thead { background: #f8f8f8; }

  .inq-row { cursor: pointer; }
  .inq-detail { display: none; }
  .inq-detail td {
    background: #fafafa;
    padding: 0;
    border-bottom: 1px solid #ddd;
  }

  /* 상세 콘텐츠 */
  .inq-detail-content {
    display: flex;
    flex-direction: column;
    gap: 20px;
    padding: 24px;
    background: #fff;
    border-radius: 8px;
    box-shadow: 0 4px 10px rgba(0,0,0,0.03);
  }
  .inq-box.question { border-left: 6px solid #0078ff; padding-left: 14px; }
  .inq-box.answer { border-left: 6px solid #28a745; padding-left: 14px; background: #f9fefd; }
  .inq-box h4 { margin: 0 0 12px; font-size: 18px; }
  .inq-box p { margin: 0; line-height: 1.6; }

  /* 버튼 그룹 */
  .inq-detail-buttons {
    text-align: right;
    margin-top: 10px;
  }
  .inq-detail-buttons button,
  .inq-detail-buttons button.delete {
    margin-left: 8px;
    padding: 6px 12px;
    border-radius: 4px;
    border: none;
    cursor: pointer;
  }
  .inq-detail-buttons button { background: #0078ff; color: #fff; }
  .inq-detail-buttons button.delete { background: #d9534f; }

  /* 페이지네이션: 쿠폰 페이지와 동일 */
  .pagination {
    text-align: center;
    margin-top: 30px;
  }
  .pagination a {
    margin: 0 5px;
    padding: 6px 10px;
    text-decoration: none;
    color: #333;
    border: 1px solid #ddd;
    border-radius: 4px;
  }
  .pagination a.current {
    background: #333;
    color: #fff;
    border-color: #333;
  }

  @media (max-width: 800px) {
    .page-wrapper { flex-direction: column; padding: 20px; }
    .sidebar { width: 100%; }
    .inq-detail-content { padding: 16px; }
  }
</style>

<div class="page-wrapper">
  <%@ include file="mysidebar.jsp" %>
  <div class="content">
    <h2>1:1 문의 내역</h2>
    <table class="tbl-inquiry">
      <thead>
        <tr>
          <th>번호</th><th>구분</th><th>제목</th><th>작성일</th><th>상태</th>
        </tr>
      </thead>
      <tbody>
        <c:forEach var="inq" items="${inquiryList}" varStatus="st">
          <tr class="inq-row">
            <td>${(pageInfo.curPage - 1) * 10 + st.index + 1}</td>
            <td>${inq.type}</td><td>${inq.title}</td>
            <td><fmt:formatDate value="${inq.questionDate}" pattern="yyyy.MM.dd"/></td>
            <td>
              <c:choose>
                <c:when test="${not empty inq.answer}"><span style="color:#28a745;">답변 완료</span></c:when>
                <c:otherwise><span style="color:#d9534f;">미답변</span></c:otherwise>
              </c:choose>
            </td>
          </tr>
          <tr class="inq-detail">
            <td colspan="5">
              <div class="inq-detail-content">
                <div class="inq-box question">
                  <h4>문의 내용</h4>
                  <p>${inq.content}</p>
                </div>
                <div class="inq-box answer">
                  <h4>답변 내용</h4>
                  <p>${empty inq.answer ? '아직 답변이 등록되지 않았습니다.' : inq.answer}</p>
                </div>
              </div>
              <div class="inq-detail-buttons">
                <c:if test="${empty inq.answer}"><button onclick="location.href='${pageContext.request.contextPath}/myInquiryEdit?id=${inq.inquiryId}'">수정</button></c:if>
                <button class="delete" onclick="if(confirm('삭제하시겠습니까?')) location.href='${pageContext.request.contextPath}/inquiryDelete?id=${inq.inquiryId}'">삭제</button>
              </div>
            </td>
          </tr>
        </c:forEach>
      </tbody>
    </table>
    <div class="pagination">
      <c:forEach var="i" begin="${pageInfo.startPage}" end="${pageInfo.endPage}">
        <c:choose>
          <c:when test="${i == pageInfo.curPage}"><a href="?page=${i}" class="current">${i}</a></c:when>
          <c:otherwise><a href="?page=${i}">${i}</a></c:otherwise>
        </c:choose>
      </c:forEach>
    </div>
  </div>
</div>

<script>
  document.querySelectorAll('.inq-row').forEach(row => {
    const detail = row.nextElementSibling;
    row.addEventListener('click', () => {
      if (!detail || !detail.classList.contains('inq-detail')) return;
      detail.style.display = window.getComputedStyle(detail).display === 'none' ? 'table-row' : 'none';
    });
  });
</script>

<jsp:include page="/common/footer.jsp" />
