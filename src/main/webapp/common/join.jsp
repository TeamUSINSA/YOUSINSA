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
	<!-- 상단 바 -->
	<div
		class="flex justify-between items-center px-6 py-3 border-b text-xs">
		<div class="text-xl font-bold text-black">
			<a href="#">YOUSINSA</a>
		</div>
		<div class="flex items-center space-x-4">
			<a href="#">쿠폰</a> <a href="#">공지사항</a> <a href="#">QNA</a> <a
				href="#">알림</a> <a href="#">장바구니</a>
			<button id="loginBtn" class="border px-2 py-1 rounded">
				<%=username != null ? "로그아웃" : "로그인"%>
			</button>
			<span class="bg-black text-white px-3 py-1 rounded">마이페이지</span>
		</div>
	</div>

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
						<input type="text" name="phone_num" maxlength="3"
							placeholder="010" class="w-1/3 border px-3 py-2 rounded" required />
						<input type="text" name="phone_num" maxlength="4"
							placeholder="1234" class="w-1/3 border px-3 py-2 rounded"
							required /> <input type="text" name="phone_num" maxlength="4"
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

      fetch("<%= request.getContextPath() %>/checkDoubleId?userId=" + encodeURIComponent(userId))
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

	<!-- 푸터 -->
	<footer class="bg-white border-t text-sm text-gray-700">
		<div class="max-w-7xl mx-auto px-4 py-8">
			<div class="flex flex-col md:flex-row justify-between mb-6">
				<div>
					<h3 class="font-bold text-gray-900 mb-1">고객센터 1234-1234</h3>
					<p class="text-xs text-gray-500 mb-2">운영시간: 평일 09:00 ~ 18:00
						(점심시간 12:00 ~ 13:00 제외)</p>
					<div class="space-x-2">
						<button class="bg-black text-white text-xs px-3 py-1 rounded">Q&A</button>
						<button class="bg-black text-white text-xs px-3 py-1 rounded">1:1
							문의</button>
					</div>
				</div>
				<div
					class="flex items-center justify-end mt-4 md:mt-0 text-xs text-gray-500 space-x-2">
					<a href="#" class="hover:underline">개인정보처리방침</a> | <a href="#"
						class="hover:underline">이용약관</a> | <a href="#"
						class="hover:underline">분쟁해결기준</a> | <a href="#"
						class="hover:underline">안전거래센터</a> | <a href="#"
						class="hover:underline">결제대행위탁사</a>
				</div>
			</div>
			<div class="text-[11px] text-gray-500 space-y-1">
				<p>상호명: ****** &nbsp;&nbsp; 사업장소재지: 서울특별시 금천구 가산디지털1로 70 호서벤처타워
					9층 &nbsp;&nbsp; 팩스:070-1234-1234 &nbsp;&nbsp; 사업자등록번호: ***-**-*****
					&nbsp;&nbsp; 통신판매업신고 2025-서울금천-1710</p>
				<p>전화번호: ****-**** &nbsp;&nbsp; 이메일: daecham124@gmail.com
					&nbsp;&nbsp; 대표: 신대혁</p>
				<p>해당 사이트에서 판매되는 모든 상품에 관한 모든 민형의 책임은 유신사에 있습니다.</p>
				<p class="pt-2">© YOUSINSA Corp. All rights reserved.</p>
			</div>
			<div class="flex justify-end mt-6 space-x-2 opacity-60">
				<img src="https://cdn-icons-png.flaticon.com/512/25/25231.png"
					class="w-5 h-5" alt="공정거래위원회"> <img
					src="https://cdn-icons-png.flaticon.com/512/732/732221.png"
					class="w-5 h-5" alt="결제로고"> <img
					src="https://cdn-icons-png.flaticon.com/512/888/888879.png"
					class="w-5 h-5" alt="인증로고">
			</div>
		</div>
	</footer>
</body>
</html>
