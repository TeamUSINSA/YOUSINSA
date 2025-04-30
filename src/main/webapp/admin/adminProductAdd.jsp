<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<html>
<head>
<meta charset="UTF-8">
<title>상품 등록</title>
<jsp:include page="../common/header.jsp" />
<jsp:include page="adminSideBarStyle.jsp" />
<style>
body {
	margin: 0;
	background-color: #f8f8f8;
	font-family: 'Pretendard', sans-serif;
	font-weight: 400; /* ✅ 추가 */
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
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
  border-radius: 10px;
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

.sidebar-wrapper {
	width: 280px;
	background: white;
	box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
	border-radius: 10px;
	padding: 20px;
	flex-shrink: 0;
	min-height: 600px;
}

.sidebar h4 {
	font-size: 15px;
	font-weight: bold;
	margin-bottom: 10px;
	border-bottom: 1px solid #ddd;
	padding-bottom: 5px;
}

.menu-section {
	list-style: none;
	padding-left: 0;
	margin-bottom: 20px;
}

.menu-item {
	margin: 6px 0;
}

.menu-item a {
	text-decoration: none;
	color: black;
	font-size: 14px;
	display: inline-block;
}

.menu-item a:hover {
	font-weight: bold;
}

.container {
	display: flex;
	gap: 40px;
	align-items: flex-start;
	max-width: 1200px;
	margin: auto;
}

.content {
	flex: 1;
}

.left {
	flex: 1;
}

.main-image {
	display: block;
	width: 100%;
	aspect-ratio: 1/1;
	border: 1px solid #999;
	display: flex;
	align-items: center;
	justify-content: center;
	position: relative;
	box-shadow: 2px 2px 6px rgba(0, 0, 0, 0.1);
}

.add-image-btn {
	position: absolute;
	bottom: 10px;
	right: 10px;
	font-size: 12px;
	border: 1px solid #999;
	padding: 3px 8px;
	background: #f3f3f3;
	cursor: pointer;
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

.right {
	flex: 1;
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

.category-row select {
	flex: 1;
}

.radio-group {
	margin: 20px 0;
	display: flex;
	gap: 20px;
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

.size-sublist {
	margin-left: 20px;
	margin-top: 10px;
}

.sub-thumbnails {
	display: flex;
	gap: 10px;
	margin-top: 10px;
	justify-content: center;
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

.sub-thumb button {
	position: absolute;
	top: 2px;
	right: 2px;
	background: transparent;
	border: none;
	color: red;
	cursor: pointer;
	font-size: 13px;
	padding: 0;
}

.image-upload-section {
	margin-top: 80px;
	text-align: center;
}

.image-upload-section input[type="text"] {
	width: 300px;
	padding: 8px;
	margin-bottom: 20px;
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

.big-img-slot button {
	position: absolute;
	top: 4px;
	right: 4px;
	background: transparent;
	border: none;
	color: red;
	font-size: 16px;
	cursor: pointer;
}

.final-submit-section {
	text-align: center;
	margin-top: 60px;
}

.final-submit-section textarea {
	width: 80%;
	height: 150px;
	padding: 15px;
	font-size: 16px;
	resize: vertical;
	border: 1px solid #ccc;
	border-radius: 8px;
	margin-bottom: 20px;
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

.x {
	position: absolute;
	right: 2px;
	top: 0px;
	color: red;
	cursor: pointer;
}

img {
	display: block;
	width: 100%;
	height: auto;
}

.hide {
	display: none;
}
</style>
</head>

<body>
	<div class="content-wrapper">
		
			<jsp:include page="adminSideBar.jsp" />
		
		<div class="content">
			<h2>상품등록</h2>
			<form action="adminproductadd" method="post"
				enctype="multipart/form-data" id="regForm">
				<div class="container">
					<div class="left">
						<div class="main-image" onclick="$('#mainImage1').click()">
							<span class="x" id="mian-x">✖</span> <img id="main-image"
								src='${contextPath}/image/maincloths.png'>
						</div>

						<div class="sub-thumbnails">
							<div class="sub-thumb" onclick="$('#mainImage2').click()">
								<span class="x" id="sub-thumb1-x">✖</span><img id="sub-thumb1"
									src='${contextPath}/image/maincloths.png'>
							</div>
							<div class="sub-thumb" onclick="$('#mainImage3').click()">
								<span class="x" id="sub-thumb2-x">✖</span><img id="sub-thumb2"
									src='${contextPath}/image/maincloths.png'>
							</div>
							<div class="sub-thumb" onclick="$('#mainImage4').click()">
								<span class="x" id="sub-thumb3-x">✖</span><img id="sub-thumb3"
									src='${contextPath}/image/maincloths.png'>
							</div>
						</div>

						<div class="thumbnail-box" id="thumbnailBox"></div>
						<input type="file" id="mainImage1" accept="image/*"
							style="display: none" name="mainImage1"
							onchange="readURL(this,'main-image')"> <input type="file"
							id="mainImage2" accept="image/*" style="display: none"
							name="mainImage2" onchange="readURL(this,'sub-thumb1')">
						<input type="file" id="mainImage3" accept="image/*"
							style="display: none" name="mainImage3"
							onchange="readURL(this,'sub-thumb2')"> <input type="file"
							id="mainImage4" accept="image/*" style="display: none"
							name="mainImage4" onchange="readURL(this,'sub-thumb3')">
					</div>


					<div class="right">
						<div class="form-box">
							<div class="category-row">
								<select id="categorySelect" name="category">
									<c:forEach items="${categoryList }" var="category">
										<option value="${category.categoryId }">${category.categoryName }</option>
									</c:forEach>
								</select> <span> > </span> <select id="subCategorySelect"
									name="subCategory">
									<c:forEach items="${subCategoryList }" var="subCategory">
										<option value="${subCategory.subCategoryId }">${subCategory.subCategoryName }</option>
									</c:forEach>
								</select> <span style="margin-left: auto; font-size: 12px;">카테고리
									선택</span>
							</div>
							<div>
								<input type="text" name="name" placeholder="상품명 입력"
									style="width: 100%;" required>
							</div>
							<div>
								<input type="text" name="productId" placeholder="제품코드 입력"
									style="width: 100%;" required>
							</div>
							<div>
								<input type="text" name="cost" placeholder="원가 입력"
									style="width: 100%;" required>
							</div>
							<div>
								<input type="text" name="price" placeholder="판매가 입력"
									style="width: 100%;" required>
							</div>
							<div>
								<input type="text" name="discount" placeholder="할인가 입력"
									style="width: 100%;" required>
							</div>
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
				<br>
				<div class="image-upload-section">
					<div class="big-preview-box" id="bigPreviewBox">
						<div class="big-img-slot" onclick="$('#imageDetail1').click()">
							<span class="x" id="image1-x">✖</span><img id="image1"
								src="${contextPath}/image/cloths.jpg">
						</div>
						<div class="big-img-slot" onclick="$('#imageDetail2').click()">
							<span class="x" id="image2-x">✖</span><img id="image2"
								src="${contextPath}/image/cloths.jpg">
						</div>
						<div class="big-img-slot" onclick="$('#imageDetail3').click()">
							<span class="x" id="image3-x">✖</span><img id="image3"
								src="${contextPath}/image/cloths.jpg">
						</div>
						<div class="big-img-slot" onclick="$('#imageDetail4').click()">
							<span class="x" id="image4-x">✖</span><img id="image4"
								src="${contextPath}/image/cloths.jpg">
						</div>
					</div>
					<input type="file" accept="image/*" style="display: none"
						name="image1" id="imageDetail1" onchange="readURL(this,'image1')">
					<input type="file" accept="image/*" style="display: none"
						name="image2" id="imageDetail2" onchange="readURL(this,'image2')">
					<input type="file" accept="image/*" style="display: none"
						name="image3" id="imageDetail3" onchange="readURL(this,'image3')">
					<input type="file" accept="image/*" style="display: none"
						name="image4" id="imageDetail4" onchange="readURL(this,'image4')">
					<input type="text" id="bigImageTitle" placeholder="제품 설명글 입력"
						name="description1" required />
					<div class="big-preview-box" id="sizeImageBox">
						<div class="big-img-slot hide" id="sizeImageSlot">
							<span class="x" id="sizeImage-x">✖</span><img id="sizeImage">
						</div>
					</div>
					<input type="file" id="sizeImageInput" accept="image/*"
						style="display: none" name="sizeChart"
						onchange="sizeImageChange(this,'sizeImage')"> <span
						class="add-btn" id="sizeImageUploadBtn"
						onclick="$('#sizeImageInput').click()">+ 사이즈 이미지</span>
				</div>
				<div class="final-submit-section">
					<button class="submit-btn">등록하기</button>
				</div>
			</form>
		</div>
	</div>
	<jsp:include page="../common/footer.jsp" />
</body>
<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
<script>
	function readURL(input, view){
		if(input.files && input.files[0]){
			
			var reader = new FileReader();
			reader.onload = function(e){
				document.getElementById(view).src = e.target.result;
			}
			reader.readAsDataURL(input.files[0]);
		}
	}	
	
	//----------------
	// 대표이미지
	//----------------
	//--대표이미지 삭제
	$("#mian-x").click(function(e) {
		e.stopPropagation();
		$(this).next().attr("src","<c:out value='${contextPath}/image/maincloths.png'/>");
		$("#mainImage1").val("");
	})
	$("#sub-thumb1-x").click(function(e) {
		e.stopPropagation();
		console.log("<c:out value='${contextPath}/image/maincloths.png'/>")
		$(this).next().attr("src","<c:out value='${contextPath}/image/maincloths.png'/>");
		$("#mainImage2").val("");
	})
	$("#sub-thumb2-x").click(function(e) {
		e.stopPropagation();
		$(this).next().attr("src","<c:out value='${contextPath}/image/maincloths.png'/>");
		$("#mainImage3").val("");
	})
	$("#sub-thumb3-x").click(function(e) {
		e.stopPropagation();
		$(this).next().attr("src","<c:out value='${contextPath}/image/maincloths.png'/>");
		$("#mainImage4").val("");
	})
	
	//----------------
	// 상세이미지
	//----------------
	//-- 상세이미지 삭제
	$("#image1-x").click(function(e) {
		e.stopPropagation();
		$(this).next().attr("src","<c:out value='${contextPath}/image/cloths.jpg'/>");
		$("#imageDetail1").val("");
	})
	$("#image2-x").click(function(e) {
		e.stopPropagation();
		$(this).next().attr("src","<c:out value='${contextPath}/image/cloths.jpg'/>");
		$("#imageDetail2").val("");
	})
	$("#image3-x").click(function(e) {
		e.stopPropagation();
		$(this).next().attr("src","<c:out value='${contextPath}/image/cloths.jpg'/>");
		$("#imageDetail3").val("");
	})
	$("#image4-x").click(function(e) {
		e.stopPropagation();
		$(this).next().attr("src","<c:out value='${contextPath}/image/cloths.jpg'/>");
		$("#imageDetail4").val("");
	})
	
	//----------------
	//-- 사이즈 설명 이미지
	//----------------
	$("#sizeImage-x").click(function(e) {
		e.stopPropagation();
		$(this).parent().addClass("hide");
		$("#sizeImageInput").val("");
	})
	
	function sizeImageChange(input, view) {
		readURL(input, view);
		 $('#sizeImageSlot').removeClass("hide");
	}
	

        
	//----------------
	$("#colorAdd").click(() => {
        createColorBlock();
    });
        
	//----------------
    function createColorBlock() {
    	const block = $('<div class="color-block"></div>')
        const headerRow = $('<div class="option-row"></div>');
        
        const colorLabel = $("<span>색 상</span>&nbsp;<input type='text' name='color' required>")

        const removeColorBtn = $("<span style='color:red'>✖</span>")
        removeColorBtn.click(function() {
        	block.remove();
        })

        headerRow.append(colorLabel);
        headerRow.append(removeColorBtn);
        block.append(headerRow);
        
        const sizeRadioDiv = $('<div></div>')
        const sizeRadioF = $(`<input type='checkbox' value='F' checked><span>One Size</span>`)
        sizeRadioDiv.append(sizeRadioF);
		block.append(sizeRadioDiv);
        let sizeType = $(`<input type='hidden' name='sizeType'>`);
        block.append(sizeType);
        
        const oneSizeTable = `<table class="option_table" id="sizeTable">
        	<tr><td>사이즈</td><td>재고량</td></tr>
        	<tr><td>F</td><td><input type="number" name="size-f" required/></td></tr>
        	<tr style="display:none"><td>XS</td><td><input type="number" name="size-xs"/></td></tr>
        	<tr style="display:none"><td>S</td><td><input type="number" name="size-s"/></td></tr>
        	<tr style="display:none"><td>M</td><td><input type="number" name="size-m"/></td></tr>
        	<tr style="display:none"><td>L</td><td><input type="number" name="size-l"/></td></tr>
        	<tr style="display:none"><td>XL</td><td><input type="number" name="size-xl"/></td></tr>
        </table>`;

        const multiSizeTable = `<table class="option_table" id="sizeTable">
        	<tr><td>사이즈</td><td>재고량</td></tr>
        	<tr style="display:none"><td>F</td><td><input type="number" name="size-f"/></td></tr>
        	<tr><td>XS</td><td><input type="number" name="size-xs"/></td></tr>
        	<tr><td>S</td><td><input type="number" name="size-s"/></td></tr>
        	<tr><td>M</td><td><input type="number" name="size-m"/></td></tr>
        	<tr><td>L</td><td><input type="number" name="size-l"/></td></tr>
        	<tr><td>XL</td><td><input type="number" name="size-xl"/></td></tr>
        </table>`;
        block.append(oneSizeTable);   
        
        sizeRadioF.change(function() {
        	if(sizeRadioF.is(':checked')) {
            	sizeRadioF.parent().next().next().remove();
            	block.append(oneSizeTable);
            	sizeType.val('F')
        	} else {
        		sizeRadioF.parent().next().next().remove();
        		block.append(multiSizeTable);
            	sizeType.val('M')
        	}
        })

        $("#options-container").append(block);
    }
        
	
	//-----------------
	$("#categorySelect").change(function() {
		let categoryId = $(this).val();
		console.log(categoryId)
		$.ajax({
			url:'subCategoryList',
			type:'post',
			data:{categoryId:categoryId},
			success:function(result) {
				let subCategoryList = JSON.parse(result);
				console.log(subCategoryList);
				let options = $(subCategoryList.map(function(c) {
					return `<option value="\${c.subCategoryId}">\${c.subCategoryName}</option>`;
				}).join());
				console.log(options);
				$("#subCategorySelect").children().remove();
				$("#subCategorySelect").append(options);
			},
			error: function(err) {
				console.log(err)
			}
		})
	})
	
	$("#regForm").submit(function(e) {
		
	})
</script>
</body>

</html>