<!DOCTYPE html>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <title>카테고리 관리</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <style>
        body {
            margin: 0;
            padding: 0;
            font-family: '맑은 고딕', sans-serif;
            background-color: #f9f9f9;
            min-width: 1000px;
        }

        h2 {
            width: 700px;
            margin: 50px auto 10px auto;
            text-align: left;
            font-size: 20px;
        }

        .container {
            width: 700px;
            margin: 0 auto 50px auto;
            background-color: #fff;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
        }

        .section {
            margin-bottom: 40px;
        }

        h3 {
            font-size: 16px;
            margin-bottom: 15px;
        }

        .input-row {
            display: flex;
            align-items: center;
            gap: 10px;
            margin-bottom: 15px;
        }

        input[type="text"],
        select {
            padding: 8px;
            border: 1px solid #ccc;
            border-radius: 4px;
            font-size: 14px;
        }

        button.add {
            background-color: #333;
            color: white;
            border: none;
            padding: 8px 14px;
            border-radius: 4px;
            cursor: pointer;
        }

        button.add:hover {
            background-color: #555;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 10px;
        }

        th,
        td {
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
<h2>카테고리 관리</h2>
<div class="container">
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
                        <td><button class="delete" onclick="deleteMainCategory(${cat.categoryId}, this)">삭제</button>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>

    <div class="section">
        <h3>소분류 관리</h3>
        <div class="input-row">
            <select id="mainCategorySelect">
                <option value="">대분류 선택</option>
                <c:forEach var="cat" items="${categoryList}">
                    <option value="${cat.categoryId}" data-name="${cat.categoryName}">${cat.categoryName}</option>
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
                        <td><button class="delete" onclick="deleteSubCategory(${sub.subCategoryId}, this)">삭제</button>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
</div>

<script>

$(function () {

	$("#mainAddBtn").click(function () {
	    const categoryName = $("#mainCategoryInput").val().trim();
	    if (!categoryName) return;

	    $.ajax({
	        url: '/yousinsa/adminCategoryAdd',
	        type: 'post',
	        data: { categoryName: categoryName },
	        success: function (result) {

	            const parts = result.split(",");
	            if (parts[0] === "success") {
	                const categoryId = parts[1];
	                const name = parts[2];

	                $("#mainCategoryTable tbody").append(`
	                    <tr>
	                        <td>${name}</td>
	                        <td><button class="delete" onclick="deleteMainCategory(${categoryId}, this)">삭제</button></td>
	                    </tr>
	                `);

	                $("#mainCategorySelect").append(`<option value="${categoryId}">${name}</option>`);
	                $("#mainCategoryInput").val("");
	                alert("대분류 추가 완료");
	            } else {
	                alert("대분류 추가 실패");
	            }
	        }
	    });
	});



	$("#subAddBtn").click(function () {
	    const subCategoryName = $("#subCategoryInput").val().trim();
	    const categoryId = $("#mainCategorySelect").val();
	    const categoryName = $("#mainCategorySelect option:selected").text();

	    if (!subCategoryName || !categoryId) return;

	    $.ajax({
	        url: '/yousinsa/adminSubcategoryAdd',
	        type: 'post',
	        data: {
	            subCategoryName: subCategoryName,
	            categoryId: categoryId
	        },
	        success: function (result) {
	            const parts = result.split(",");
	            if (parts[0] === "success") {
	                const subCategoryId = parts[1];
	                const subName = parts[2];

	                $("#subCategoryTable tbody").append(`
	                    <tr>
	                        <td>${subName}</td>
	                        <td>${categoryName}</td>
	                        <td><button class="delete" onclick="deleteSubCategory(${subCategoryId}, this)">삭제</button></td>
	                    </tr>
	                `);

	                $("#subCategoryInput").val("");
	            } else {
	                alert("추가 실패");
	            }
	        }
	    });
	});



function deleteMainCategory(categoryId, btn) {
    if (!confirm("삭제하시겠습니까?")) return;

    $.ajax({
        url: '/yousinsa/adminCategoryDelete',
        type: 'post',
        data: { categoryId: categoryId },
        success: function (result) {
            if (result === "success") {
                $(btn).closest("tr").remove();
                $(`#mainCategorySelect option[value="${categoryId}"]`).remove();
                alert("삭제 완료");
            } else {
                alert("삭제 실패");
            }
        }
    });
}




function deleteSubCategory(subCategoryId, btn) {
    if (!confirm("소분류를 삭제하시겠습니까?")) return;

    $.ajax({
        url: '/yousinsa/adminSubcategoryDelete',
        type: 'post',
        data: { subCategoryId: subCategoryId },
        success: function (result) {
            if (result === "success") {
                $(btn).closest("tr").remove();
                alert("삭제 완료");
            } else {
                alert("삭제 실패");
            }
        }
    });
}

</script>
</body>
</html>
