<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<html>
<head>
  <title>1:1 문의</title>
  <style>
    body {
      font-family: sans-serif;
      background-color: #f9f9f9;
      padding: 30px 0;
    }

    .container {
      width: 768px;
      margin: 0 auto;
      background: #fff;
      border: 1px solid #ddd;
      padding: 30px;
    }

    .filter {
      display: flex;
      align-items: center;
      gap: 10px;
      margin-bottom: 20px;
    }

    .filter button {
      margin-left: auto;
      padding: 6px 16px;
      border: none;
      background-color: #333;
      color: white;
      cursor: pointer;
    }

    table {
      width: 100%;
      border-collapse: collapse;
      font-size: 14px;
    }

    th, td {
      padding: 12px 10px;
      border-top: 1px solid #ccc;
      text-align: left;
      position: relative;
    }

    .expand-row {
      display: none;
      background: #f9f9f9;
      padding: 20px;
    }

    .expand-content {
      display: flex;
      gap: 20px;
    }

    .expand-content img {
      width: 120px;
      height: auto;
    }

    textarea {
      width: 100%;
      height: 100px;
      margin-top: 10px;
      padding: 10px;
    }

    .reply-btn {
      margin-top: 10px;
      background: black;
      color: white;
      padding: 6px 14px;
      border: none;
      cursor: pointer;
    }

    .status-waiting {
      color: #ff6600;
      font-weight: bold;
    }

    .arrow {
      position: absolute;
      right: 10px;
      top: 50%;
      transform: translateY(-50%);
      font-size: 16px;
      cursor: pointer;
    }

    tr:hover {
      background-color: #f5f5f5;
    }
  </style>
  <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
  <script>
    $(function () {
      // 토글 펼치기
      $("tbody").on("click", ".toggle-row", function () {
        const $row = $(this);
        const $arrow = $row.find(".arrow");
        const $expand = $row.next(".expand-row");

        $(".expand-row").not($expand).hide();
        $(".arrow").text("▼");

        if (!$expand.is(":visible")) {
          $expand.show();
          $arrow.text("▲");
        } else {
          $expand.hide();
          $arrow.text("▼");
        }
      });

      // 답변 등록 (또는 수정)
      $("tbody").on("click", ".reply-btn", function () {
        const $expand = $(this).closest(".expand-row");
        const $textarea = $expand.find("textarea");
        const content = $textarea.val().trim();
        const $row = $expand.prev();
        const $statusCell = $row.find(".status-cell");

        if (!content) {
          alert("답변을 입력해주세요.");
          return;
        }

        // 상태가 대기였으면 '답변 완료'로 바꿔줌
        if ($statusCell.text().trim() !== "답변 완료") {
          $statusCell.text("답변 완료").removeClass("status-waiting");
        }

        alert("답변이 등록(수정)되었습니다.");
        $expand.hide();
        $row.find(".arrow").text("▼");
      });
    });
  </script>
</head>
<body>
<div class="container">
  <h2>1:1 문의</h2>

  <!-- 필터 -->
  <form method="get" action="inquiry.jsp" class="filter">
    <label><input type="radio" name="filter" value="all" checked> 전체</label>
    <label><input type="radio" name="filter" value="done"> 답변 완료</label>
    <label><input type="radio" name="filter" value="waiting"> 답변 대기</label>
    <button type="submit">검색</button>
  </form>

  <!-- 문의 목록 -->
  <table>
    <thead>
    <tr>
      <th>문의일시</th>
      <th>회원명(ID)</th>
      <th>문의사유</th>
      <th>답변상태</th>
    </tr>
    </thead>
    <tbody>
    <c:forEach var="qna" items="${qnaList}">
      <!-- 답변 상태 판별 -->
      <c:choose>
        <c:when test="${not empty qna.reply}">
          <c:set var="status" value="답변 완료"/>
        </c:when>
        <c:otherwise>
          <c:set var="status" value="답변 대기"/>
        </c:otherwise>
      </c:choose>

      <!-- 메인 행 -->
      <tr class="toggle-row" data-id="${qna.id}">
        <td>${qna.date}</td>
        <td>${qna.userId}</td>
        <td>${qna.category}</td>
        <td class="status-cell ${status eq '답변 대기' ? 'status-waiting' : ''}">
          ${status}
          <span class="arrow">▼</span>
        </td>
      </tr>

      <!-- 펼쳐지는 상세 행 -->
      <tr class="expand-row">
        <td colspan="4">
          <div class="expand-content">
            <img src="${qna.imageUrl}" alt="상품 이미지">
            <div class="content">
              <p><strong>제목:</strong> ${qna.title}</p>
              <p><strong>내용:</strong> ${qna.content}</p>

              <textarea placeholder="답변을 입력해주세요">${qna.reply}</textarea>
              <button class="reply-btn">답변 등록</button>
            </div>
          </div>
        </td>
      </tr>
    </c:forEach>
    </tbody>
  </table>
</div>
</body>
</html>
