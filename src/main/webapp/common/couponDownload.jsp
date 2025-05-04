<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>쿠폰 다운로드</title>
    <style>
    body {
      margin: 0;
      font-family: 'Noto Sans KR', sans-serif;
      background: #fff;
      color: #333;
      font-size: 14px;
    }
    main.container {
      max-width: 600px;
      margin: 40px auto;
      padding: 0 20px;
    }
    .title {
      font-size: 20px;
      font-weight: bold;
      margin-bottom: 8px;
    }
    .subtitle {
      font-size: 12px;
      color: #666;
      margin-bottom: 24px;
    }
    .coupon-item {
      border: 1px solid #ddd;
      border-radius: 4px;
      padding: 16px;
      display: flex;
      align-items: center;
      justify-content: space-between;
      margin-bottom: 16px;
    }
    .coupon-info {
      display: flex;
      align-items: center;
    }
    .coupon-info img {
      width: 64px;
      height: 64px;
      margin-right: 16px;
    }
    .coupon-text {
      display: flex;
      flex-direction: column;
    }
    .coupon-text .name {
      font-weight: bold;
      margin-bottom: 4px;
    }
    .coupon-text .target,
    .coupon-text .validity {
      font-size: 12px;
      color: #888;
    }
    .coupon-text .validity {
      margin-top: 4px;
    }
    .download-btn {
      padding: 6px 12px;
      border: 1px solid #333;
      border-radius: 4px;
      background: none;
      cursor: pointer;
      font-size: 12px;
    }
  </style>
  <script>
    function requireLogin() {
      alert('로그인 후 다운로드 가능합니다.');
      location.href = 'login';
      return false;
    }
  </script>
  
</head>
<body>
<jsp:include page="/header" />
<%@ include file="scrollTop.jsp" %>
  <main class="container">
    <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 10px;">
  <h2 style="margin: 0;">쿠폰 다운로드</h2>
  <a href="${pageContext.request.contextPath}/myCouponList"
     style="padding: 6px 12px; font-size: 12px; border: 1px solid #333; border-radius: 4px; text-decoration: none; color: #FFF; background-color: #303030">
    내 쿠폰 보러가기
  </a>
</div>
    <p>다운로드 가능한 쿠폰 목록입니다.</p>

    <c:forEach var="coupon" items="${couponList}">
      <div class="coupon-item">

        <div class="coupon-info">
          <img src="${pageContext.request.contextPath}/image/coupon.png"
               alt="쿠폰 아이콘"
               style="width:48px; height:48px; margin-right:12px;"/>
          <div class="coupon-details">
            <div class="coupon-name" style="font-weight:bold; margin-bottom:4px;">
              ${coupon.name}
            </div>
            <!-- 할인 표시 -->
            <div class="coupon-discount" style="font-size:12px; color:#e60012; margin-bottom:4px;">
              <c:choose>
                <c:when test="${coupon.discountAmount <= 100}">
                  ${coupon.discountAmount}% 할인
                </c:when>
                <c:otherwise>
                  ${coupon.discountAmount}원 할인
                </c:otherwise>
              </c:choose>
            </div>
            <!-- 설명/유효기간 -->
            <div class="coupon-desc" style="font-size:12px; color:#666;">
              ${coupon.description}
            </div>
            <div class="coupon-valid" style="font-size:12px; color:#888;">
              다운로드 가능 기간: ${coupon.startDate} ~ ${coupon.endDate}
            </div>
          </div>
        </div>

        <!-- 다운로드 버튼 -->
        <div class="coupon-action">
          <c:choose>
            <c:when test="${empty sessionScope.userId}">
              <button type="button" onclick="return requireLogin();">
                다운로드
              </button>
            </c:when>
            <c:otherwise>
              <form action="${pageContext.request.contextPath}/coupon"
                    method="post" style="margin:0">
                <input type="hidden" name="coupon_id" value="${coupon.couponId}"/>
                <button type="submit">다운로드</button>
              </form>
            </c:otherwise>
          </c:choose>
           <div style="font-size:12px; color:#888; margin-top:4px;">
        유효 일수: ${coupon.period}일
      </div>
        </div>
      </div>
    </c:forEach>
<c:if test="${empty couponList}">
  <div style="text-align:center; padding: 80px 20px; font-size: 18px; color: #999; border-radius: 8px; margin:100px">
    현재 다운로드 가능한 쿠폰이 없습니다.
  </div>
</c:if>

    
  </main>
  <jsp:include page="footer.jsp"/>
</body>
</html>
