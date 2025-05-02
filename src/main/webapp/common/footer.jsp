<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<style>
.footer-wrapper {
    background-color: #fafafa;
    border-top: 1px solid #ddd;
    font-size: 13px;
    color: #555;
    width: 100%;
}

.footer-container {
    max-width: 1000px;
    margin: 0 auto;
    padding: 20px;
}

.footer-top {
    display: flex;
    justify-content: space-between;
    flex-wrap: wrap;
    margin-bottom: 16px;
}

.footer-top-left h3 {
    font-size: 16px;
    font-weight: bold;
    margin-bottom: 4px;
}

.footer-top-left p {
    font-size: 12px;
    color: #888;
    margin-bottom: 10px;
}

.footer-btn {
    background-color: #303030;
    color: #fff;
    padding: 4px 8px;
    font-size: 11px;
    border-radius: 3px;
    text-decoration: none;
    margin-right: 6px;
}

.footer-links {
    font-size: 12px;
    color: #666;
}

.footer-links a {
    color: #666;
    text-decoration: none;
    margin-right: 10px;
}

.footer-links a:hover {
    text-decoration: underline;
}

.footer-bottom {
    display: flex;
    justify-content: space-between;
    flex-wrap: wrap;
    align-items: flex-end;
    gap: 20px;
    border-top: 1px solid #eee;
    padding-top: 16px;
}

.footer-bottom-left {
    font-size: 11px;
    color: #999;
    line-height: 1.6;
    flex: 1;
    min-width: 0;
}

.footer-logo {
    width: 300px;
    height: auto;
    opacity: 0.9;
}
</style>

<!-- ✅ footer 요소 -->
<div class="footer-wrapper" id="autoStickyFooter">
  <div class="footer-container">
    <div class="footer-top">
      <div class="footer-top-left">
        <h3>고객센터 1234-1234</h3>
        <p>운영시간: 평일 09:00 ~ 18:00 (점심시간 12:00 ~ 13:00 제외)</p>
        <a href="${pageContext.request.contextPath}/notice" class="footer-btn">Notice</a>
        <a href="${pageContext.request.contextPath}/myQnAList" class="footer-btn">Q&A 문의</a>
      </div>
      <div class="footer-links">
        <a href="#">개인정보처리방침</a> |
        <a href="#">이용약관</a> |
        <a href="#">분쟁해결기준</a> |
        <a href="#">안전거래센터</a> |
        <a href="#">결제대행위탁사</a>
      </div>
    </div>

    <div class="footer-bottom">
      <div class="footer-bottom-left">
        <p>상호명: ****** | 사업장소재지: 서울특별시 금천구 가산디지털1로 70 호서벤처타워 9층 | 팩스: 070-1234-1234</p>
        <p>사업자등록번호: ***-**-***** | 통신판매업신고 2025-서울금천-1710</p>
        <p>전화번호: ****-**** | 이메일: daecham124@gmail.com | 대표: 신대혁</p>
        <p>해당 사이트에서 판매되는 모든 상품에 관한 모든 민형의 책임은 유신사에 있습니다.</p>
        <p style="margin-top: 8px;">© YOUSINSA Corp. All rights reserved.</p>
      </div>
      <img src="${pageContext.request.contextPath}/image/footerImage.PNG" class="footer-logo" alt="공정거래위원회">
    </div>
  </div>
</div>

<!-- ✅ 푸터를 바닥으로 밀어내는 자바스크립트 -->
<script>
(function () {
  const footer = document.getElementById("autoStickyFooter");
  const body = document.body;
  const html = document.documentElement;

  function adjustFooterPosition() {
    const bodyHeight = Math.max(body.scrollHeight, body.offsetHeight, html.clientHeight, html.scrollHeight, html.offsetHeight);
    const windowHeight = window.innerHeight;

    const footerHeight = footer.offsetHeight;
    const footerTop = footer.getBoundingClientRect().top + window.scrollY;

    const spaceBelow = windowHeight - (footerTop + footerHeight);
    if (spaceBelow > 0) {
      footer.style.marginTop = spaceBelow + "px";
    }
  }

  window.addEventListener("load", adjustFooterPosition);
  window.addEventListener("resize", adjustFooterPosition);
})();
</script>
