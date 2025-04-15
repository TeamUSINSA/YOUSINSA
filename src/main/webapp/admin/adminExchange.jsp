<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<html>
<head>
    <meta charset="UTF-8">
    <title>교환 접수</title>
    <style>
        body {
            font-family: sans-serif;
            margin: 0;
            padding: 0;
            min-width: 1000px;
            background-color: #f9f9f9;
        }

        h2 {
            width: 700px;
            margin: 50px auto 10px auto;
            text-align: left;
        }

        .container {
            width: 700px;
            margin: 0 auto 50px auto;
            border: 1px solid #ccc;
            border-radius: 10px;
            padding: 30px;
            background-color: white;
        }

        .search-container {
            text-align: left;
            margin-bottom: 20px;
        }

        .search-container form {
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .btn-search {
            padding: 8px 20px;
            background-color: black;
            color: white;
            border: none;
            border-radius: 5px;
            margin-left: 10px;
            cursor: pointer;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }

        th, td {
            padding: 12px;
            border-bottom: 1px solid #ddd;
            text-align: center;
        }

        th {
            background-color: #f2f2f2;
        }

        .status-complete {
            color: green;
            font-weight: bold;
        }

        .status-pending {
            color: orange;
            font-weight: bold;
        }

        .status-rejected {
            color: red;
            font-weight: bold;
        }

        .pagination {
            text-align: center;
            margin-top: 20px;
        }

        .pagination a {
            margin: 0 5px;
            text-decoration: none;
            color: #333;
        }

        .pagination a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <h2>교환 접수</h2>
    <div class="container">
        <div class="search-container">
            <form method="get" action="">
                <label><input type="radio" name="status" value="all" checked> 전체</label>
                <label><input type="radio" name="status" value="completed"> 교환 완료</label>
                <label><input type="radio" name="status" value="pending"> 교환 대기</label>
                <button type="submit" class="btn-search">검색</button>
            </form>
        </div>

        <table>
            <thead>
                <tr>
                    <th>접수일시</th>
                    <th>주문번호</th>
                    <th>환불사유</th>
                    <th>현재상태</th>
                </tr>
            </thead>
            <tbody>
                <c:choose>
                    <c:when test="${not empty returnList}">
                        <c:forEach var="return" items="${returnList}">
                            <tr>
                                <td>${refund.date}</td>
                                <td>${refund.orderNumber}</td>
                                <td>${refund.reason}</td>
                                <td>
                                    <c:choose>
                                        <c:when test="${return.status eq '교환 수락'}">
                                            <span class="status-complete">교환 수락</span>
                                        </c:when>
                                        <c:when test="${return.status eq '신청 접수'}">
                                            <span class="status-pending">신청 접수</span>
                                        </c:when>
                                        <c:when test="${return.status eq '교환 반려'}">
                                            <span class="status-rejected">교환 반려</span>
                                        </c:when>
                                        <c:otherwise>
                                            ${return.status}
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                            </tr>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <tr>
                            <td colspan="4">검색 결과가 없습니다.</td>
                        </tr>
                    </c:otherwise>
                </c:choose>
            </tbody>
        </table>

        <div class="pagination">
            <c:forEach var="i" begin="1" end="${totalPages}">
                <a href="returnList.jsp?page=${i}">${i}</a>
            </c:forEach>
        </div>
    </div>
</body>
</html>
