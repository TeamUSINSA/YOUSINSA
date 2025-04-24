<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
    <meta charset="UTF-8">
    <title>상품 수정</title>
    <style>
        body { font-family: sans-serif; padding: 40px; }
        .container { display: flex; gap: 40px; align-items: flex-start; max-width: 1200px; margin: auto; }
        .left { flex: 1; }
        .main-image {
            width: 100%; aspect-ratio: 1 / 1; border: 1px solid #999;
            display: flex; align-items: center; justify-content: center;
            position: relative; box-shadow: 2px 2px 6px rgba(0, 0, 0, 0.1);
        }
        .sub-thumbnails { display: flex; gap: 10px; margin-top: 10px; justify-content: center; }
        .sub-thumb {
            width: 80px; height: 80px; border: 1px solid #999;
            box-shadow: 1px 1px 4px rgba(0, 0, 0, 0.1);
            position: relative; background-color: #f5f5f5; overflow: hidden;
        }
        .sub-thumb img { width: 100%; height: 100%; object-fit: cover; }
        .thumbnail-box { display: flex; gap: 10px; flex-wrap: wrap; margin-top: 10px; font-size: 13px; align-items: center; }
        .right { flex: 1; }
        .form-box { border: 1px solid #999; padding: 20px; margin-bottom: 20px; }
        .form-box div { margin-bottom: 10px; }
        input, select { padding: 5px; box-sizing: border-box; }
        .category-row { display: flex; gap: 5px; align-items: center; }
        .category-row select { flex: 1; }
        .radio-group { margin: 20px 0; display: flex; gap: 20px; align-items: center; }
        .add-btn {
            display: inline-block; margin-top: 10px; padding: 5px 10px;
            background-color: #007BFF; color: white; border: none;
            border-radius: 4px; cursor: pointer;
        }
        .image-upload-section { margin-top: 60px; text-align: center; }
        .big-preview-box {
            display: flex; flex-direction: column; align-items: center;
            gap: 20px; margin-bottom: 20px;
        }
        .big-img-slot {
            width: 400px; height: 400px; border: 2px solid #ccc;
            background-color: #fafafa; display: flex;
            align-items: center; justify-content: center;
            position: relative; overflow: hidden;
        }
        .big-img-slot img { width: 100%; height: 100%; object-fit: cover; }
        .big-img-slot button {
            position: absolute; top: 4px; right: 4px;
            background: transparent; border: none; color: red;
            font-size: 16px; cursor: pointer;
        }
        #bigImageTitle {
            width: 500px; height: 80px; padding: 10px;
            font-size: 15px; resize: vertical; border-radius: 6px; border: 1px solid #ccc;
        }
    </style>
</head>

<body>
<h2>상품 수정</h2>
<form action="/yousinsa/admin/adminCategory.jsp" method="post" enctype="multipart/form-data">
    <div class="container">
        <div class="left">
            <div class="main-image">
                <c:choose>
                    <c:when test="${not empty product.imageList}">
                        <img src="${product.imageList[0]}" style="width:100%; height:100%; object-fit:cover;">
                    </c:when>
                    <c:otherwise>
                        <span>이미지 영역</span>
                    </c:otherwise>
                </c:choose>
            </div>

            <div class="sub-thumbnails">
                <c:forEach var="img" items="${product.imageList}" begin="1" end="3">
                    <div class="sub-thumb"><img src="${img}" /></div>
                </c:forEach>
            </div>

            <div style="margin-top: 10px;">
                <button type="button" id="addImageBtn" class="add-btn">+ 이미지 수정</button>
            </div>
            <div class="thumbnail-box" id="thumbnailBox"></div>
            <input type="file" name="images" id="imageInput" multiple accept="image/*" style="display:none">
        </div>

        <div class="right">
            <div class="form-box">
                <div class="category-row">
                    <select name="category1">
                        <option selected>${product.category1}</option>
                    </select>
                    <span> > </span>
                    <select name="category2">
                        <option selected>${product.category2}</option>
                    </select>
                </div>
                <div><input type="text" name="name" value="${product.name}" placeholder="상품명 입력" style="width:100%;"></div>
                <div><input type="text" name="code" value="${product.code}" placeholder="제품코드 입력" style="width:100%;"></div>
                <div><input type="text" name="price" value="${product.price}" placeholder="판매가 입력" style="width:100%;"></div>
                <div><input type="text" name="discountPrice" value="${product.discountPrice}" placeholder="할인가 입력" style="width:100%;"></div>
            </div>

            <div class="radio-group">
                <span>분류:</span>
                <label><input type="radio" name="type" value="new" ${product.type == 'new' ? 'checked' : ''}> 신상품</label>
                <label><input type="radio" name="type" value="popular" ${product.type == 'popular' ? 'checked' : ''}> 인기상품</label>
                <label><input type="radio" name="type" value="recommend" ${product.type == 'recommend' ? 'checked' : ''}> 추천상품</label>
            </div>
        </div>
    </div>

    <div class="image-upload-section">
        <div class="big-preview-box" id="bigPreviewBox">
            <c:forEach var="descImg" items="${product.descriptionImages}">
                <div class="big-img-slot">
                    <img src="${descImg}">
                </div>
            </c:forEach>
        </div>
        <input type="file" name="descriptionImages" id="bigImageInput" multiple accept="image/*" style="display:none">
        <button type="button" class="add-btn" id="bigImageUploadBtn">+ 이미지 등록</button><br>
        <textarea id="bigImageTitle" name="description" placeholder="제품 설명글 입력">${product.description}</textarea>
    </div>

    <div class="image-upload-section">
        <div class="big-preview-box" id="sizeImageBox">
            <c:if test="${not empty product.sizeImage}">
                <div class="big-img-slot"><img src="${product.sizeImage}"></div>
            </c:if>
        </div>
        <input type="file" name="sizeImage" id="sizeImageInput" accept="image/*" style="display:none">
        <button type="button" class="add-btn" id="sizeImageUploadBtn">+ 사이즈 설명표 추가</button>
    </div>

    <div class="image-upload-section" style="margin-top: 40px;">
        <button type="submit" class="add-btn" style="font-size:16px; padding:10px 20px;">상품 수정 완료</button>
    </div>
</form>
</body>
</html>
