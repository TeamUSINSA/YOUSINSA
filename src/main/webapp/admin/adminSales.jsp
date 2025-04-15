<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>매출조회 상세</title>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <style>
        body {
            font-family: 'Arial', sans-serif;
            background-color: #f9f9f9;
            margin: 0;
            padding: 30px;
            display: flex;
            justify-content: center;
        }

        .container {
            width: 800px;
            background-color: #fff;
            padding: 40px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }

        h2 {
            text-align: center;
            margin-bottom: 30px;
        }

        .filter-container {
            display: flex;
            justify-content: center;
            gap: 10px;
            margin-bottom: 20px;
            flex-wrap: wrap;
        }

        .filter-container input,
        .filter-container select,
        .filter-container button {
            padding: 8px;
            min-width: 120px;
        }

        .total-sales {
            text-align: center;
            margin-bottom: 30px;
            font-size: 18px;
            font-weight: bold;
        }

        canvas {
            max-width: 100%;
            margin: 0 auto 40px auto;
            display: block;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }

        table, th, td {
            border: 1px solid #ccc;
        }

        th, td {
            padding: 10px;
            text-align: center;
        }

        th {
            background-color: #f0f0f0;
        }

        h3 {
            margin-top: 40px;
            text-align: center;
        }
    </style>
</head>
<body>
<div class="container">
    <h2>매출조회 상세</h2>

    <form method="get" action="SalesDetailServlet">
        <div class="filter-container">
            <input type="date" name="startDate" value="${param.startDate}">
            <input type="date" name="endDate" value="${param.endDate}">

            <select name="mainCategory">
                <option value="">대분류</option>
                <c:forEach var="mainCat" items="${mainCategoryList}">
                    <option value="${mainCat}" ${param.mainCategory == mainCat ? 'selected' : ''}>${mainCat}</option>
                </c:forEach>
            </select>

            <select name="subCategory">
                <option value="">소분류</option>
                <c:forEach var="subCat" items="${subCategoryList}">
                    <option value="${subCat}" ${param.subCategory == subCat ? 'selected' : ''}>${subCat}</option>
                </c:forEach>
            </select>

            <button type="submit">조회</button>
        </div>
    </form>

    <div class="total-sales">총 매출: ${totalSales} 원</div>

    <canvas id="salesChart"></canvas>

    <h3>상위 10개 품목</h3>
    <table>
        <thead>
        <tr>
            <th>상품명</th>
            <th>제품번호</th>
            <th>판매량</th>
            <th>매출</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="product" items="${topProducts}">
            <tr>
                <td>${product.name}</td>
                <td>${product.code}</td>
                <td>${product.quantity}</td>
                <td>${product.sales}</td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>

<script>
    const ctx = document.getElementById('salesChart').getContext('2d');

    const chart = new Chart(ctx, {
        type: 'bar',
        data: {
            labels: [
                <c:forEach var="label" items="${chartLabels}" varStatus="loop">
                    "${label}"<c:if test="${!loop.last}">,</c:if>
                </c:forEach>
            ],
            datasets: [
                <c:forEach var="entry" items="${chartData}" varStatus="loop">
                {
                    label: "${entry.key}",
                    data: [<c:forEach var="val" items="${entry.value}" varStatus="i">${val}<c:if test="${!i.last}">,</c:if></c:forEach>],
                    backgroundColor: 'rgba(${100 + loop.index * 30}, 100, 255, 0.6)'
                }<c:if test="${!loop.last}">,</c:if>
                </c:forEach>
            ]
        },
        options: {
            responsive: true,
            scales: {
                y: {
                    beginAtZero: true,
                    title: {
                        display: true,
                        text: '판매량'
                    }
                },
                x: {
                    title: {
                        display: true,
                        text: '기간'
                    }
                }
            }
        }
    });
</script>
</body>
</html>
