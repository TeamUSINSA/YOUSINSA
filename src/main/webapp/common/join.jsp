<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
String username = (String) session.getAttribute("username");
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<title>회원가입</title>
<script src="https://cdn.tailwindcss.com"></script>
<style>
.menu-item:hover {
	background-color: #f5f5f5;
}

.group:hover .group-hover\:block {
	display: block;
}
</style>
</head>
<body class="bg-white text-sm text-gray-700">
	<jsp:include page="/header" />

	<!-- 회원가입 폼 -->
	<main class="flex flex-col items-center justify-center py-24">
		<%
		String path = request.getContextPath();
		%>

		<form action="<%=path%>/join" method="post">
			<h2 class="text-2xl font-semibold text-center mb-10">회원 가입</h2>

			<!-- 약관 동의 -->
			<section class="mb-10">
				<h3 class="font-semibold mb-3">약관동의</h3>
				<div class="space-y-2 text-sm">
					<div>
						<input type="checkbox" id="all-agree" /> 모든 약관에 동의하고 전체 동의합니다.
					</div>
					<div>
						<input type="checkbox" name="terms1" class="terms" /> 이용약관 동의(필수)
					</div>
					<div>
						<input type="checkbox" name="terms2" class="terms" /> 개인정보 수집·이용
						동의(필수)
					</div>
					<div>
						<input type="checkbox" name="terms3" class="terms" /> 마케팅
						수신동의(선택)
						<div class="ml-6 mt-1 text-xs">
							<input type="checkbox" name="emailAgree" class="terms" /> 이메일 <input
								type="checkbox" name="smsAgree" class="ml-4 terms" /> SMS
						</div>
					</div>
				</div>
			</section>

			<!-- 정보 입력 -->
			<section>
				<h3 class="font-semibold mb-3">정보입력</h3>
				<div class="space-y-4 text-sm">
					<input type="text" name="userId" id="userId"
						placeholder="아이디를 입력해주세요." class="w-full border px-3 py-2 rounded"
						required />
					<div id="idCheckMsg" class="text-xs mt-1"></div>
					<input type="password" name="password" placeholder="비밀번호를 입력해주세요."
						class="w-full border px-3 py-2 rounded" required /> <input
						type="text" name="name" placeholder="이름을 입력해주세요."
						class="w-full border px-3 py-2 rounded" required />

					<div class="flex space-x-2">
						<input type="text" name="phone1" maxlength="3"
							placeholder="010" class="w-1/3 border px-3 py-2 rounded" required />
						<input type="text" name="phone2" maxlength="4"
							placeholder="1234" class="w-1/3 border px-3 py-2 rounded"
							required /> <input type="text" name="phone3" maxlength="4"
							placeholder="5678" class="w-1/3 border px-3 py-2 rounded"
							required />
					</div>

					<div class="flex space-x-2 items-center">
						<input type="text" name="email_id" placeholder="이메일 아이디"
							class="w-1/2 border px-3 py-2 rounded" required /> <span>@</span>
						<select name="email_domain" class="border px-3 py-2 rounded">
							<option value="google.com">google.com</option>
							<option value="naver.com">naver.com</option>
							<option value="hanmail.net">hanmail.net</option>
							<option value="custom">직접 입력</option>
						</select>
					</div>

					<input type="text" name="birth" placeholder="생년월일 8자리"
						maxlength="8" class="w-full border px-3 py-2 rounded" required />
				</div>
			</section>

			<div class="flex justify-center space-x-4 mt-8">
				<button type="reset" class="border px-6 py-2 rounded">취소</button>
				<button type="submit" class="bg-black text-white px-6 py-2 rounded">가입하기</button>
			</div>
		</form>
		<script>
  document.addEventListener("DOMContentLoaded", function () {
    const allAgree = document.getElementById("all-agree");
    const terms = document.querySelectorAll(".terms");

    allAgree.addEventListener("change", function () {
      terms.forEach(term => term.checked = allAgree.checked);
    });
  });
  
  document.addEventListener("DOMContentLoaded", function () {
	  const userIdInput = document.getElementById("userId");
	  const msgBox = document.getElementById("idCheckMsg");

	  userIdInput.addEventListener("input", () => {
	    const userId = userIdInput.value;

	    if (userId.length < 3) {
	      msgBox.textContent = "";
	      return;
	    }

	    fetch("<%= request.getContextPath() %>/doubleIdCheck?userId=" + encodeURIComponent(userId))
	      .then(res => res.text())
	      .then(result => {
	        if (result === "true") {
	          msgBox.textContent = "이미 사용중인 아이디입니다.";
	          msgBox.className = "text-xs mt-1 text-red-600";
	        } else {
	          msgBox.textContent = "사용 가능한 아이디입니다.";
	          msgBox.className = "text-xs mt-1 text-green-600";
	        }
	      });
	  });
	});

  </script>

	</main>
 <jsp:include page="/footer" />
</body>
</html>
