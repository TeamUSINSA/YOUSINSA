<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <c:set var="contextPath" value="${pageContext.request.contextPath}" />

        <!DOCTYPE html>
        <html>

        <head>
            <meta charset="UTF-8">
            <title>회원검색</title>
            <style>
                body {
                    font-family: Arial, sans-serif;
                    min-width: 1000px;
                    background-color: #f9f9f9;
                    margin: 0;
                    padding: 0;
                }

                h2 {
                    width: 600px;
                    margin: 50px auto 10px auto;
                    text-align: left;
                }

                .container {
                    width: 600px;
                    margin: 0 auto 50px auto;
                    padding: 20px;
                    border: 1px solid #ccc;
                    border-radius: 10px;
                    background-color: white;
                }

                .search-box {
                    display: flex;
                    margin-bottom: 20px;
                }

                select,
                input[type="text"],
                button {
                    padding: 5px;
                    margin-right: 5px;
                }

                .info-table {
                    border-collapse: collapse;
                    width: 100%;
                    margin-bottom: 20px;
                }

                .info-table td {
                    border: 1px solid #ccc;
                    padding: 8px;
                }

                .info-table .label {
                    background-color: #90ee90;
                    width: 100px;
                    font-weight: bold;
                }

                .order-table {
                    width: 100%;
                    border-collapse: collapse;
                    margin-top: 10px;
                    box-shadow: 0 2px 6px rgba(0, 0, 0, 0.05);
                }

                .order-table thead th {
                    background-color: #f7f7f7;
                    font-weight: bold;
                    padding: 12px;
                    border-bottom: 2px solid #ddd;
                    text-align: center;
                }

                .order-table tbody td {
                    padding: 12px;
                    border-bottom: 1px solid #eee;
                    text-align: center;
                    font-size: 14px;
                }

                .order-table tbody tr:hover {
                    background-color: #f0f8ff;
                    cursor: pointer;
                }

                .status-complete {
                    color: green;
                    font-weight: bold;
                }

                .status-shipping {
                    color: dodgerblue;
                    font-weight: bold;
                }

                .status-waiting {
                    color: orange;
                    font-weight: bold;
                }
            </style>
            <script>
                function goToOrderDetail(orderId) {
                    location.href = "orderDetail.jsp?orderId=" + orderId;
                }
            </script>
        </head>

        <body>
            <h2>회원검색</h2>
            <div class="container">
                <div class="search-box">
                    <form method="get" action="">
                        <select name="searchType">
                            <option value="id" <c:if test="${param.searchType == 'id'}">selected</c:if>>아이디</option>
                            <option value="memberNo" <c:if test="${param.searchType == 'memberNo'}">selected</c:if>>회원번호
                            </option>
                        </select>
                        <input type="text" name="keyword" value="${param.keyword}" placeholder="검색어 입력" />
                        <button type="submit">검색</button>
                    </form>
                </div>

                <table class="info-table">
                    <tr>
                        <td class="label">이름</td>
                        <td>${member.name}</td>
                    </tr>
                    <tr>
                        <td class="label">아이디</td>
                        <td>${member.id}</td>
                    </tr>
                    <tr>
                        <td class="label">회원번호</td>
                        <td>${member.memberNo}</td>
                    </tr>
                    <tr>
                        <td class="label">전화번호</td>
                        <td>${member.phone}</td>
                    </tr>
                    <tr>
                        <td class="label">가입일자</td>
                        <td>${member.joinDate}</td>
                    </tr>
                    <tr>
                        <td class="label">생일</td>
                        <td>${member.birth}</td>
                    </tr>
                    <tr>
                        <td class="label">이메일</td>
                        <td>${member.email}</td>
                    </tr>
                    <tr>
                        <td class="label">주소</td>
                        <td>${member.address}</td>
                    </tr>
                    <c:if test="${not empty member.withdrawal}">
                        <tr>
                            <td class="label">탈퇴사유</td>
                            <td>${member.withdrawal}</td>
                        </tr>
                    </c:if>


                </table>

                <table class="order-table">
                    <thead>
                        <tr>
                            <th>주문번호</th>
                            <th>주문일자</th>
                            <th>상태</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="order" items="${orderList}">
                            <tr onclick="goToOrderDetail(${order.orderId})">
                                <td>${order.orderId}</td>
                                <td>${order.orderDate}</td>
                                <td>
                                    <c:choose>
                                        <c:when test="${order.status == '배송완료'}">
                                            <span class="status-complete">${order.status}</span>
                                        </c:when>
                                        <c:when test="${order.status == '배송중'}">
                                            <span class="status-shipping">${order.status}</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="status-waiting">${order.status}</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                            </tr>
                        </c:forEach>

                        <c:if test="${empty orderList}">
                            <tr>
                                <td colspan="3" style="color: gray;">주문 내역이 없습니다.</td>
                            </tr>
                        </c:if>
                    </tbody>
                </table>
            </div>
        </body>

        </html>