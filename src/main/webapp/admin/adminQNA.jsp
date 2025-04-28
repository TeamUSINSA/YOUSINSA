<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<title>Q&A 관리</title>
<jsp:include page="../common/header.jsp" />
<jsp:include page="adminSideBarStyle.jsp" />
<script src="https://cdn.tailwindcss.com"></script>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<style>
body {
  margin: 0;
  font-family: 'Pretendard', sans-serif;
  background-color: #f8f8f8;
}
h2 {
  font-size: 24px;
  font-weight: bold;
  margin-bottom: 30px;
}
.content-wrapper {
  display: flex;
  gap: 20px;
  margin: 20px;
}
.sidebar {
  width: 300px;
  flex-shrink: 0;
}
.main-content {
  background-color: white;
  padding: 30px;
  border-radius: 12px;
  box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
  width: 100%;
  max-width: 1200px;
  margin: 20px;
  flex-grow: 1;
}
table {
  width: 100%;
  border-collapse: collapse;
  margin-top: 20px;
}
th, td {
  padding: 12px;
  text-align: center;
  border-bottom: 1px solid #ddd;
}
thead {
  background-color: #f0f0f0;
}
textarea {
  width: 100%;
  border: 1px solid #ccc;
  border-radius: 6px;
  padding: 10px;
  margin-top: 10px;
}
.reply-btn {
  background-color: #000;
  color: white;
  padding: 8px 20px;
  border: none;
  border-radius: 6px;
  cursor: pointer;
  margin-top: 10px;
}
</style>
</head>
<body class="bg-gray-100 min-h-screen font-pretendard">

<div class="content-wrapper">
  <jsp:include page="adminSideBar.jsp" />

  <div class="main-content">
    <h2>Q&A 관리</h2>

    <table>
      <thead>
        <tr>
          <th>문의일시</th>
          <th>회원명(ID)</th>
          <th>문의 제목</th>
          <th>답변상태</th>
        </tr>
      </thead>
      <tbody>
        <c:forEach var="qna" items="${qnaList}">
          <tr class="toggle-row cursor-pointer hover:bg-gray-50" data-id="${qna.qnaId}">
            <td>${qna.questionDate}</td>
            <td>${qna.userId}</td>
            <td>${qna.title}</td>
            <td class="${qna.status eq '답변대기' ? 'text-orange-500 font-semibold' : ''}">
              ${qna.status} <span class="arrow float-right">▼</span>
            </td>
          </tr>

          <tr class="expand-row hidden bg-gray-50">
            <td colspan="4">
              <div class="p-4">
                <p><strong>문의유형:</strong> ${qna.type}</p>
                <p><strong>문의내용:</strong><br> ${qna.content}</p>
                <c:if test="${not empty qna.image}">
                  <img src="${qna.image}" class="w-32 h-auto rounded my-3" alt="첨부 이미지">
                </c:if>
                <textarea class="answer-textarea" placeholder="답변을 입력해주세요">${qna.answer}</textarea>
                <button class="reply-btn">답변 등록</button>
              </div>
            </td>
          </tr>
        </c:forEach>
      </tbody>
    </table>

    <div class="text-right mt-10">
      <a href="${pageContext.request.contextPath}/admin/adminCategory.jsp" class="bg-gray-700 text-white px-5 py-2 rounded hover:bg-gray-800">관리자 메인으로 돌아가기</a>
    </div>

  </div>
</div>

<jsp:include page="../common/footer.jsp" />

<script>
$(function () {
  // 토글 열기/닫기
  $("tbody").on("click", ".toggle-row", function () {
    const $row = $(this);
    const $expand = $row.next(".expand-row");
    const $arrow = $row.find(".arrow");

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

  // 답변 등록하기
  $("tbody").on("click", ".reply-btn", function () {
    const $expand = $(this).closest(".expand-row");
    const qnaId = $expand.prev().data("id");
    const answer = $expand.find(".answer-textarea").val().trim();

    if (!answer) {
      alert("답변을 입력해주세요.");
      return;
    }

    $.post("${pageContext.request.contextPath}/adminQNAReply", { qnaId, answer }, function (result) {
      if (result === "success") {
        alert("답변이 등록되었습니다.");
        location.reload();
      } else {
        alert("답변 등록 실패");
      }
    });
  });
});
</script>

</body>
</html>
