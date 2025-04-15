
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>주문내역조회</title>
  <style>
     body {
    font-family: sans-serif;
    display: flex;
    justify-content: center;
    align-items: flex-start;
    min-height: 100vh;
    background-color: #f9f9f9;
    padding: 40px 20px;
  }

  .container {
    width: 100%;
    max-width: 700px; /* 더 얇게 줄임 */
    background-color: #fff;
    padding: 20px;
    border-radius: 10px;
    box-shadow: 0 0 10px rgba(0,0,0,0.1);
  }

  h2 {
    text-align: left;
    margin-bottom: 20px;
  }

  .search-box {
    border: 1px solid #ccc;
    padding: 15px;
    border-radius: 10px;
    margin-bottom: 20px;
  }

  .search-box select,
  .search-box input[type="text"],
  .search-box button {
    margin-right: 8px;
    padding: 5px 8px;
  }

  .radio-group {
    margin: 10px 0;
  }

  .radio-group label {
    margin-right: 10px;
  }

  table {
    width: 100%;
    border-collapse: collapse;
    margin-top: 10px;
  }

  table thead {
    background-color: #f0f0f0;
  }

  table th, table td {
    padding: 8px;
    border: 1px solid #ddd;
    text-align: center;
  }

  select.status-select {
    padding: 4px 6px;
  }

  .btn-change {
    padding: 4px 8px;
    background-color: black;
    color: white;
    border: none;
    border-radius: 5px;
    cursor: pointer;
  }

  tr:hover {
    background-color: #f5f5f5;
  }

  .pagination {
    text-align: center;
    margin-top: 20px;
  }

  .pagination a {
    display: inline-block;
    margin: 0 4px;
    padding: 5px 10px;
    text-decoration: none;
    border-radius: 5px;
    background-color: #eee;
    color: #333;
  }

  .pagination .active {
    background-color: black;
    color: white;
  }
  </style>
</head>
<body>

  <div class="container">
    <h2>주문내역조회</h2>

    <div class="search-box">
      <select>
        <option value="id">회원 ID</option>
        <option value="">회원 번호</option>
        <option value="">주문 번호</option>
      </select>
      <input type="text" placeholder="검색어 입력">
      <button>검색</button>

      <div class="radio-group">
        <strong>기간 선택:</strong>
        <label><input type="radio" name="dateRange" value="all" checked> 전체</label>
        <label><input type="radio" name="dateRange" value="3"> 3일</label>
        <label><input type="radio" name="dateRange" value="7"> 7일</label>
        <label><input type="radio" name="dateRange" value="30"> 30일</label>
      </div>

      <div class="radio-group">
        <strong>상태 선택:</strong>
        <label><input type="radio" name="status" value="all" checked> 전체</label>
        <label><input type="radio" name="status" value="ready"> 배송준비</label>
        <label><input type="radio" name="status" value="shipping"> 배송중</label>
        <label><input type="radio" name="status" value="complete"> 배송완료</label>
      </div>
    </div>

    <table>
      <thead>
        <tr>
          <th>주문일자</th>
          <th>회원ID</th>
          <th>주문번호</th>
          <th>상태</th> <!-- 상태 칼럼 -->
        </tr>
      </thead>
      <tbody>
        <c:forEach var="order" items="${orderList}">
          <tr onclick="location.href='orderDetail.jsp?orderNo=${order.orderNo}'" style="cursor:pointer;">
            <td>${order.orderDate}</td>
            <td>${order.memberId}</td>
            <td>${order.orderNo}</td>
            
            <!-- 상태 변경 영역: 클릭 전파 방지 -->
            <td onclick="event.stopPropagation();">
              <form action="updateStatus.jsp" method="post">
                <input type="hidden" name="orderNo" value="${order.orderNo}">
                <select name="status" class="status-select">
                  <option value="배송준비" ${order.status == '배송준비' ? 'selected' : ''}>배송준비</option>
                  <option value="배송중" ${order.status == '배송중' ? 'selected' : ''}>배송중</option>
                  <option value="배송완료" ${order.status == '배송완료' ? 'selected' : ''}>배송완료</option>
                </select>
                <button type="submit" class="btn-change">변경</button>
              </form>
            </td>
          </tr>
        </c:forEach>
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
