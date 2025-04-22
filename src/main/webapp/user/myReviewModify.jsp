<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>리뷰 수정</title>
  <style>
    body {
      font-family: Arial, sans-serif;
      margin: 0;
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

    .review-box {
      background: #fafafa;
      border: 1px solid #eee;
      border-radius: 8px;
      padding: 30px;
    }

    .product-summary {
      display: flex;
      align-items: center;
      margin-bottom: 20px;
      background: white;
      padding: 15px;
      border-radius: 6px;
      border: 1px solid #ddd;
    }

    .product-summary img {
      width: 60px;
      height: 60px;
      object-fit: cover;
      border-radius: 6px;
      margin-right: 15px;
    }

    .product-summary .name {
      font-weight: bold;
    }

    .stars {
      margin: 15px 0;
      font-size: 20px;
      color: #ccc;
      cursor: pointer;
    }

    .stars span.active {
      color: #f5a623;
    }

    textarea {
      width: 100%;
      height: 100px;
      padding: 10px;
      font-size: 14px;
      border: 1px solid #ccc;
      border-radius: 5px;
      resize: none;
    }

    .photo-upload {
      margin: 20px 0;
    }

    .photo-upload label {
      display: inline-block;
      width: 60px;
      height: 60px;
      border: 1px dashed #ccc;
      text-align: center;
      line-height: 60px;
      font-size: 24px;
      color: #999;
      border-radius: 6px;
      cursor: pointer;
    }

    .photo-upload input {
      display: none;
    }

    .actions {
      display: flex;
      justify-content: space-between;
      margin-top: 30px;
    }

    .actions button {
      flex: 1;
      padding: 12px;
      font-size: 14px;
      border: none;
      cursor: pointer;
    }

    .cancel-btn {
      background: #eee;
      margin-right: 10px;
    }

    .submit-btn {
      background: black;
      color: white;
    }
  </style>
</head>
<body>

<%@ include file="/common/header.jsp" %>

<div class="layout">
  <!-- ⭐ 사이드바 -->
  <div class="sidebar">
    <%@ include file="mysidebar.jsp" %>
  </div>

  <!-- ⭐ 본문 -->
  <div class="content">
    <div class="title">리뷰 수정</div>

    <div class="review-box">
      <form action="myReviewModify" method="post" enctype="multipart/form-data">
        <!-- 상품 정보 -->
        <div class="product-summary">
          <img src="/yousinsa/image/${review.productImage}" alt="상품 이미지">
          <div>
            <div class="name">${review.productName}</div>
            <div class="option">색상: ${review.color} / 사이즈: ${review.size}</div>
          </div>
        </div>

        <!-- ⭐ hidden 필드 -->
        <input type="hidden" name="reviewId" value="${review.reviewId}">
        <input type="hidden" name="originalImage" value="${review.image}">
        <input type="hidden" name="rating" id="rating" value="${review.rating}">

        <!-- 별점 -->
        <div class="stars" id="star-rating">
          <c:forEach begin="1" end="5" var="i">
            <span data-value="${i}" class="<c:if test='${i <= review.rating}'>active</c:if>">★</span>
          </c:forEach>
        </div>

        <!-- 후기 내용 -->
        <textarea name="content">${review.content}</textarea>

        <!-- 사진 첨부 -->
		<div class="photo-upload">
  			<label for="image">+</label>
  			<input type="file" name="image" id="image" accept="image/*" onchange="previewImage(this)">
		</div>

		<!-- ⭐ 미리보기 이미지 -->
		<div style="margin-top: 10px;">
		  <img id="preview" src="/yousinsa/upload/${review.image}" alt="이미지 미리보기"
		       style="max-width: 150px; max-height: 150px; border: 1px solid #ccc; border-radius: 4px;">
		</div>
		
        <!-- 버튼 -->
        <div class="actions">
          <button type="button" class="cancel-btn" onclick="history.back()">취소</button>
          <button type="submit" class="submit-btn">수정</button>
        </div>
      </form>
    </div>
  </div>
</div>

<%@ include file="/common/footer.jsp" %>

<script>
  const stars = document.querySelectorAll("#star-rating span");
  const ratingInput = document.getElementById("rating");

  stars.forEach((star) => {
    star.addEventListener("click", () => {
      const selected = parseInt(star.dataset.value);
      ratingInput.value = selected;
      stars.forEach((s, i) => {
        s.classList.toggle("active", i < selected);
      });
    });
  });
  
  // ⭐ 이미지 미리보기 함수
  function previewImage(input) {
    const file = input.files[0];
    const preview = document.getElementById('preview');

    if (file) {
      const reader = new FileReader();
      reader.onload = function(e) {
        preview.src = e.target.result;
      }
      reader.readAsDataURL(file);
    } else {
      // 선택 취소 시 기존 이미지로 복원
      preview.src = "/yousinsa/upload/${review.image}";
    }
  }
</script>

</body>
</html>
