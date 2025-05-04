<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page session="true"%>
<%
String savedId = "";
Cookie[] cookies = request.getCookies();
if (cookies != null) {
	for (Cookie c : cookies) {
		if ("saveId".equals(c.getName())) {
	savedId = c.getValue();
	break;
		}
	}
}
%>
<script src="https://www.gstatic.com/firebasejs/9.6.11/firebase-app-compat.js"></script>
<script src="https://www.gstatic.com/firebasejs/9.6.11/firebase-messaging-compat.js"></script>
<c:if test="${not empty errMsg}">
	<script>
		alert('${errMsg}');
	</script>
</c:if>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<title>로그인</title>
<style>
body {
	margin: 0;
	font-family: sans-serif;
	background-color: #fff;
	color: #333;
	min-height: 100vh;
	display: flex;
	flex-direction: column;
}

main {
	flex-grow: 1;
	max-width: 400px;
	margin: 0 auto;
	padding: 80px 20px;
	text-align: center;
}

h1 {
	font-size: 24px;
	font-weight: bold;
	margin-bottom: 30px;
}

form {
	display: flex;
	flex-direction: column;
	gap: 12px;
}

input[type="text"], input[type="password"] {
	padding: 10px;
	border: 1px solid #ccc;
	border-radius: 4px;
	width: 100%;
	box-sizing: border-box;
	font-size: 14px;
}

button, .social-login button {
	width: 100%;
	padding: 12px;
	border: none;
	border-radius: 4px;
	font-size: 14px;
	font-weight: bold;
	cursor: pointer;
}

.login-btn {
	background-color: #000;
	color: #fff;
}

.kakao-btn {
	background-color: #FEE500;
	color: #3C1E1E;
	margin-top: 8px;
}

.naver-btn {
	background-color: #03C75A;
	color: white;
}

.checkbox {
	display: flex;
	align-items: center;
	font-size: 14px;
}

.checkbox input {
	margin-right: 6px;
}

.social-login {
	margin-top: 20px;
	display: flex;
	flex-direction: column;
	gap: 8px;
}

.links {
	margin-top: 20px;
	font-size: 12px;
	color: #777;
}

.links a {
	margin: 0 6px;
	text-decoration: none;
	color: #777;
}

.links a:hover {
	text-decoration: underline;
}
</style>
</head>

<body>
	<jsp:include page="/header" />
<%@ include file="scrollTop.jsp" %>
	<main>
  <h1>LOGIN</h1>

  <!-- 일반 로그인 Form -->
  <form action="${pageContext.request.contextPath}/login" method="post">
    <input type="text" name="userId" id="userId" placeholder="아이디" required value="<%=savedId%>" />
    <input type="password" name="password" id="password" placeholder="비밀번호" required />

    <div class="checkbox">
      <input type="checkbox" id="saveId" name="saveId" <%=!savedId.isEmpty() ? "checked" : ""%> />
      <label for="saveId">아이디 저장</label>
    </div>
     <input type="hidden" name="token" id="fcmToken" />

    <button type="submit" class="login-btn" id="login-btn">로그인</button>
  </form>

  <!-- 소셜 로그인은 Form 바깥 -->
  <div class="social-login">
    <button type="button" class="kakao-btn"
      onclick="location.href='<%=request.getContextPath()%>/kakao'">
      카카오 로그인
    </button>

    <button type="button" class="naver-btn"
      onclick="location.href='<%=request.getContextPath()%>/naver'">
      네이버 로그인
    </button>
  </div>

  <div class="links">
    <a href="findId">아이디 찾기</a> | <a href="findPassword">비밀번호 찾기</a> | <a href="join">회원가입</a>
  </div>
</main>


	<jsp:include page="footer.jsp"/>
	
	<script>
  const firebaseConfig = {
    apiKey: "AIzaSyChh1pWhBBB1jFsI_YHR4id1PjM8htrFwU",
    authDomain: "yousinsa-c83ae.firebaseapp.com",
    projectId: "yousinsa-c83ae",
    messagingSenderId: "372484059502",
    appId: "1:372484059502:web:0d322309f20c8c7c79d17f"
  };
  firebase.initializeApp(firebaseConfig);
  const messaging = firebase.messaging();
</script>

<script>
document.getElementById("loginForm").addEventListener("submit", async function (e) {
	  e.preventDefault(); // 일단 막고

	  try {
	    const reg = await navigator.serviceWorker.register('/yousinsa/firebase-messaging-sw.js');
	    const token = await messaging.getToken({ serviceWorkerRegistration: reg });
	    document.getElementById("fcmToken").value = token; // ✅ hidden에 넣기
	    this.submit(); // 👉 원래 폼 제출 실행
	  } catch (err) {
	    console.error("FCM 토큰 발급 실패", err);
	    alert("FCM 초기화 실패");
	  }
	});
</script>
</body>

</html>
