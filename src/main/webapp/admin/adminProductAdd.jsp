<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>상품 등록</title>

<jsp:include page="../common/header.jsp" />
<jsp:include page="adminSideBarStyle.jsp" />

<style>
body {
    font-family: 'Pretendard', sans-serif;
    background-color: #f8f8f8;
    margin: 0;
    min-height: 100vh;
}

.content-wrapper {
    display: flex;
    gap: 20px;
    margin: 20px;
}

.content-wrapper > div:first-child {
    width: 280px;
    background: white;
    border-radius: 10px;
    box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
    padding: 20px;
    flex-shrink: 0;
    min-height: 600px;
}

.main-content {
    flex-grow: 1;
    background: white;
    padding: 40px 50px;
    border-radius: 10px;
    box-shadow: 0 4px 10px rgba(0, 0, 0, 0.05);
    min-height: 600px;
}

h2 {
    font-size: 24px;
    font-weight: bold;
    margin-bottom: 30px;
}

.container {
    display: flex;
    gap: 40px;
    align-items: flex-start;
}

.left, .right {
    flex: 1;
}

.main-image {
    display: flex;
    width: 100%;
    aspect-ratio: 1/1;
    border: 1px solid #999;
    align-items: center;
    justify-content: center;
    position: relative;
    box-shadow: 2px 2px 6px rgba(0, 0, 0, 0.1);
}

.thumbnail-box {
    display: flex;
    gap: 10px;
    flex-wrap: wrap;
    margin-top: 10px;
    font-size: 13px;
    align-items: center;
}

.thumbnail-box div {
    width: 70px;
    height: 70px;
    border: 1px solid #999;
    box-shadow: 1px 1px 4px rgba(0, 0, 0, 0.1);
}

.sub-thumbnails {
    display: flex;
    gap: 10px;
    margin-top: 10px;
    justify-content: center;
}

.sub-thumb {
    display: block;
    width: 80px;
    height: 80px;
    border: 1px solid #999;
    box-shadow: 1px 1px 4px rgba(0, 0, 0, 0.1);
    position: relative;
    background-color: #f5f5f5;
    overflow: hidden;
}

.sub-thumb img {
    width: 100%;
    height: 100%;
    object-fit: cover;
}

.form-box {
    border: 1px solid #999;
    padding: 20px;
    margin-bottom: 20px;
}

.form-box div {
    margin-bottom: 10px;
}

input, select {
    padding: 5px;
    box-sizing: border-box;
}

.category-row {
    display: flex;
    gap: 5px;
    align-items: center;
}

.dynamic-options {
    margin-top: 20px;
}

.color-block {
    margin-bottom: 20px;
    border-bottom: 1px solid #ccc;
    padding-bottom: 10px;
}

.option-row {
    display: flex;
    gap: 10px;
    align-items: center;
    margin-bottom: 10px;
}

.option-row select, .option-row input {
    padding: 5px;
}

.option-row button {
    background: none;
    border: none;
    font-size: 16px;
    cursor: pointer;
    color: red;
}

.add-btn {
    display: inline-block;
    margin-top: 10px;
    padding: 5px 10px;
    background-color: #007BFF;
    color: white;
    border: none;
    border-radius: 4px;
    cursor: pointer;
}

.image-upload-section {
    margin-top: 80px;
    text-align: center;
}

.big-preview-box {
    display: flex;
    flex-direction: column;
    align-items: center;
    gap: 20px;
    margin-bottom: 20px;
}

.big-img-slot {
    width: 400px;
    height: 400px;
    border: 2px solid #ccc;
    background-color: #fafafa;
    display: flex;
    align-items: center;
    justify-content: center;
    position: relative;
    overflow: hidden;
}

.big-img-slot img {
    width: 100%;
    height: 100%;
    object-fit: cover;
}

.final-submit-section {
    text-align: center;
    margin-top: 60px;
}

.submit-btn {
    padding: 12px 30px;
    background-color: #28a745;
    color: white;
    font-size: 16px;
    border: none;
    border-radius: 6px;
    cursor: pointer;
}

.submit-btn:hover {
    background-color: #218838;
}

#bigImageTitle {
    width: 500px;
    height: 80px;
    padding: 10px;
    font-size: 15px;
    resize: vertical;
    border-radius: 6px;
    border: 1px solid #ccc;
}

img {
    display: block;
    width: 100%;
    height: auto;
}

.hide {
    display: none;
}

.x {
    position: absolute;
    right: 2px;
    top: 0px;
    color: red;
    cursor: pointer;
}

.option_table>tbody>tr>td {
    border: 1px solid black;
    text-align: center;
}
.option_table>tbody>tr>td:nth-child(1) {
    width: 80px;
}
.option_table>tbody>tr>td>input {
    border: none;
    text-align: right;
    width: 100px;
}
</style>
</head>

<body>

<div class="content-wrapper">
  <jsp:include page="adminSideBar.jsp" />

  <div class="main-content">
    <h2>상품 등록</h2>

    <form action="adminProductAdd" method="post" enctype="multipart/form-data" id="regForm">
      <div class="container">
        <div class="left">
          <div class="main-image" onclick="$('#mainImage1').click()">
            <span class="x" id="main-x">✖</span>
            <img id="main-image" src="${contextPath}/image/maincloths.png">
          </div>

          <div class="sub-thumbnails">
            <div class="sub-thumb" onclick="$('#mainImage2').click()">
              <span class="x" id="sub-thumb1-x">✖</span><img id="sub-thumb1" src="${contextPath}/image/maincloths.png">
            </div>
            <div class="sub-thumb" onclick="$('#mainImage3').click()">
              <span class="x" id="sub-thumb2-x">✖</span><img id="sub-thumb2" src="${contextPath}/image/maincloths.png">
            </div>
            <div class="sub-thumb" onclick="$('#mainImage4').click()">
              <span class="x" id="sub-thumb3-x">✖</span><img id="sub-thumb3" src="${contextPath}/image/maincloths.png">
            </div>
          </div>

          <div class="thumbnail-box" id="thumbnailBox"></div>

          <input type="file" id="mainImage1" name="mainImage1" style="display: none" accept="image/*" onchange="readURL(this,'main-image')">
          <input type="file" id="mainImage2" name="mainImage2" style="display: none" accept="image/*" onchange="readURL(this,'sub-thumb1')">
          <input type="file" id="mainImage3" name="mainImage3" style="display: none" accept="image/*" onchange="readURL(this,'sub-thumb2')">
          <input type="file" id="mainImage4" name="mainImage4" style="display: none" accept="image/*" onchange="readURL(this,'sub-thumb3')">
        </div>

        <div class="right">
          <div class="form-box">
            <div class="category-row">
              <select id="categorySelect" name="category">
                <c:forEach items="${categoryList}" var="category">
                  <option value="${category.categoryId}">${category.categoryName}</option>
                </c:forEach>
              </select>
              <span> > </span>
              <select id="subCategorySelect" name="subCategory">
                <c:forEach items="${subCategoryList}" var="subCategory">
                  <option value="${subCategory.subCategoryId}">${subCategory.subCategoryName}</option>
                </c:forEach>
              </select>
              <span style="margin-left: auto; font-size: 12px;">카테고리 선택</span>
            </div>

            <div><input type="text" name="name" placeholder="상품명 입력" style="width: 100%;" required></div>
            <div><input type="text" name="productId" placeholder="제품코드 입력" style="width: 100%;" required></div>
            <div><input type="text" name="cost" placeholder="원가 입력" style="width: 100%;" required></div>
            <div><input type="text" name="price" placeholder="판매가 입력" style="width: 100%;" required></div>
            <div><input type="text" name="discount" placeholder="할인가 입력" style="width: 100%;" required></div>
          </div>

          <div class="dynamic-options">
            <div id="options-container"></div>
          </div>

          <div class="dynamic-options">
            <div style="margin-bottom: 10px;">
              <span class="add-btn" id="colorAdd">색상추가</span>
            </div>
          </div>
        </div>
      </div>

      <div class="image-upload-section">
        <div class="big-preview-box" id="bigPreviewBox">
          <div class="big-img-slot" onclick="$('#imageDetail1').click()">
            <span class="x" id="image1-x">✖</span><img id="image1" src="${contextPath}/image/cloths.jpg">
          </div>
          <div class="big-img-slot" onclick="$('#imageDetail2').click()">
            <span class="x" id="image2-x">✖</span><img id="image2" src="${contextPath}/image/cloths.jpg">
          </div>
          <div class="big-img-slot" onclick="$('#imageDetail3').click()">
            <span class="x" id="image3-x">✖</span><img id="image3" src="${contextPath}/image/cloths.jpg">
          </div>
          <div class="big-img-slot" onclick="$('#imageDetail4').click()">
            <span class="x" id="image4-x">✖</span><img id="image4" src="${contextPath}/image/cloths.jpg">
          </div>
        </div>

        <input type="file" id="imageDetail1" name="image1" style="display: none" accept="image/*" onchange="readURL(this,'image1')">
        <input type="file" id="imageDetail2" name="image2" style="display: none" accept="image/*" onchange="readURL(this,'image2')">
        <input type="file" id="imageDetail3" name="image3" style="display: none" accept="image/*" onchange="readURL(this,'image3')">
        <input type="file" id="imageDetail4" name="image4" style="display: none" accept="image/*" onchange="readURL(this,'image4')">

        <input type="text" id="bigImageTitle" placeholder="제품 설명글 입력" name="description1" required>

        <div class="big-preview-box" id="sizeImageBox">
          <div class="big-img-slot hide" id="sizeImageSlot">
            <span class="x" id="sizeImage-x">✖</span><img id="sizeImage">
          </div>
        </div>

        <input type="file" id="sizeImageInput" name="sizeChart" style="display: none" accept="image/*" onchange="sizeImageChange(this,'sizeImage')">
        <span class="add-btn" id="sizeImageUploadBtn" onclick="$('#sizeImageInput').click()">+ 사이즈 이미지</span>
      </div>

      <div class="final-submit-section">
        <button class="submit-btn">등록하기</button>
      </div>
    </form>
  </div>
</div>

	<jsp:include page="../common/footer.jsp" />

	<!-- 스크립트 -->
	<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
	<script>
function readURL(input, view){
  if(input.files && input.files[0]){
    const reader = new FileReader();
    reader.onload = function(e){
      $("#" + view).attr("src", e.target.result);
    }
    reader.readAsDataURL(input.files[0]);
  }
}

function sizeImageChange(input, view) {
  readURL(input, view);
  $('#sizeImageSlot').removeClass("hide");
}

// 대표/서브/상세이미지 삭제
$("#main-x").click(function(e) { e.stopPropagation(); $("#main-image").attr("src", "${contextPath}/image/maincloths.png"); $("#mainImage1").val(""); });
$("#sub-thumb1-x").click(function(e) { e.stopPropagation(); $("#sub-thumb1").attr("src", "${contextPath}/image/maincloths.png"); $("#mainImage2").val(""); });
$("#sub-thumb2-x").click(function(e) { e.stopPropagation(); $("#sub-thumb2").attr("src", "${contextPath}/image/maincloths.png"); $("#mainImage3").val(""); });
$("#sub-thumb3-x").click(function(e) { e.stopPropagation(); $("#sub-thumb3").attr("src", "${contextPath}/image/maincloths.png"); $("#mainImage4").val(""); });
$("#image1-x").click(function(e) { e.stopPropagation(); $("#image1").attr("src", "${contextPath}/image/cloths.jpg"); $("#imageDetail1").val(""); });
$("#image2-x").click(function(e) { e.stopPropagation(); $("#image2").attr("src", "${contextPath}/image/cloths.jpg"); $("#imageDetail2").val(""); });
$("#image3-x").click(function(e) { e.stopPropagation(); $("#image3").attr("src", "${contextPath}/image/cloths.jpg"); $("#imageDetail3").val(""); });
$("#image4-x").click(function(e) { e.stopPropagation(); $("#image4").attr("src", "${contextPath}/image/cloths.jpg"); $("#imageDetail4").val(""); });
$("#sizeImage-x").click(function(e) { e.stopPropagation(); $("#sizeImageSlot").addClass("hide"); $("#sizeImageInput").val(""); });

function createColorBlock() {
  const block = $('<div class="color-block"></div>');
  const headerRow = $('<div class="option-row"></div>');

  const colorLabel = $("<span>색 상</span>&nbsp;<input type='text' name='color' required>");
  const removeColorBtn = $("<span style='color:red; cursor:pointer;'>✖</span>");
  removeColorBtn.click(function () { block.remove(); });

  headerRow.append(colorLabel).append(removeColorBtn);
  block.append(headerRow);

  const sizeRadioDiv = $('<div></div>');
  const sizeRadioF = $("<input type='checkbox' value='F' checked><span>One Size</span>");
  sizeRadioDiv.append(sizeRadioF);
  block.append(sizeRadioDiv);

  const sizeType = $("<input type='hidden' name='sizeType' value='F'>");
  block.append(sizeType);

  const oneSizeTable = `<table class="option_table"><tr><td>사이즈</td><td>재고량</td></tr><tr><td>F</td><td><input type="number" name="F" required></td></tr></table>`;
  const multiSizeTable = `<table class="option_table"><tr><td>사이즈</td><td>재고량</td></tr><tr><td>XS</td><td><input type="number" name="XS"></td></tr><tr><td>S</td><td><input type="number" name="S"></td></tr><tr><td>M</td><td><input type="number" name="M"></td></tr><tr><td>L</td><td><input type="number" name="L"></td></tr><tr><td>XL</td><td><input type="number" name="XL"></td></tr></table>`;

  block.append(oneSizeTable);

  sizeRadioF.change(function () {
    block.find("table.option_table").remove();
    if (sizeRadioF.is(":checked")) {
      block.append(oneSizeTable);
      sizeType.val("F");
    } else {
      block.append(multiSizeTable);
      sizeType.val("M");
    }
  });

  $("#options-container").append(block);
}

$("#colorAdd").click(() => { createColorBlock(); });

$("#categorySelect").change(function() {
  let categoryId = $(this).val();
  $.ajax({
    url:'subCategoryList',
    type:'post',
    data:{categoryId:categoryId},
    success:function(result) {
      let subCategoryList = JSON.parse(result);
      let options = $(subCategoryList.map(function(c) {
        return `<option value="\${c.subCategoryId}">\${c.subCategoryName}</option>`;
      }).join(""));
      $("#subCategorySelect").empty().append(options);
    },
    error: function(err) { console.log(err); }
  });
});

// 폼 제출 검증
$("#regForm").submit(function(e) {
  let isValid = true;
  $(".color-block").each(function() {
    let sizeType = $(this).find("input[name='sizeType']").val();
    let color = $(this).find("input[name='color']").val();
    if (sizeType === 'F') {
      let fInput = $(this).find("input[name='F']");
      if (!fInput.val() || fInput.val().trim() === "") {
        alert(`색상 '${color}'의 F 사이즈 수량을 입력해 주세요.`);
        isValid = false;
        return false;
      }
    }
  });

  if (!isValid) {
    e.preventDefault();
    return false;
  }
});
</script>

</body>
</html>