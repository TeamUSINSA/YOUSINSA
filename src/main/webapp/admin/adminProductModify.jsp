<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<c:set var="mainImageIcon" value="${contextPath}/image/maincloths.png" />
<c:set var="imageIcon" value="${contextPath}/image/cloths.jpg" />
<html>
<head>
<meta charset="UTF-8">
<title>상품 수정</title>
<style>
body {
	font-family: sans-serif;
}

.container {
	display: flex;
	gap: 40px;
	align-items: flex-start;
	/* max-width: 1200px; */
	margin: auto;
}

.content {
	background-color: white;
	padding: 30px;
	border-radius: 12px;
	box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
	margin-left: 20px;
	margin-right: 20px;
	display: inline-block;
	width: 1200px;
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

.pspan {
	display: inline-block;
	width: 20%;
	margin-left: auto;
}

.cselect {
	display: inline-block;
	width: 40%;
}

.dinput {
	margin-left: 1%;
	width: 79%;
}

span, td, input {
	font-size: 14px;
	"
}
</style>
</head>

<body>
	<jsp:include page="../common/header.jsp" />
	<div style="width: 1500px;">
		<jsp:include page="adminSideBar.jsp" />
		<div class="content">
			<h2>상품수정</h2>
			<form action="adminProductModify" method="post"
				enctype="multipart/form-data" id="regForm">
				<input type="hidden" name="oldMainImage1" id="oldMainImage1"
					value="${pao.product.mainImage1}"> <input type="hidden"
					name="oldMainImage2" id="oldMainImage2"
					value="${pao.product.mainImage2}"> <input type="hidden"
					name="oldMainImage3" id="oldMainImage3"
					value="${pao.product.mainImage3}"> <input type="hidden"
					name="oldMainImage4" id="oldMainImage4"
					value="${pao.product.mainImage4}"> <input type="hidden"
					name="oldImage1" id="oldImage1" value="${pao.product.image1}">
				<input type="hidden" name="oldImage2" id="oldImage2"
					value="${pao.product.image2}"> <input type="hidden"
					name="oldImage3" id="oldImage3" value="${pao.product.image3}">
				<input type="hidden" name="oldImage4" id="oldImage4"
					value="${pao.product.image4}"> <input type="hidden"
					name="oldSizeChart" id="oldSizeChart"
					value="${pao.product.sizeChart}">
				<div class="container">
					<div class="left">
						<div class="main-image" onclick="$('#mainImage1').click();">
							<span class="x" id="mian-x">✖</span> <img id="main-image"
								src='${(pao.product.mainImage1 eq null || pao.product.mainImage1 eq "")? mainImageIcon:"image?filename="+=pao.product.mainImage1}'>
						</div>

						<div class="sub-thumbnails">
							<div class="sub-thumb" onclick="$('#mainImage2').click();">
								<span class="x" id="sub-thumb1-x">✖</span> <img id="sub-thumb1"
									src='${(pao.product.mainImage2 eq null || pao.product.mainImage2 eq null)? mainImageIcon:"image?filename="+=pao.product.mainImage2}'>
							</div>
							<div class="sub-thumb" onclick="$('#mainImage3').click();">
								<span class="x" id="sub-thumb2-x">✖</span> <img id="sub-thumb2"
									src='${(pao.product.mainImage3 eq null || pao.product.mainImage3 eq "")? mainImageIcon:"image?filename="+=pao.product.mainImage3}'>
							</div>
							<div class="sub-thumb" onclick="$('#mainImage4').click();">
								<span class="x" id="sub-thumb3-x">✖</span> <img id="sub-thumb3"
									src='${(pao.product.mainImage4 eq null || pao.product.mainImage4 eq "")? mainImageIcon:"image?filename="+=pao.product.mainImage4}'>
							</div>
						</div>

						<div class="thumbnail-box" id="thumbnailBox"></div>
						<input type="file" id="mainImage1" accept="image/*"
							style="display: none" name="mainImage1"
							onchange="readURL(this,'main-image')" value="AA"> <input
							type="file" id="mainImage2" accept="image/*"
							style="display: none" name="mainImage2"
							onchange="readURL(this,'sub-thumb1')"> <input type="file"
							id="mainImage3" accept="image/*" style="display: none"
							name="mainImage3" onchange="readURL(this,'sub-thumb2')">
						<input type="file" id="mainImage4" accept="image/*"
							style="display: none" name="mainImage4"
							onchange="readURL(this,'sub-thumb3')">
					</div>


					<div class="right">
						<div class="form-box">
							<div class="category-row">
								<span class="pspan">카테고리</span> <select id="categorySelect"
									name="category" class="cselect">
									<c:forEach items="${categoryList}" var="category">
										<option value="${category.categoryId}"
											<c:if test="${category.categoryId eq pao.product.category1}">selected</c:if>>
											${category.categoryName}</option>
									</c:forEach>
								</select> <select id="subCategorySelect" name="subCategory"
									class="cselect">
									<c:forEach items="${subCategoryList}" var="subCategory">
										<option value="${subCategory.subCategoryId}"
											<c:if test="${subCategory.subCategoryId eq pao.product.subCategoryId}">selected</c:if>>
											${subCategory.subCategoryName}</option>
									</c:forEach>
								</select>
							</div>

							<div>
								<span class="pspan">상품명</span><input type="text" name="name"
									placeholder="상품명 입력" class="dinput" required
									value=${pao.product.name }>
							</div>
							<div>
								<span class="pspan">제품코드</span><input type="text"
									name="productId" placeholder="제품코드 입력" class="dinput" required
									value=${pao.product.productId }>
							</div>
							<div>
								<span class="pspan">원가</span><input type="text" name="cost"
									placeholder="원가 입력" class="dinput" required
									value=${pao.product.cost }>
							</div>
							<div>
								<span class="pspan">판매가</span><input type="text" name="price"
									placeholder="판매가 입력" class="dinput" required
									value=${pao.product.price }>
							</div>
							<div>
								<span class="pspan">할인가</span><input type="text" name="discount"
									placeholder="할인가 입력" class="dinput" required
									value=${pao.product.discount }>
							</div>
						</div>

						<input type='radio' value='F' name="sizeType"
							onclick="$('#options-container').empty()"
							${pao.product.sizeType eq 'F'? 'checked':'' }><span>Free
							Size</span> <input type='radio' value='M' name="sizeType"
							onclick="$('#options-container').empty()"
							${pao.product.sizeType eq 'M'? 'checked':'' }><span>Multi
							Size</span>

						<div class="dynamic-options">

							<div id="options-container">
								<c:forEach items="${pao.optionList }" var="option">
									<div class="color-block">
										<div class="option-row">
											<span>색 상</span>&nbsp;<input type='text' name='color'
												required value='${option.color}'> <span
												style='color: red'
												onclick="$(this).parent().parent().remove();">✖</span>
										</div>
										<table class="option_table" id="sizeTable">
											<tr>
												<td>사이즈</td>
												<td>재고량</td>
											</tr>
											<c:forEach items="${option.sizeQuanity }" var="sq">
												<tr>
													<td>${sq.size }</td>
													<td><input type="number" name="${sq.size}"
														value="${sq.quantity }"></td>
												</tr>
											</c:forEach>
										</table>
									</div>
								</c:forEach>
							</div>
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
						<div class="big-img-slot"
							onclick="$('#imageDetail1').click(); $('#oldImage1').val('');">
							<span class="x" id="image1-x">✖</span> <img id="image1"
								src='${(pao.product.image1 eq null || pao.product.image1 eq "")? imageIcon:"image?filename="+=pao.product.image1 }'>
						</div>
						<div class="big-img-slot"
							onclick="$('#imageDetail2').click(); $('#oldImage2').val('');">
							<span class="x" id="image2-x">✖</span> <img id="image2"
								src='${(pao.product.image2 eq null || pao.product.image2 eq "")? imageIcon:"image?filename="+=pao.product.image2 }'>
						</div>
						<div class="big-img-slot"
							onclick="$('#imageDetail3').click(); $('#oldImage3').val('');">
							<span class="x" id="image3-x">✖</span> <img id="image3"
								src='${(pao.product.image3 eq null || pao.product.image3 eq "")? imageIcon:"image?filename="+=pao.product.image3 }'>
						</div>
						<div class="big-img-slot"
							onclick="$('#imageDetail4').click(); $('#oldImage4').val('');">
							<span class="x" id="image4-x">✖</span> <img id="image4"
								src='${(pao.product.image4 eq null || pao.product.image4 eq "")? imageIcon:"image?filename="+=pao.product.image4 }'>
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
						name="description1" required value="${pao.product.description1 }" />
					<div class="big-preview-box" id="sizeImageBox">
						<div
							class="big-img-slot ${(pao.product.sizeChart eq null || pao.product.sizeChart eq '')? 'hide':'' }"
							id="sizeImageSlot">
							<span class="x" id="sizeImage-x">✖</span> <img id="sizeImage"
								src="${(pao.product.sizeChart eq null || pao.product.sizeChart eq '')? imageIcon:'image?filename='+=pao.product.sizeChart }">
						</div>
					</div>
					<input type="file" id="sizeImageInput" accept="image/*"
						style="display: none" name="sizeChart"
						onchange="sizeImageChange(this,'sizeImage')"> <span
						class="add-btn" id="sizeImageUploadBtn"
						onclick="$('#sizeImageInput').click()">+ 사이즈 설명 등록</span>
				</div>
				<div class="final-submit-section">
					<button class="submit-btn">수정하기</button>
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
		$("#mainImage1").val(null);
		$('#oldMainImage1').val(null);
	})
	$("#sub-thumb1-x").click(function(e) {
		e.stopPropagation();
		console.log("<c:out value='${contextPath}/image/maincloths.png'/>")
		$(this).next().attr("src","<c:out value='${contextPath}/image/maincloths.png'/>");
		$("#mainImage2").val(null);
		$('#oldMainImage2').val(null);
	})
	$("#sub-thumb2-x").click(function(e) {
		e.stopPropagation();
		$(this).next().attr("src","<c:out value='${contextPath}/image/maincloths.png'/>");
		$("#mainImage3").val(null);
		$('#oldMainImage3').val(null);
	})
	$("#sub-thumb3-x").click(function(e) {
		e.stopPropagation();
		$(this).next().attr("src","<c:out value='${contextPath}/image/maincloths.png'/>");
		$("#mainImage4").val(null);
		$('#oldMainImage4').val(null);
	})
	
	//----------------
	// 상세이미지
	//----------------
	//-- 상세이미지 삭제
	$("#image1-x").click(function(e) {
		e.stopPropagation();
		$(this).next().attr("src","<c:out value='${contextPath}/image/cloths.jpg'/>");
		$("#imageDetail1").val(null);
		$('#oldImage1').val(null);
	})
	$("#image2-x").click(function(e) {
		e.stopPropagation();
		$(this).next().attr("src","<c:out value='${contextPath}/image/cloths.jpg'/>");
		$("#imageDetail2").val(null);
		$('#oldImage2').val(null);
	})
	$("#image3-x").click(function(e) {
		e.stopPropagation();
		$(this).next().attr("src","<c:out value='${contextPath}/image/cloths.jpg'/>");
		$("#imageDetail3").val(null);
		$('#oldImage3').val(null);
	})
	$("#image4-x").click(function(e) {
		e.stopPropagation();
		$(this).next().attr("src","<c:out value='${contextPath}/image/cloths.jpg'/>");
		$("#imageDetail4").val(null);
		$('#oldImage4').val(null);
	})
	
	//----------------
	//-- 사이즈 설명 이미지
	//----------------
	$("#sizeImage-x").click(function(e) {
		e.stopPropagation();
		$(this).parent().addClass("hide");
		$("#sizeImageInput").val(null);
		$('#oldSizeChart').val(null);
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
               
        let sizeTable ;
        if($("input[name='sizeType']:checked").val()=='F') {
        	sizeTable = `<table class="option_table" id="sizeTable">
        	<tr><td>사이즈</td><td>재고량</td></tr>
        	<tr><td>F</td><td><input type="number" name="F" required min="1" value='0'/></td></tr>
        	</table>`;      	
        } else {
        	sizeTable = `<table class="option_table" id="sizeTable">
            	<tr><td>사이즈</td><td>재고량</td></tr>
            	<tr><td>XS</td><td><input type="number" name="XS" min="1" value='0'/></td></tr>
            	<tr><td>S</td><td><input type="number" name="S" min="1" value='0'/></td></tr>
            	<tr><td>M</td><td><input type="number" name="M" min="1" value='0'/></td></tr>
            	<tr><td>L</td><td><input type="number" name="L" min="1" value='0'/></td></tr>
            	<tr><td>XL</td><td><input type="number" name="XL" min="1" value='0'/></td></tr>
            </table>`; 
        }
        

        block.append(sizeTable);   
        
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
	
</script>
</body>

</html>