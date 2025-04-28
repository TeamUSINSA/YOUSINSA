<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>매출조회 상세</title>
  <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
  <jsp:include page="../common/header.jsp" />
  <jsp:include page="adminSideBarStyle.jsp" />
  <style>
    body {
      font-family: 'Pretendard', sans-serif;
      background-color: #f9f9f9;
      margin: 0;
      padding: 0;
      display: flex;
      min-height: 100vh;
      flex-direction: column;
    }

    .layout {
      flex: 1;
      display: flex;
    }

    .main-wrapper {
      flex-grow: 1;
      padding: 40px 60px;
      background-color: #f8f8f8;
    }

    .container {
      background-color: white;
      padding: 40px;
      border-radius: 12px;
      box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
      max-width: 1000px;
      margin: auto;
    }

    h2 {
      text-align: center;
      margin-bottom: 30px;
      font-size: 26px;
    }

    .filter-container {
      display: flex;
      flex-wrap: wrap;
      justify-content: center;
      gap: 10px;
      margin-bottom: 20px;
    }

    .filter-container input,
    .filter-container select,
    .filter-container button {
      padding: 8px;
      min-width: 120px;
      border-radius: 6px;
      border: 1px solid #ccc;
    }

    .filter-container button {
      background-color: #111;
      color: #fff;
      border: none;
      cursor: pointer;
    }

    .filter-container button:hover {
      background-color: #333;
    }

    .total-sales {
      text-align: center;
      margin: 30px 0;
      font-size: 20px;
      font-weight: bold;
    }

    canvas {
      max-width: 100%;
      margin-bottom: 40px;
    }

    h3 {
      text-align: center;
      margin-top: 40px;
      font-size: 22px;
    }

    table {
      width: 100%;
      border-collapse: collapse;
      margin-top: 20px;
    }

    table, th, td {
      border: 1px solid #ddd;
    }

    th, td {
      padding: 12px;
      text-align: center;
    }

    th {
      background-color: #f0f0f0;
    }
  </style>
</head>
<body>
<div class="layout">
  <jsp:include page="adminSideBar.jsp" />
  <div class="main-wrapper">
    <div class="container">
      <h2>매출조회 상세</h2>

      <form method="get" action="adminSales">
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
  </div>
</div>
<jsp:include page="../common/footer.jsp" />

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
        datasets: [{
            label: '총 매출',
            data: [
                <c:forEach var="value" items="${chartData}" varStatus="loop">
                    ${value}<c:if test="${!loop.last}">,</c:if>
                </c:forEach>
            ],
            backgroundColor: 'rgba(75, 192, 192, 0.6)',
            borderColor: 'rgba(75, 192, 192, 1)',
            borderWidth: 1
        }]
    },
    options: {
        responsive: true,
        scales: {
            y: {
                beginAtZero: true,
                title: {
                    display: true,
                    text: '매출 (원)'
                }
            },
            x: {
                title: {
                    display: true,
                    text: '날짜'
                }
            }
        }
    }
});
</script>
</body>
</html>
