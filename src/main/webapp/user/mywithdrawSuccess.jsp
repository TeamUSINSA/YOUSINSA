<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ include file="/common/header.jsp" %>

<style>
  .withdraw-container {
    max-width: 600px;
    margin: 60px auto 100px;
    text-align: center;
  }

  .withdraw-title {
    font-size: 22px;
    font-weight: bold;
    margin-top: 40px;
    margin-bottom: 30px;
    color: #111;
  }

  .withdraw-box {
    background: linear-gradient(to bottom, #fafafa, #f1f1f1);
    padding: 50px 40px;
    border-radius: 14px;
    border: 1px solid #ddd;
    box-shadow: 0 8px 24px rgba(0, 0, 0, 0.03);
    transition: box-shadow 0.3s ease;
  }

  .withdraw-box:hover {
    box-shadow: 0 10px 28px rgba(0, 0, 0, 0.05);
  }

  .withdraw-box p {
    margin: 10px 0;
    font-size: 15px;
    color: #333;
    line-height: 1.6;
  }

  .withdraw-btn {
    margin-top: 30px;
    background-color: #333;
    color: #fff;
    padding: 12px 30px;
    border: none;
    border-radius: 6px;
    font-size: 15px;
    font-weight: 500;
    cursor: pointer;
    transition: background-color 0.2s ease;
  }

  .withdraw-btn:hover {
    background-color: #555;
  }

  .top-description {
    text-align: left;
    max-width: 900px;
    margin: 60px auto 10px;
  }

  .top-description h2 {
    font-size: 22px;
    font-weight: bold;
    margin-bottom: 6px;
  }

  .top-description p {
    color: #666;
    font-size: 14px;
  }
  .container {
  width: 100%;
  max-width: 900px;
  background-color: #ffffff;
  padding: 40px;
  border-radius: 12px;
  box-shadow: 0 8px 20px rgba(0, 0, 0, 0.05);
  margin: 0 auto; /* 중앙 정렬 */
}
</style>
<div class="container">

    <div class="top-description">
        <h2>회원탈퇴</h2>
        <p>그동안 YOUSINSA를 이용해 주셔서 감사합니다.</p>
    </div>
    
    <div class="withdraw-container">
        <div class="withdraw-title">회원탈퇴 완료</div>
        
        <div class="withdraw-box">
            <p>회원탈퇴가 정상적으로 완료되었습니다.</p>
            <p>지금까지 YOUSINSA를 이용해 주셔서 진심으로 감사드립니다.</p>
            <form action="main.jsp" method="get">
                <button class="withdraw-btn"><a href="main">메인화면으로</a></button>
            </form>
        </div>
    </div>
</div>

<%@ include file="/common/footer.jsp" %>
