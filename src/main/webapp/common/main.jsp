<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, dto.product.BannerProduct, dto.product.Product"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<%
List<BannerProduct> mainBannerList = (List<BannerProduct>) request.getAttribute("mainBannerList");
List<BannerProduct> subBannerList = (List<BannerProduct>) request.getAttribute("subBannerList"); 
List<Product> popularList = (List<Product>) request.getAttribute("popularList");
List<Product> recommendList = (List<Product>) request.getAttribute("recommendList");
%>


<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>유신사 베스트 컬렉션</title>
<style>
 .main-slide, .sub-slide {
  pointer-events: none;
}

.main-slide img, .sub-slide img {
  pointer-events: auto; /* 링크 클릭 가능하도록 이미지만 클릭 허용 */
}

.main-prev, .main-next,
.sub-prev, .sub-next {
  pointer-events: auto;
  z-index: 20;
}


</style>

<script>
  if ('serviceWorker' in navigator) {
    navigator.serviceWorker.register('/firebase-messaging-sw.js')
      .then(function(registration) {
        console.log('✅ Service Worker 등록 성공:', registration);
      })
      .catch(function(error) {
        console.error('❌ Service Worker 등록 실패:', error);
      });
  }
</script>
<script type="module" src="${pageContext.request.contextPath}/app.js"></script>


</head>
<body>
<jsp:include page="/header" />
<%@ include file="scrollTop.jsp" %>
	<!-- ✅ 슬라이드 배너 영역 -->
	<div style="max-width: 920px; margin: 0 auto;">
<div class="slider-container" data-slider="main"
	style="position: relative; overflow: hidden; width: 100%; height: 500px;">
	<c:forEach var="banner" items="${mainBannerList}" varStatus="status">
		<a
			href="${pageContext.request.contextPath}/productDetail?productId=${banner.productId}"
			class="main-slide"
			style="position: absolute; top: 0; left: 0; width: 100%; height: 100%;
				  opacity: ${status.first ? '1' : '0'}; z-index: ${status.first ? '1' : '0'}; transition: opacity 1s;">
			<img
			src="${pageContext.request.contextPath}/image/${banner.img}"
			alt="${banner.name}"
			style="width: 100%; height: 100%; object-fit: cover;">
		</a>
	</c:forEach>

	<!-- 좌우 화살표 -->
	<button class="main-prev" data-slider="main"
		style="position: absolute; top: 50%; left: 20px; transform: translateY(-50%); z-index: 10; font-size: 24px; background: rgba(0, 0, 0, 0.3); color: white; border: none; padding: 10px; cursor: pointer;">&#10094;</button>

	<button class="main-next" data-slider="main"
		style="position: absolute; top: 50%; right: 20px; transform: translateY(-50%); z-index: 10; font-size: 24px; background: rgba(0, 0, 0, 0.3); color: white; border: none; padding: 10px; cursor: pointer;">&#10095;</button>
</div>



<!-- ✅ 베스트 컬렉션 (인기상품) -->
<div style="text-align: center; margin: 40px 0;">
    <a href="/yousinsa/productList?popular" style="text-decoration: none; color: inherit;">
        <h2>유신사 인기 컬렉션</h2>
        <p>
            많은 사랑을 받은 스테디셀러가 한자리에!<br>
            고객들이 선택한 베스트 아이템을 만나보세요.
        </p>
    </a>
</div>


<div style="display: flex; justify-content: center; gap: 40px; flex-wrap: wrap; margin-bottom: 40px;">
    <c:forEach var="product" items="${popularList}">
        <a
            href="${pageContext.request.contextPath}/productDetail?productId=${product.productId}"
            style="text-align: center; text-decoration: none; color: black; width: 200px;">
            <img
                src="${pageContext.request.contextPath}/image/${product.mainImage1}"
                alt="${product.name}"
                style="width:200px; height:200px; object-fit:cover;" />
            <div style="margin-top: 8px;">
                ${product.name}<br />
                <c:set var="salePrice" value="${product.price - product.discount}" />
₩<fmt:formatNumber value="${salePrice}" type="number" />
                
            </div>
        </a>
    </c:forEach>
</div>
	


	<div class="slider-container" data-slider="sub"
		style="position: relative; overflow: hidden; width: 100%; height: 500px;">
		<c:forEach var="banner" items="${subBannerList}" varStatus="status">
  <a
    href="${pageContext.request.contextPath}/productDetail?productId=${banner.productId}"
    class="sub-slide"
    style="position: absolute; top: 0; left: 0; width: 100%; height: 100%;
      opacity: ${status.first ? '1' : '0'}; z-index: ${status.first ? '1' : '0'}; transition: opacity 1s;">
    <img
      src="${pageContext.request.contextPath}/image/${banner.img}"
      alt="${banner.name}"
      style="width: 100%; height: 100%; object-fit: cover;">
  </a>
</c:forEach>


		<!-- 좌우 화살표 -->
		<button class="sub-prev" data-slider="sub"
			style="position: absolute; top: 50%; left: 20px; transform: translateY(-50%); z-index: 10; font-size: 24px; background: rgba(0, 0, 0, 0.3); color: white; border: none; padding: 10px; cursor: pointer;">&#10094;</button>

		<button class="sub-next" data-slider="sub"
			style="position: absolute; top: 50%; right: 20px; transform: translateY(-50%); z-index: 10; font-size: 24px; background: rgba(0, 0, 0, 0.3); color: white; border: none; padding: 10px; cursor: pointer;">&#10095;</button>
	</div>



<div style="text-align: center; margin: 40px 0;">
	<a href="/yousinsa/productList?new" style="text-decoration: none; color: inherit;">
		<h2>유신사 신상품</h2>
		<p>
			익숙하면서도 새로운<br>
			세련되면서도<br>
			트렌디한 검소하면서도 품위있는<br>
			그대를 위한 선택.
		</p>
	</a>
</div>


<div style="display: flex; justify-content: center; gap: 40px; flex-wrap: wrap;">
    <c:forEach var="product" items="${newList}">
        <a
            href="${pageContext.request.contextPath}/productDetail?productId=${product.productId}"
            style="text-align: center; text-decoration: none; color: black; width: 200px;">
            <img
                src="${pageContext.request.contextPath}/image/${product.mainImage1}"
                alt="${product.name}"
                style="width:200px; height:200px; object-fit:cover;" />
            <div style="margin-top: 8px;">
                ${product.name}<br />
               <c:set var="salePrice" value="${product.price - product.discount}" />
₩<fmt:formatNumber value="${salePrice}" type="number" />
               	</div>
        </a>
    </c:forEach>
</div>

	<!-- 2 x 2 카드 구성 (축소 버전) -->
<div
	style="display: grid; grid-template-columns: repeat(2, 1fr); gap: 10px; max-width: 800px; margin: 50px auto;">
	<a href="#"
		style="text-decoration: none; color: black; position: relative; display: block; height: 200px; overflow: hidden;">
		<img src="${pageContext.request.contextPath}/image/img1.jpg"
		alt="2025 신상 컬렉션" style="width: 100%; height: 100%; object-fit: cover;">
		<div style="position: absolute; top: 10px; left: 10px; color: white; font-size: 14px;">
			<strong>2025 추천 컬렉션</strong><br> 개성에 대한 관심<br> <span>구매하기</span>
		</div>
	</a>
	<a href="#"
		style="text-decoration: none; color: black; position: relative; display: block; height: 200px; overflow: hidden;">
		<img src="${pageContext.request.contextPath}/image/img1.jpg"
		alt="현대적인 감성" style="width: 100%; height: 100%; object-fit: cover;">
		<div style="position: absolute; top: 10px; left: 10px; color: white; font-size: 14px;">
			<strong>현대적인 감성</strong><br> 가방의 새로운 아이콘<br> <span>구매하기</span>
		</div>
	</a>
	<a href="#"
		style="text-decoration: none; color: black; position: relative; display: block; height: 200px; overflow: hidden;">
		<img src="${pageContext.request.contextPath}/image/img1.jpg"
		alt="과감한 표현" style="width: 100%; height: 100%; object-fit: cover;">
		<div style="position: absolute; top: 10px; left: 10px; color: white; font-size: 14px;">
			<strong>과감한 표현</strong><br> 새로운 시각의 슈즈<br> <span>구매하기</span>
		</div>
	</a>
	<a href="#"
		style="text-decoration: none; color: black; position: relative; display: block; height: 200px; overflow: hidden;">
		<img src="${pageContext.request.contextPath}/image/img1.jpg"
		alt="예술성과 혁신" style="width: 100%; height: 100%; object-fit: cover;">
		<div style="position: absolute; top: 10px; left: 10px; color: white; font-size: 14px;">
			<strong>예술성과 혁신</strong><br> Signs of reality<br> <span>구매하기</span>
		</div>
	</a>
</div>
	
	</div>
   <%@ include file="../common/footer.jsp" %>
</body>

<script>

window.addEventListener('DOMContentLoaded', function () {
	  setupSlider("main", ".main-slide", ".main-prev", ".main-next");
	  setupSlider("sub", ".sub-slide", ".sub-prev", ".sub-next");

	  function setupSlider(key, className, prevSelector, nextSelector) {
	    const slides = document.querySelectorAll(className);
	    const prevBtn = document.querySelector(prevSelector);
	    const nextBtn = document.querySelector(nextSelector);

	    console.log(`[${key}] 슬라이드 개수: ${slides.length}`);
	    console.log(`[${key}] prev:`, prevBtn);
	    console.log(`[${key}] next:`, nextBtn);

	    if (!prevBtn || !nextBtn) {
	      console.warn(`[${key}] 버튼을 찾을 수 없습니다.`);
	      return;
	    }

	    if (slides.length === 0) return;

	    let currentIndex = 0;

	    function showSlide(index) {
	      slides.forEach((slide, i) => {
	        slide.style.opacity = (i === index) ? "1" : "0";
	        slide.style.zIndex = (i === index) ? "1" : "0";
	      });
	    }

	    function moveSlide(direction) {
	      currentIndex = (currentIndex + direction + slides.length) % slides.length;
	      showSlide(currentIndex);
	    }

	    prevBtn.addEventListener("click", () => {
	      console.log(`[${key}] ←`);
	      moveSlide(-1);
	    });

	    nextBtn.addEventListener("click", () => {
	      console.log(`[${key}] →`);
	      moveSlide(1);
	    });

	    showSlide(currentIndex);
	    setInterval(() => moveSlide(1), 5000);
	  }
	});


</script>



</html>
