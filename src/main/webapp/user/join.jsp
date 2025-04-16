<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="./css/common.css" rel="stylesheet">
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript">
	$(function() {
		$("#doubldId").click(function(e) {
			e.preventDefault();
			$.ajax({
				url:'findUserByUserId',
				type:'post',
				async:true,
				dataType:'text',
				data:{id:$("#id").val()},
				success:function(result) {
					if(result=='true') {
						alert("사용중인 아이디입니다")
					} else {
						alert("사용가능한 아이디입니다")
					}
				},
				error:function(err) {
					console.log(err)
				}
			})
		})
		
		

</script>

</head>
<body>
	<form action="join" method="post">
		<div><h3 class="header">회원가입</h3></div>
		<div class="wrap">
			<div class="row">  
				<div class="title">아이디</div>
				<div class="input"><input type="text" name="userId" id="userId" style="width:120px"/></div>
				<div class="input">&nbsp;<button id="doubldId">중복</button></div>
			</div>
			<div class="row">  
				<div class="title">비밀번호</div>
				<div class="input"><input type="text" name="password"/></div>
			</div>
			<div class="row">  
				<div class="title">비밀번호확인</div>
				<div class="input"><input type="text" name="checkPassword"/></div>
			</div>
			<div class="row">  
				<div class="title">이름</div>
				<div class="input"><input type="text" name="name"/></div>
			</div>
			<div class="row">  
				<div class="title">전화번호</div>
				<div class="input"><input type="text" name="phoneNum"/></div>
			</div>
			<div class="row">  
				<div class="title">이메일</div>
				<div class="input"><input type="text" name="email"/></div>
			</div>
			<div class="row">  
				<div class="title">생년월일</div>
				<div class="input"><input type="date" name="birth" required/></div>
			</div>
			<div>
				<input type="submit" value="회원가입"/>
			</div>
		</div>
	</form>
</body>
</html>