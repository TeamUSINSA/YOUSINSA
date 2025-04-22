<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<style>
    .footer-wrapper {
        background-color: #ffffff;
        border-top: 1px solid #e5e7eb;
        font-size: 0.875rem;
        color: #4b5563;
        padding: 24px 0;
    }

    .footer-bottom {
        display: flex;
        justify-content: space-between;
        align-items: flex-end;
        margin-top: 16px;
    }

    .footer-logo {
        width: 200px;
        height: auto;
        opacity: 0.6;
    }
</style>

<footer class="footer-wrapper">
    <div class="max-w-7xl mx-auto px-4">
        <div class="flex flex-col md:flex-row justify-between mb-4">
            <div>
                <h3 class="font-bold text-gray-900 mb-1">고객센터 1234-1234</h3>
                <p class="text-xs text-gray-500 mb-2">
                    운영시간: 평일 09:00 ~ 18:00 (점심시간 12:00 ~ 13:00 제외)
                </p>
                <div class="space-x-2">
                    <a href="/qna" class="bg-black text-white text-xs px-3 py-1 rounded inline-block">Notice</a>
                    <a href="/contact" class="bg-black text-white text-xs px-3 py-1 rounded inline-block">1:1 문의</a>
                </div>
            </div>
            <div class="flex items-center justify-end mt-4 md:mt-0 text-xs text-gray-500 space-x-2">
                <a href="#" class="hover:underline">개인정보처리방침</a> |
                <a href="#" class="hover:underline">이용약관</a> |
                <a href="#" class="hover:underline">분쟁해결기준</a> |
                <a href="#" class="hover:underline">안전거래센터</a> |
                <a href="#" class="hover:underline">결제대행위탁사</a>
            </div>
        </div>

        <div class="footer-bottom">
            <div class="text-[11px] text-gray-500 space-y-1">
                <p>상호명: ****** &nbsp;&nbsp; 사업장소재지: 서울특별시 금천구 가산디지털1로 70 호서벤처타워 9층 &nbsp;&nbsp; 팩스:070-1234-1234 &nbsp;&nbsp; 사업자등록번호: ***-**-***** &nbsp;&nbsp; 통신판매업신고 2025-서울금천-1710</p>
                <p>전화번호: ****-**** &nbsp;&nbsp; 이메일: daecham124@gmail.com &nbsp;&nbsp; 대표: 신대혁</p>
                <p>해당 사이트에서 판매되는 모든 상품에 관한 모든 민형의 책임은 유신사에 있습니다.</p>
                <p class="pt-1">© YOUSINSA Corp. All rights reserved.</p>
            </div>

            <img src="${pageContext.request.contextPath}/image/footerImage.PNG" class="footer-logo" alt="공정거래위원회">
        </div>
    </div>
</footer>
