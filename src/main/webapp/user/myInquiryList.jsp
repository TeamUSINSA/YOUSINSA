<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/header" />

<style>
  .container {
    width:100%;
    max-width:900px;
    background:#fff;
    padding:40px;
    border-radius:12px;
    box-shadow:0 8px 20px rgba(0,0,0,0.05);
    margin:0 auto;
  }
  .tbl-inquiry {
    width:100%;
    border-collapse:collapse;
    font-size:14px;
  }
  .tbl-inquiry th, .tbl-inquiry td {
    padding:12px;
    border-bottom:1px solid #eee;
  }
  .tbl-inquiry thead {
    background:#f8f8f8;
  }
  .inq-row {
    cursor:pointer;
  }

  /* 상세 영역 스타일 */
  .inq-detail td {
    background:#fafafa;
    padding:0;
    border-bottom:1px solid #ddd;
  }
  .inq-detail-content {
    display: flex;
    flex-direction: column;
    gap: 20px;
    padding: 24px;
  }

  /* 인라인 폼 필드 */
  .inq-detail-content label {
    font-weight: bold;
    margin-bottom: 4px;
  }
  .inq-detail-content input[type="text"],
  .inq-detail-content textarea {
    width: 100%;
    border:1px solid #ccc;
    border-radius:4px;
    padding:8px;
    font-size:14px;
  }
  .inq-detail-content textarea {
    resize: vertical;
  }

  /* 질문/답변 카드 공통 */
  .inq-box {
    border:1px solid #e0e0e0;
    border-radius:8px;
    padding:16px 20px;
    box-shadow:0 2px 8px rgba(0,0,0,0.04);
    background:#fff;
  }
  .inq-box.question { border-left:6px solid #0078ff; }
  .inq-box.answer {
    border-left:6px solid #28a745;
    background:#f9fefd;
  }
  .inq-box h4 {
    margin:0 0 12px;
    font-size:18px;
    color:#222;
  }
  .inq-box p {
    margin:0;
    line-height:1.6;
    color:#444;
  }

  .inq-detail-buttons {
    padding: 0 24px 24px;
    text-align: right;
  }
  .inq-detail-buttons button {
    background:#0078ff;
    color:#fff;
    border:none;
    padding:8px 16px;
    border-radius:4px;
    cursor:pointer;
    margin-left:8px;
    transition: background .2s;
  }
  .inq-detail-buttons button.delete {
    background:#d9534f;
  }
  .inq-detail-buttons button:hover {
    opacity:0.9;
  }

  @media(max-width:600px) {
    .inq-detail-content {
      padding: 16px;
    }
    .inq-detail-buttons {
      padding: 0 16px 16px;
    }
  }

  .answered { color:#28a745; }
  .not-answered { color:#d9534f; }
</style>

<div class="container" style="display:flex; gap:30px;">
  <div class="sidebar" style="width:200px;">
    <%@ include file="mysidebar.jsp" %>
  </div>
  <div class="content" style="flex:1;">
    <h2>1:1 문의 내역</h2>
    <table class="tbl-inquiry">
      <thead>
        <tr>
          <th>번호</th><th>구분</th><th>제목</th><th>작성일</th><th>상태</th>
        </tr>
      </thead>
      <tbody>
        <c:forEach var="inq" items="${inquiryList}" varStatus="st">
          <!-- 요약 행 -->
          <tr class="inq-row">
            <td>${(pageInfo.curPage-1)*10 + st.index +1}</td>
            <td>${inq.type}</td>
            <td>${inq.title}</td>
            <td>${inq.questionDate}</td>
            <td>
              <c:choose>
                <c:when test="${not empty inq.answer}">
                  <span class="answered">답변 완료</span>
                </c:when>
                <c:otherwise>
                  <span class="not-answered">미답변</span>
                </c:otherwise>
              </c:choose>
            </td>
          </tr>
          <!-- 상세 보기: 읽기 전용 -->
          <tr class="inq-detail" style="display:none;">
            <td colspan="5">
              <div class="inq-detail-content">
                <div class="inq-box question">
                  <h4>내용</h4>
                  <p>${inq.content}</p>
                </div>
                <div class="inq-box answer">
                  <h4>답변</h4>
                  <p>${empty inq.answer 
                        ? '답변이 등록되지 않았습니다.' 
                        : inq.answer}</p>
                </div>
              </div>
              <div class="inq-detail-buttons">
                <!-- 수정은 별도 페이지로 이동 -->
                <button
                  onclick="location.href='${pageContext.request.contextPath}/myInquiryEdit?id=${inq.inquiryId}'">
                  수정
                </button>
                <button
                  onclick="if(confirm('삭제하시겠습니까?')) 
                    location.href='${pageContext.request.contextPath}/inquiryDelete?id=${inq.inquiryId}'">
                  삭제
                </button>
              </div>
            </td>
          </tr>
        </c:forEach>
      </tbody>
    </table>
    <!-- 페이지네이션 -->
    <div style="text-align:center; margin-top:20px;">
      <c:forEach var="i" begin="${pageInfo.startPage}" end="${pageInfo.endPage}">
        <c:choose>
          <c:when test="${i == pageInfo.curPage}">
            <strong style="margin:0 6px;">${i}</strong>
          </c:when>
          <c:otherwise>
            <a href="?page=${i}" style="margin:0 6px;">${i}</a>
          </c:otherwise>
        </c:choose>
      </c:forEach>
    </div>
  </div>
</div>

<script>
  window.addEventListener('DOMContentLoaded', () => {
    document.querySelectorAll('.inq-row').forEach(row => {
      const detail = row.nextElementSibling;
      if (!detail || !detail.classList.contains('inq-detail')) return;
      row.addEventListener('click', () => {
        detail.style.display = detail.style.display === 'none' ? '' : 'none';
      });
    });
  });
</script>

<jsp:include page="/common/footer.jsp" />
