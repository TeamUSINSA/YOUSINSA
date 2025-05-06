<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/header" />
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>나의 후기</title>
  <style>
    body {
      font-family: 'Arial', sans-serif;
      margin: 0;
      padding: 0;
    }

    .layout {
      display: flex;
      max-width: 1200px;
      margin: 0 auto;
      padding: 40px 20px;
      gap: 30px;
    }

    .sidebar {
      width: 200px;
      background: #f7f7f7;
      padding: 10px;
      border-radius: 8px;
    }

    .content {
      flex: 1;
    }

    .title {
      font-size: 20px;
      font-weight: bold;
      margin-bottom: 20px;
    }

    .review-table {
      width: 100%;
      border-collapse: collapse;
      font-size: 14px;
    }

    .review-table th, .review-table td {
      border: 1px solid #ddd;
      padding: 15px;
      vertical-align: top;
    }

    .review-table th {
      background-color: #f9f9f9;
      text-align: left;
    }

    .product-info {
      display: flex;
      gap: 15px;
    }

    .product-info img {
      width: 80px;
      height: 100px;
      object-fit: cover;
      border: 1px solid #ccc;
    }

    .product-details {
      display: flex;
      flex-direction: column;
      gap: 5px;
    }

    .star-rating {
      color: #f5a623;
      font-size: 18px;
      margin-bottom: 10px;
    }

    .review-buttons {
      margin-top: 10px;
    }

    .review-buttons button {
      padding: 5px 10px;
      font-size: 13px;
      margin-right: 5px;
      border: 1px solid #ccc;
      background-color: white;
      cursor: pointer;
    }

    .review-buttons button:hover {
      background-color: #f0f0f0;
    }
  </style>
</head>
<body>

<div class="layout">
  <!-- ⭐ 사이드바 -->

    <%@ include file="mysidebar.jsp" %>


  <!-- ⭐ 본문 -->
  <div class="content">
    <div class="title">나의 후기</div>

    <table class="review-table">
      <thead>
        <tr>
          <th style="width: 60%;">상품</th>
          <th style="width: 40%;">리뷰</th>
        </tr>
      </thead>
      <tbody>
        <c:forEach var="review" items="${reviewList}">
          <tr>
            <td>
              <div class="product-info">
                <c:if test="${not empty review.image}">
      <img src="${pageContext.request.contextPath}/upload/${review.image}"
           alt="리뷰 이미지">
    </c:if>
                <div class="product-details">
                  <div><strong>${review.productName}</strong></div>
                  <div>색상 : ${review.color}</div>
                  <div>사이즈 : ${review.size}</div>
                  <div>주문일자 : ${review.orderDate}</div>
                </div>
              </div>
            </td>
            <td>
              <div class="star-rating">
                <c:forEach begin="1" end="5" var="i">
                  <c:choose>
                    <c:when test="${i <= review.rating}">★</c:when>
                    <c:otherwise>☆</c:otherwise>
                  </c:choose>
                </c:forEach>
              </div>
              <div>${review.content}</div>
              <div style="margin-top: 10px;">작성일자 : ${review.regDate}</div>
              <div class="review-buttons">
                <form action="myReviewModify" method="get" style="display:inline;">
  					<input type="hidden" name="reviewId" value="${review.reviewId}">
  					<button type="submit">후기 수정</button>
				</form>
                <form action="deleteReview" method="post" style="display:inline;" onsubmit="return confirm('정말 삭제하시겠습니까?');">
                  <input type="hidden" name="reviewId" value="${review.reviewId}">
                  <button type="submit">후기 삭제</button>
                </form>
              </div>
            </td>
          </tr>
        </c:forEach>
      </tbody>
    </table>
  </div>
</div>
<%@ include file="../common/footer.jsp" %>
</body>
</html>
