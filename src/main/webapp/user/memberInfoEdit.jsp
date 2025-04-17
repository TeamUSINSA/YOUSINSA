<%@ page contentType="text/html; charset=UTF-8" language="java" %>

<%-- <%@ include file="/includes/header.jsp" %> --%>

<div class="member-info-wrap">
  <h2>회원정보</h2>

  <!-- 이름 -->
  <div class="info-row">
    <label>이름</label>
    <div class="field-group">
      <input type="text" id="nameField" name="name" value="${user.name}" readonly>
      <button type="button" id="nameBtn" onclick="toggleEdit('name')">변경하기</button>
    </div>
  </div>

  <!-- 아이디 (수정 불가) -->
  <div class="info-row">
    <label>아이디</label>
    <div class="field-group">
      <input type="text" value="${user.userId}" readonly>
    </div>
  </div>

  <!-- 비밀번호 -->
<div class="info-row">
  <label>비밀번호</label>
  <div class="field-group">
    <input type="password" value="${user.password}" readonly>
    <button type="button" onclick="location.href='editPassword.jsp'">변경하기</button>
  </div>
</div>


  <!-- 휴대전화 -->
  <div class="info-row">
    <label>휴대전화번호</label>
    <div class="field-group">
      <input type="text" id="phoneField" name="phone" value="${user.phone}" readonly>
      <button type="button" id="phoneBtn" onclick="toggleEdit('phone')">변경하기</button>
    </div>
  </div>

  <!-- 이메일 -->
  <div class="info-row">
    <label>이메일</label>
    <div class="field-group">
      <input type="email" id="emailField" name="email" value="${user.email}" readonly>
      <button type="button" id="emailBtn" onclick="toggleEdit('email')">변경하기</button>
    </div>
  </div>

  <!-- 생일 -->
  <div class="info-row">
    <label>생일</label>
    <div class="field-group">
      <input type="date" id="birthField" name="birth" value="${user.birth}" readonly>
      <button type="button" id="birthBtn" onclick="toggleEdit('birth')">변경하기</button>
    </div>
  </div>

  <!-- 회원탈퇴 버튼 -->
  <div class="withdraw-wrap">
    <a href="withdraw" class="btn-withdraw">회원 탈퇴</a>
  </div>
</div>

<%-- <%@ include file="/includes/footer.jsp" %> --%>

<!-- ✅ 스타일 -->
<style>
  .member-info-wrap {
    max-width: 500px;
    margin: 40px auto;
    font-family: sans-serif;
  }

  .member-info-wrap h2 {
    font-size: 18px;
    font-weight: bold;
    margin-bottom: 20px;
  }

  .info-row {
    display: flex;
    flex-direction: column;
    margin-bottom: 20px;
  }

  .info-row label {
    font-weight: bold;
    margin-bottom: 5px;
  }

  .field-group {
    display: flex;
    align-items: center;
    gap: 10px;
  }

  .field-group input {
    flex: 1;
    padding: 8px;
    font-size: 14px;
    border: 1px solid #ccc;
    border-radius: 4px;
    background-color: #f9f9f9;
  }

  .field-group button {
    padding: 6px 10px;
    font-size: 12px;
    background-color: #444;
    color: #fff;
    border: none;
    border-radius: 4px;
    cursor: pointer;
  }

  .field-group button:hover {
    background-color: #222;
  }

  .withdraw-wrap {
    text-align: right;
    margin-top: 40px;
  }

  .btn-withdraw {
    display: inline-block;
    padding: 10px 20px;
    font-size: 13px;
    border: 1px solid #d00;
    color: #d00;
    background-color: #fff;
    border-radius: 6px;
    text-decoration: none;
  }

  .btn-withdraw:hover {
    background-color: #fee;
  }
</style>

<!-- 수정/저장 스크립트 -->
<script>
const originalValues = {};

//폰번호, 이메일 유효성 검사
function isValidPhone(phone) {
    return /^[0-9]{10,11}$/.test(phone);
}
function isValidEmail(email) {
    return /^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email);
}

function toggleEdit(field) {
    const input = document.getElementById(field + 'Field');
    const button = document.getElementById(field + 'Btn');

    if (input.readOnly) {
    	originalValues[field] = input.value;
      input.readOnly = false;
      input.style.backgroundColor = '#fff';
      button.textContent = '저장';
    } else {
      const value = input.value;
      
      //폰번호,이메일 유효성 검사
      if (field === 'phone' && !isValidPhone(value)) {
          alert('전화번호는 숫자 10~11자리여야 합니다.');
          input.value = originalValues[field];
          return;
      }

      if (field === 'email' && !isValidEmail(value)) {
          alert('유효한 이메일 주소를 입력해주세요.');
          input.value = originalValues[field];
          return;
      }

      // AJAX 요청
      fetch('memberInfoEdit', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded'
        },
        body: "field=" + field + "&value=" + encodeURIComponent(value)
      })
      .then(res => res.text())
      .then(result => {
        if (result === 'success') {
          alert(field + '이(가) 저장되었습니다.');
        } else {
          alert('저장 실패: ' + result);
          input.value = originalValues[field];
        }
      })
      .catch(err => {
        alert('오류 발생: ' + err);
        input.value = originalValues[field];
      })
      .finally(() => {
          
          input.readOnly = true;
          input.style.backgroundColor = '#f9f9f9';
          button.textContent = '변경하기';
      });
    }
  }
</script>
