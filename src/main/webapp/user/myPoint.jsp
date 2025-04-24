<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../common/header.jsp" %>

<div class="mypage-wrapper">
    <%@ include file="mysidebar.jsp" %>

    <div class="content">
        <h2>포인트 조회</h2>

        <!-- 총 포인트 박스 -->
        <div class="total-point-box">
            <div class="point-star">⭐</div>
            <div class="point-value">
                <c:set var="total" value="0" />
                <c:forEach var="p" items="${pointList}">
                    <c:set var="total" value="${total + p.point}" />
                </c:forEach>
                ${total} Point
            </div>
            <div class="point-subtext">를 적립하셨습니다</div>
        </div>

        <!-- 포인트 리스트 -->
        <div class="point-list-box">
            <c:choose>
                <c:when test="${not empty pointList}">
                    <c:forEach var="p" items="${pointList}">
                        <div class="point-card">
                            <div class="point-amount" style="color:${p.point > 0 ? 'green' : 'red'};">
                                ${p.point > 0 ? '+' : ''}${p.point}P
                            </div>
                            <div class="point-detail">
                                ${p.date} / ${p.point > 0 ? '주문 적립' : '주문 사용'}
                            </div>
                        </div>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <p style="text-align:center;">포인트 내역이 없습니다.</p>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</div>

<%@ include file="../common/footer.jsp" %>

<style>
/* 전체 flex 배치 */
.mypage-wrapper {
    display: flex;
    max-width: 1200px;
    margin: 0 auto;
}

/* 본문 내용 */
.content {
    flex: 1;
    padding: 30px;
}

/* 총 포인트 박스 */
.total-point-box {
    background: #f2f2f2;
    border-radius: 12px;
    text-align: center;
    padding: 30px 20px;
    margin: 20px 0;
}
.point-star {
    font-size: 24px;
}
.point-value {
    font-size: 36px;
    font-weight: bold;
    margin: 10px 0;
}
.point-subtext {
    color: #666;
}

/* 포인트 카드 */
.point-list-box {
    margin-top: 20px;
}
.point-card {
    background: #fafafa;
    border: 1px solid #ddd;
    border-radius: 8px;
    padding: 15px;
    margin-bottom: 10px;
}
.point-amount {
    font-size: 20px;
    font-weight: bold;
}
.point-detail {
    font-size: 14px;
    color: #666;
    margin-top: 5px;
}
</style>
