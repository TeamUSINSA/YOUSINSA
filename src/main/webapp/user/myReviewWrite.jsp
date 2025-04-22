<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>후기 작성</title>
  <style>
    body {
      font-family: Arial, sans-serif;
      margin: 0;
    }

    .layout {
      display: flex;
      max-width: 1200px;
      margin: 0 auto;
    }

    .sidebar {
      width: 200px;
      background-color: #f8f8f8;
      padding: 20px;
      border-right: 1px solid #ddd;
    }

    .content {
      flex: 1;
      padding: 40px;
      max-width: 700px;
    }

    .title {
      font-size: 20px;
      font-weight: bold;
      margin-bottom: 20px;
    }

    .review-box {
      border: 1px solid #eee;
      background: #fafafa;
      padding: 30px;
      border-radius: 8px;
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

    .preview-img {
      margin-top: 10px;
      max-width: 100px;
      max-height: 100px;
      border: 1px solid #ccc;
      border-radius: 6px;
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

<div class="layout">
  <!-- 사이드바 -->
  <div class="sidebar">
    <%@ include file="mysidebar.jsp" %>
  </div>

  <!-- 본문 -->
  <div class="content">
    <div class="title">후기 작성</div>

    <div class="review-box">
      <form action="myReviewWrite" method="post" enctype="multipart/form-data">
        <!-- 상품 정보 -->
        <div class="product-summary">
          <img src="/yousinsa/image/${product.image}" alt="상품 이미지">
          <div>
            <div class="name">${product.name}</div>
            <div class="option">${product.option}</div>
          </div>
        </div>

        <!-- 숨겨진 상품 ID 전달 -->
        <input type="hidden" name="productId" value="${product.productId}">

        <!-- 별점 -->
        <div class="stars" id="star-rating">
          <span data-value="1">★</span>
          <span data-value="2">★</span>
          <span data-value="3">★</span>
          <span data-value="4">★</span>
          <span data-value="5">★</span>
        </div>
        <input type="hidden" name="rating" id="rating">

        <!-- 후기 내용 -->
        <textarea name="content" placeholder="상품에 대한 솔직한 리뷰를 남겨주세요."></textarea>

        <!-- 사진 첨부 -->
        <div class="photo-upload">
          <label for="image">+</label>
          <input type="file" name="image" id="image" accept="image/*">
          <img id="preview" class="preview-img" src="#" alt="이미지 미리보기">
        </div>

        <!-- 버튼 -->
        <div class="actions">
          <button type="button" class="cancel-btn" onclick="history.back()">취소</button>
          <button type="submit" class="submit-btn">등록</button>
        </div>
      </form>
    </div>
  </div>
</div>

<script>
  // 별점 선택
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

  // 이미지 미리보기
  const imageInput = document.getElementById("image");
  const previewImg = document.getElementById("preview");

  imageInput.addEventListener("change", function () {
    const file = this.files[0];
    if (file) {
      previewImg.src = URL.createObjectURL(file);
      previewImg.style.display = "block";
    } else {
      previewImg.src = "";
      previewImg.style.display = "none";
    }
  });
</script>

</body>
</html>
