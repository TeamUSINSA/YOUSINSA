<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>1:1 문의</title>
   <!-- ✅ 꼭 있어야 함! -->
  <script src="https://cdn.tailwindcss.com"></script>
  <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
</head>
<body class="bg-gray-100 min-h-screen">
  <div class="flex">
    <!-- ✅ Sidebar -->
    <div class="w-64 bg-white shadow-md h-screen sticky top-0">
      <jsp:include page="adminSideBar.jsp" />
    </div>

    <!-- ✅ Main Content -->
    <div class="flex-1 p-10">
      <div class="max-w-5xl mx-auto bg-white p-8 shadow rounded">
        <h2 class="text-xl font-bold mb-6">1:1 문의</h2>

        <!-- ✅ Filter -->
        <form method="get" action="${pageContext.request.contextPath}/admininquiry" class="flex gap-4 items-center mb-6">
          <label><input type="radio" name="filter" value="all" class="mr-1" <c:if test="${param.filter == 'all' || empty param.filter}">checked</c:if>> 전체</label>
          <label><input type="radio" name="filter" value="done" class="mr-1" <c:if test="${param.filter == 'done'}">checked</c:if>> 답변 완료</label>
          <label><input type="radio" name="filter" value="waiting" class="mr-1" <c:if test="${param.filter == 'waiting'}">checked</c:if>> 답변 대기</label>
          <button type="submit" class="ml-auto px-4 py-2 bg-black text-white rounded">검색</button>
        </form>

        <!-- ✅ Inquiry Table -->
        <table class="w-full text-sm border-t border-gray-300">
          <thead class="bg-gray-100">
            <tr>
              <th class="p-3 text-left">문의일시</th>
              <th class="p-3 text-left">회원명(ID)</th>
              <th class="p-3 text-left">문의사유</th>
              <th class="p-3 text-left">답변상태</th>
            </tr>
          </thead>
          <tbody>
            <c:forEach var="inquiry" items="${inquiryList}">
              <c:set var="status" value="${inquiry.status}" />
              <tr class="toggle-row border-t" data-id="${inquiry.inquiryId}">
                <td class="p-3">${inquiry.questionDate}</td>
                <td class="p-3">${inquiry.userId}</td>
                <td class="p-3">${inquiry.type}</td>
                <td class="p-3 status-cell ${status eq '답변 대기' ? 'text-orange-500 font-semibold' : ''}">
                  ${status} <span class="arrow float-right">▼</span>
                </td>
              </tr>

              <tr class="expand-row hidden bg-gray-50">
                <td colspan="4" class="p-4">
                  <div class="flex gap-6">
                    <img src="${inquiry.image}" class="w-28 h-auto rounded border" alt="상품 이미지">
                    <div class="flex-1">
                      <p class="mb-2 font-semibold">제목: ${inquiry.title}</p>
                      <p class="mb-4">내용: ${inquiry.content}</p>
                      <textarea class="w-full border p-3 rounded mb-3" placeholder="답변을 입력해주세요">${inquiry.answer}</textarea>
                      <button class="reply-btn bg-black text-white px-4 py-2 rounded">답변 등록</button>
                    </div>
                  </div>
                </td>
              </tr>
            </c:forEach>
          </tbody>
        </table>

        <!-- ✅ Return Button -->
        <div class="text-center mt-10">
          <button onclick="location.href='${pageContext.request.contextPath}/adminCategory'" class="bg-gray-700 text-white px-5 py-2 rounded">관리자 메인으로 돌아가기</button>
        </div>
      </div>
    </div>
  </div>

  <script>
    $(function () {
      // Toggle row
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

      // Reply submit
      $("tbody").on("click", ".reply-btn", function () {
        const $expand = $(this).closest(".expand-row");
        const inquiryId = $expand.prev().data("id");
        const answer = $expand.find("textarea").val().trim();
        const $statusCell = $expand.prev().find(".status-cell");

        if (!answer) {
          alert("답변을 입력해주세요.");
          return;
        }

        $.post("admininquiryreply", { inquiryId, answer }, function (result) {
          if (result === "success") {
            $statusCell.text("답변 완료").removeClass("text-orange-500");
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