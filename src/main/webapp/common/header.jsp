<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
<script src="https://www.gstatic.com/firebasejs/9.6.11/firebase-app-compat.js"></script>
<script src="https://www.gstatic.com/firebasejs/9.6.11/firebase-messaging-compat.js"></script>
<style>
/* 초기화 */
* {
	box-sizing: border-box;
}

body {
	margin: 0;
	font-family: Arial, sans-serif;
	background-color: #fff;
}

/* 상단 바 */
.top-bar {
	display: flex;
	justify-content: space-between;
	align-items: center;
	padding: 10px 20px;
	border-bottom: 1px solid #ddd;
	font-size: 14px;
	background-color: #fff;
}

.top-bar a {
	margin-left: 20px;
	text-decoration: none;
	color: #333;
}

.top-menu a {
	margin-left: 20px;
	text-decoration: none;
	color: #333;
}

/* 네비게이션 바 */
.nav-bar {
	display: flex;
	align-items: center;
	padding: 10px 20px;
	border-bottom: 1px solid #ddd;
	background-color: #fff;
	position: relative;
	z-index: 1;
}

.top-bar, .nav-bar {
	position: sticky;
	top: 0;
	left: 0;
	width: 100%;
	background-color: #fff;
	z-index: 2000; /* 충분히 높게 설정 */
	box-shadow: 0 1px 4px rgba(0, 0, 0, 0.1);
}

.logo {
	font-size: 24px;
	font-weight: bold;
	color: black;
}

/* ☰ 삼지창 + 사이드바 래퍼 */
.menu-wrapper {
	position: relative;
	margin-right: 20px;
}

.hamburger {
	left: 0;
	font-size: 24px;
	cursor: pointer;
	padding: 5px;
}

/* 사이드바: 왼쪽 고정 + hover 시 슬라이드 등장 */
.side-menu {
	left: 0;
	position: fixed;
	top: 0;
	left: -180px; /* 감춰진 상태 */
	width: 180px; /* 얇게 */
	height: 100vh;
	background-color: #f9f9f9;
	border-right: 1px solid #ccc;
	padding: 20px 16px;
	transition: left 0.3s ease;
	z-index: 999;
	overflow-y: auto;
}

/* ☰에 마우스 올리면 열림 */
.menu-wrapper:hover .side-menu {
	left: 0;
}

/* 사이드바 제목 */
.side-menu h3 {
	margin-top: 0;
	margin-bottom: 15px;
	font-size: 16px;
	color: #111;
}

/* 대분류 */
.side-category {
	margin-bottom: 12px;
}

.side-category>a {
	text-decoration: none;
	color: #333;
	font-size: 14px;
	font-weight: bold;
	display: block;
	padding: 4px 0;
}

.side-category>a:hover {
	color: crimson;
}

/* 소분류 */
.side-category ul {
	padding-left: 12px;
	margin-top: 6px;
}

.side-category ul li {
	list-style: none;
}

.side-category ul li a {
	font-size: 13px;
	color: #555;
	text-decoration: none;
	padding: 3px 0;
	display: block;
}

.side-category ul li a:hover {
	color: crimson;
}

/* 추천상품 등 네비게이션 메뉴 */
.nav-menu {
	display: flex;
	gap: 20px;
	font-size: 16px;
}

.nav-menu a {
	text-decoration: none;
	color: #333;
	padding: 6px 0;
}

/* 검색창 */
.search-box {
	margin-left: auto;
	display: flex;
	align-items: center;
}

.search-box input {
	padding: 6px 10px;
	border: 1px solid #ccc;
	border-radius: 4px;
	width: 200px;
}

.search-box button {
	background: none;
	border: none;
	font-size: 18px;
	margin-left: 8px;
	cursor: pointer;
	color: #444;
}

.nav-menu {
	display: flex;
	gap: 20px;
	font-size: 16px;
	position: relative;
	z-index: 10;
}

.nav-category {
	position: relative;
}

.nav-category>a {
	text-decoration: none;
	color: #333;
	padding: 6px 8px;
	display: block;
	white-space: nowrap;
}

.nav-category>a:hover {
	color: crimson;
}

.sub-dropdown {
	display: none;
	position: absolute;
	top: 100%;
	left: 0;
	background-color: #fff;
	border: 1px solid #ddd;
	min-width: 140px;
	padding: 8px 0;
	box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
}

.sub-dropdown a {
	display: block;
	padding: 6px 12px;
	font-size: 14px;
	color: #444;
	text-decoration: none;
	white-space: nowrap;
}

.sub-dropdown a:hover {
	background-color: #f8f8f8;
	color: crimson;
}

/* hover 시 드롭다운 보이기 */
.nav-category:hover .sub-dropdown {
	display: block;
}

.slider-container {
	position: relative;
	z-index: 100; /* 헤더(z‑index:2000)보다 낮게 */
}

.side-menu {
	z-index: 999; /* 기존 설정 유지 */
}

.header {
	width: 100%;


.badge {
  display: inline-block;
  min-width: 18px;
  padding: 2px 6px;
  font-size: 12px;
  color: #fff;
  background-color: crimson;
  border-radius: 12px;
  margin-left: 4px;
  vertical-align: top;
}
</style>
<div class="header">
	<!-- ✅ 상단 바 -->
	<div class="top-bar">
		<div class="logo">
			<a href="main">YOUSINSA</a>
		</div>
		<div class="top-menu">
			<a href="coupon">쿠폰</a> <a href="notice">공지사항</a> 
			 <c:choose>
    <c:when test="${not empty sessionScope.userId}">
      <a href="${pageContext.request.contextPath}/myAlarm">
        알림
        <c:if test="${alertCount > 0}">
          <span class="badge">${alertCount}</span>
        </c:if>
      </a>
      
    </c:when>
    <c:otherwise>
      <a href="${pageContext.request.contextPath}/login">알림</a>
    </c:otherwise>
  </c:choose>
			 <a href="cart">장바구니</a>

			<c:choose>
				<c:when test="${not empty sessionScope.userId}">
					<c:choose>
						<c:when test="${sessionScope.isSeller}">
							<a href="adminOrderSearch">마이페이지</a>
						</c:when>
						<c:otherwise>
							<a href="myLikeList">마이페이지</a>
						</c:otherwise>
					</c:choose>
					<a href="logout">로그아웃</a>
				</c:when>
				<c:otherwise>
					<a href="login">로그인</a>
					<a href="join">회원가입</a>
				</c:otherwise>
			</c:choose>
		</div>
	</div>

	<!-- ✅ 네비게이션 바 -->
	<div class="nav-bar">

		<!-- ☰ 삼지창 + 사이드바 묶음 -->
		<div class="menu-wrapper">
			<div class="hamburger">☰</div>

			<div class="side-menu">
				<h3>전체 카테고리</h3>
				<c:forEach var="category" items="${categoryList}">
					<div class="side-category">
						<a href="/yousinsa/productList?categoryId=${category.categoryId}">
							${category.categoryName} </a>
						<c:if test="${not empty category.subCategoryList}">
							<ul style="padding-left: 12px;">
								<c:forEach var="sub" items="${category.subCategoryList}">
									<li style="list-style: none;"><a
										href="/yousinsa/productList?categoryId=${category.categoryId}&subCategoryId=${sub.subCategoryId}"
										style="font-size: 14px; color: #555;">
											${sub.subCategoryName} </a></li>
								</c:forEach>
							</ul>
						</c:if>
					</div>
				</c:forEach>
			</div>
		</div>

		<!-- 추천/신상품 메뉴 -->
		<div class="nav-menu">
			<c:forEach var="category" items="${categoryList}">
				<div class="nav-category">
					<a href="/yousinsa/productList?categoryId=${category.categoryId}">
						${category.categoryName} </a>

					<!-- 소분류 드롭다운 -->
					<c:if test="${not empty category.subCategoryList}">
						<div class="sub-dropdown">
							<c:forEach var="sub" items="${category.subCategoryList}">
								<a
									href="/yousinsa/productList?categoryId=${category.categoryId}&subCategoryId=${sub.subCategoryId}">
									${sub.subCategoryName} </a>
							</c:forEach>

						</div>
					</c:if>
				</div>
			</c:forEach>
			 <a href="/yousinsa/productList?popular">인기상품</a>  <a href="/yousinsa/productList?new">신상품</a>
		</div>

		<!-- 검색창 -->
<div class="search-box">
  <input type="text" id="inp" placeholder="검색어를 입력하세요." />
   <button id="searchBtn">
    <i class="fas fa-magnifying-glass"></i>
  </button>
</div>

<script>
  // 1. Firebase 초기화
  const firebaseConfig = {
    apiKey: "AIzaSyChh1pWhBBB1jFsI_YHR4id1PjM8htrFwU",
    authDomain: "yousinsa-c83ae.firebaseapp.com",
    projectId: "yousinsa-c83ae",
    messagingSenderId: "372484059502",
    appId: "1:372484059502:web:0d322309f20c8c7c79d17f"
  };
  firebase.initializeApp(firebaseConfig);
  const messaging = firebase.messaging();
  messaging.onMessage(payload => {
	    console.log('📥 포그라운드 메시지 수신:', payload);

	    const { title, body } = payload.notification ?? payload.data;
	    if (title && body) {
	      new Notification(title, {
	        body: body,
	        icon: '/favicon.ico'
	      });
	    }
	  });
</script>

<c:if test="${not empty sessionScope.userId}">
  <script>
    // 2. 서비스워커 등록 및 토큰 저장
    if ('serviceWorker' in navigator && sessionStorage.getItem('fcmSaved') !== 'true') {
      navigator.serviceWorker.register('/yousinsa/firebase-messaging-sw.js')
        .then(function(registration) {
          console.log('✅ Service Worker 등록 성공:', registration.scope);

          return Notification.requestPermission().then(permission => {
            if (permission === 'granted') {
              return messaging.getToken({ serviceWorkerRegistration: registration });
            } else {
              throw new Error('❌ 알림 권한 거부됨');
            }
          });
        })
        .then(token => {
          console.log('🎯 토큰:', token);
          return fetch('/yousinsa/saveFcmToken', {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({ token })
          });
        })
        .then(() => {
          sessionStorage.setItem('fcmSaved', 'true');  // 중복 방지
        })
        .catch(err => {
          console.error('❌ 최종 오류:', err);
        });
    }
messaging.onMessage(payload => {
	  const { title, body } = payload.notification ?? payload.data;

	  if (title && body) {
	    new Notification(title, {
	      body: body,
	      icon: '/favicon.ico'
	    });

	    // 🔄 알림 수 새로고침
	    fetch('/yousinsa/alertCount')
	      .then(res => res.json())
	      .then(data => {
	        const badge = document.querySelector('.top-menu .badge');
	        const alertLink = document.querySelector('.top-menu a[href$="myAlarm"]');

	        if (badge) {
	          badge.textContent = data.count;
	        } else if (data.count > 0 && alertLink) {
	          const span = document.createElement('span');
	          span.className = 'badge';
	          span.textContent = data.count;
	          alertLink.appendChild(span);
	        }
	      });
	  }
	});


  </script>
</c:if>

<script>
  // 🔍 검색 기능
  document.getElementById('searchBtn').addEventListener('click', doSearch);
  document.getElementById('inp').addEventListener('keyup', e => {
    if (e.key === 'Enter') doSearch();
  });

  function doSearch() {
    const raw = document.getElementById('inp').value.trim();
    const keyword = raw.replace(/\s/g, '');

    if (keyword.length < 2) {
      alert('검색어를 두 글자 이상 입력해 주세요.');
      return;
    }

    location.href = '/yousinsa/productList?name=' + encodeURIComponent(raw);
  }
</script>


	</div>
</div>