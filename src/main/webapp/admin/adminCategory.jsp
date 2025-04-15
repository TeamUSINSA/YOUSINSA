<!DOCTYPE html>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <title>카테고리 관리</title>
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
                <button class="add" onclick="addMainCategory()">추가</button>
            </div>
            <table id="mainCategoryTable">
                <thead>
                    <tr>
                        <th>대분류명</th>
                        <th>삭제</th>
                    </tr>
                </thead>
                <tbody>
    <c:forEach var="cat" items="${categoryList}">
        <tr>
            <td>${cat.categoryName}</td>
            <td><button class="delete" onclick="deleteRow(this, '${cat.categoryName}', 'main')">삭제</button></td>
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
        <option value="${cat.categoryName}">${cat.categoryName}</option>
    </c:forEach>
</select>
                <input type="text" id="subCategoryInput" placeholder="소분류명 입력">
                <button class="add" onclick="addSubCategory()">추가</button>
            </div>
            <table id="subCategoryTable">
                <thead>
                    <tr>
                        <th>소분류명</th>
                        <th>대분류명</th>
                        <th>삭제</th>
                    </tr>
                </thead>
                <tbody>
    <c:forEach var="sub" items="${subCategoryList}">
        <tr data-main="${sub.categoryId}">
            <td>${sub.subCategoryName}</td>
            <td>
                <c:forEach var="cat" items="${categoryList}">
                    <c:if test="${cat.categoryId == sub.categoryId}">
                        ${cat.categoryName}
                    </c:if>
                </c:forEach>
            </td>
            <td><button class="delete" onclick="deleteRow(this)">삭제</button></td>
        </tr>
    </c:forEach>
</tbody>
            </table>
        </div>
    </div>

    <script>
        function addMainCategory() {
            const input = document.getElementById("mainCategoryInput");
            const value = input.value.trim();
            if (!value) return;

            const tbody = document.getElementById("mainCategoryTable").querySelector("tbody");
            const row = document.createElement("tr");
            row.innerHTML = `
                <td>${value}</td>
                <td><button class="delete" onclick="deleteRow(this, '${value}', 'main')">삭제</button></td>
            `;
            tbody.appendChild(row);

            const select = document.getElementById("mainCategorySelect");
            const option = document.createElement("option");
            option.value = value;
            option.textContent = value;
            select.appendChild(option);

            input.value = "";
        }

        function addSubCategory() {
            const mainSelect = document.getElementById("mainCategorySelect");
            const mainValue = mainSelect.value;
            const input = document.getElementById("subCategoryInput");
            const subValue = input.value.trim();

            if (!mainValue || !subValue) return;

            const tbody = document.getElementById("subCategoryTable").querySelector("tbody");
            const row = document.createElement("tr");
            row.setAttribute("data-main", mainValue);
            row.innerHTML = `
                <td>${subValue}</td>
                <td>${mainValue}</td>
                <td><button class="delete" onclick="deleteRow(this)">삭제</button></td>
            `;
            tbody.appendChild(row);

            input.value = "";
        }

        function deleteRow(btn, categoryName = "", type = "") {
            const row = btn.parentElement.parentElement;

            if (type === 'main') {
                const select = document.getElementById("mainCategorySelect");
                const subTbody = document.getElementById("subCategoryTable").querySelector("tbody");
                const subRows = subTbody.querySelectorAll("tr");

                const relatedSubs = [];
                subRows.forEach(subRow => {
                    if (subRow.getAttribute("data-main") === categoryName) {
                        const subName = subRow.querySelector("td").innerText;
                        relatedSubs.push(subName);
                    }
                });

                if (relatedSubs.length > 0) {
                    const message =
                        `해당 대분류 "${categoryName}"에는 아래 소분류가 있습니다:\n\n` +
                        relatedSubs.map(name => `- ${name}`).join('\n') +
                        `\n\n정말 삭제하시겠습니까?`;
                    if (!confirm(message)) return;
                }

                for (let i = 0; i < select.options.length; i++) {
                    if (select.options[i].value === categoryName) {
                        select.remove(i);
                        break;
                    }
                }

                subRows.forEach(subRow => {
                    if (subRow.getAttribute("data-main") === categoryName) {
                        subRow.remove();
                    }
                });
            }

            row.remove();
        }
    </script>
</body>
</html>
