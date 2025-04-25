<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>카테고리 관리</title>
  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
  <jsp:include page="adminSideBarStyle.jsp" />
  <style>
    body {
      margin: 0;
      padding: 0;
      font-family: '맑은 고딕', sans-serif;
      background-color: #f9f9f9;
    }

    .outer-wrapper {
      display: flex;
      min-height: 100vh;
      background-color: #f9f9f9;
    }

    .inner-wrapper {
      display: flex;
      width: 100%;
      max-width: 1200px;
      margin: 0 auto;
      gap: 20px;
      padding: 40px 20px;
      box-sizing: border-box;
    }

    .content {
      flex: 1;
      background-color: #fff;
      padding: 30px;
      border-radius: 10px;
      box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
    }

    h2 {
      font-size: 22px;
      margin-bottom: 30px;
    }

    .section {
      margin-bottom: 40px;
    }

    .input-row {
      display: flex;
      align-items: center;
      gap: 10px;
      margin-bottom: 15px;
    }

    input[type="text"], select {
      padding: 8px;
      border: 1px solid #ccc;
      border-radius: 4px;
      font-size: 14px;
    }

    button.add {
      background-color: #333;
      color: white;
      padding: 8px 14px;
      border: none;
      border-radius: 4px;
      cursor: pointer;
    }

    button.add:hover {
      background-color: #555;
    }

    table {
      width: 100%;
      border-collapse: collapse;
    }

    th, td {
      padding: 10px;
      border-bottom: 1px solid #eee;
      text-align: left;
    }

    th {
      background-color: #f5f5f5;
    }

    button.delete {
      background-color: red;
      color: white;
      border: none;
      border-radius: 20px;
      padding: 4px 12px;
      font-size: 13px;
      cursor: pointer;
    }

    button.delete:hover {
      background-color: darkred;
    }
  </style>
</head>
<body>
  <div class="outer-wrapper">
    <div class="inner-wrapper">

      <!-- ✅ 사이드바 포함 (한 번만) -->
      <jsp:include page="adminSideBar.jsp" />

      <div class="content">
        <h2>카테고리 관리</h2>

        <!-- ✅ 대분류 -->
        <div class="section">
          <h3>대분류 관리</h3>
          <div class="input-row">
            <input type="text" id="mainCategoryInput" placeholder="대분류명 입력">
            <button class="add" id="mainAddBtn">추가</button>
          </div>
          <table id="mainCategoryTable">
            <thead>
              <tr><th>대분류명</th><th>삭제</th></tr>
            </thead>
            <tbody>
              <c:forEach var="cat" items="${categoryList}">
                <tr>
                  <td>${cat.categoryName}</td>
                  <td><button class="delete" onclick="deleteMainCategory(${cat.categoryId}, this)">삭제</button></td>
                </tr>
              </c:forEach>
            </tbody>
          </table>
        </div>

        <!-- ✅ 소분류 -->
        <div class="section">
          <h3>소분류 관리</h3>
          <div class="input-row">
            <select id="mainCategorySelect">
              <option value="">대분류 선택</option>
              <c:forEach var="cat" items="${categoryList}">
                <option value="${cat.categoryId}">${cat.categoryName}</option>
              </c:forEach>
            </select>
            <input type="text" id="subCategoryInput" placeholder="소분류명 입력">
            <button class="add" id="subAddBtn">추가</button>
          </div>
          <table id="subCategoryTable">
            <thead>
              <tr><th>소분류명</th><th>대분류명</th><th>삭제</th></tr>
            </thead>
            <tbody>
              <c:forEach var="sub" items="${subCategoryList}">
                <tr>
                  <td>${sub.subCategoryName}</td>
                  <td>
                    <c:forEach var="cat" items="${categoryList}">
                      <c:if test="${cat.categoryId == sub.categoryId}">
                        ${cat.categoryName}
                      </c:if>
                    </c:forEach>
                  </td>
                  <td><button class="delete" onclick="deleteSubCategory(${sub.subCategoryId}, this)">삭제</button></td>
                </tr>
              </c:forEach>
            </tbody>
          </table>
        </div>
      </div>
    </div>
  </div>

  <!-- ✅ JS 스크립트 포함 -->
  <script>
    $(function () {
      $("#mainAddBtn").click(function () {
        const name = $("#mainCategoryInput").val().trim();
        if (!name) return;

        $.post("/yousinsa/adminCategoryAdd", { categoryName: name }, function (result) {
          const [status, id, savedName] = result.split(",");
          if (status === "success") {
            $("#mainCategoryTable tbody").append(`
              <tr>
                <td>${savedName}</td>
                <td><button class="delete" onclick="deleteMainCategory(${id}, this)">삭제</button></td>
              </tr>
            `);
            $("#mainCategorySelect").append(`<option value="${id}">${savedName}</option>`);
            $("#mainCategoryInput").val("");
            alert("대분류 추가 완료");
          } else {
            alert("추가 실패");
          }
        });
      });

      $("#subAddBtn").click(function () {
        const name = $("#subCategoryInput").val().trim();
        const parentId = $("#mainCategorySelect").val();
        const parentName = $("#mainCategorySelect option:selected").text();
        if (!name || !parentId) return;

        $.post("/yousinsa/adminSubcategoryAdd", {
          subCategoryName: name,
          categoryId: parentId
        }, function (result) {
          const [status, id, savedName] = result.split(",");
          if (status === "success") {
            $("#subCategoryTable tbody").append(`
              <tr>
                <td>${savedName}</td>
                <td>${parentName}</td>
                <td><button class="delete" onclick="deleteSubCategory(${id}, this)">삭제</button></td>
              </tr>
            `);
            $("#subCategoryInput").val("");
          } else {
            alert("추가 실패");
          }
        });
      });
    });

    function deleteMainCategory(id, btn) {
      if (!confirm("삭제하시겠습니까?")) return;
      $.post("/yousinsa/adminCategoryDelete", { categoryId: id }, function (result) {
        if (result === "success") {
          $(btn).closest("tr").remove();
          $(`#mainCategorySelect option[value="${id}"]`).remove();
        } else {
          alert("삭제 실패");
        }
      });
    }

    function deleteSubCategory(id, btn) {
      if (!confirm("소분류를 삭제하시겠습니까?")) return;
      $.post("/yousinsa/adminSubcategoryDelete", { subCategoryId: id }, function (result) {
        if (result === "success") {
          $(btn).closest("tr").remove();
        } else {
          alert("삭제 실패");
        }
      });
    }
  </script>
</body>
</html>
