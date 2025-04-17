<%@ page contentType="text/html; charset=UTF-8" language="java" %>

<%-- <!-- ✅ 공통 헤더 -->
<%@ include file="/includes/header.jsp" %> --%>

<!-- ✅ 전체 레이아웃 -->
<div class="layout" style="display: flex; max-width: 1000px; margin: 0 auto; padding: 40px 20px; gap: 30px;">

 <%--  <!-- ✅ 사이드바 -->
  <div class="sidebar" style="width: 200px;">
    <%@ include file="/includes/mysidebar.jsp" %>
  </div> --%>

  <!-- ✅ 본문 -->
  <div class="content" style="flex: 1;">
    <h2 style="font-size: 20px; font-weight: bold; margin-bottom: 5px;">회원탈퇴</h2>
    <p style="font-size: 13px; color: #666;">그동안 YOUSINSA를 이용해 주셔서 감사합니다.</p>

    <div style="border: 1px solid #ccc; border-radius: 10px; padding: 30px; margin-top: 30px;">
      <h3 style="font-size: 16px; font-weight: bold; margin-bottom: 8px;">회원 탈퇴 정보 작성</h3>
      <p style="font-size: 13px; color: #666;">귀하의 사유 작성은 YOUSINSA에 큰 도움이 됩니다.</p>

      <form method="post" action="withdraw.do" style="margin-top: 20px;">
        
        <!-- 탈퇴 사유 -->
        <select name="reason"
                style="width: 100%; padding: 10px; margin-bottom: 12px; border: 1px solid #ccc; border-radius: 4px;">
          <option value="">탈퇴사유 선택</option>
          <option value="불만족">서비스에 불만족</option>
          <option value="이용빈도낮음">이용 빈도 낮음</option>
          <option value="기타">기타</option>
        </select>

        <!-- 상세사유 -->
        <textarea name="detail" placeholder="상세사유를 적어주세요"
                  style="width: 100%; height: 100px; padding: 10px; margin-bottom: 12px; border: 1px solid #ccc; border-radius: 4px;"></textarea>

        <!-- 동의 체크 -->
        <label style="font-size: 13px; display: flex; align-items: center; gap: 5px; margin-bottom: 16px;">
          <input type="checkbox" name="agree" required>
          개인정보 처리 약관에 동의합니다.
          <a href="/privacy.jsp" style="font-size: 12px; text-decoration: underline;">약관 상세 보기</a>
        </label>

        <!-- 제출 버튼 -->
        <button type="submit"
                style="width: 100%; background: #000; color: white; padding: 12px; font-weight: bold; font-size: 14px; border: none; border-radius: 4px;">
          탈퇴하기
        </button>
      </form>
    </div>
  </div>
</div>
<style>
  .layout {
  width: 100%;
  max-width: 900px;
  background-color: #ffffff;
  padding: 40px;
  border-radius: 12px;
  box-shadow: 0 8px 20px rgba(0, 0, 0, 0.05);
  margin: 0 auto; /* 중앙 정렬 */
}
</style>
<%-- <!-- ✅ 공통 푸터 -->
<%@ include file="/includes/footer.jsp" %> --%>
