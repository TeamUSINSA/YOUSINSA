<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>좋아요 목록</title>
  <style>
    .layout {
      display: flex;
      max-width: 1200px;
      margin: 0 auto;
      padding: 40px 20px;
      gap: 30px;
    }
    .sidebar {
      width: 200px;
      background: #f7f7f7;
      padding: 10px;
      border-radius: 8px;
    }
    .content {
      flex: 1;
    }
    .btn {
      font-size: 12px;
      padding: 6px 12px;
      height: 34px;
      border-radius: 3px;
      border: 1px solid #000;
      cursor: pointer;
      line-height: 1.4;
      display: inline-flex;
      align-items: center;
      justify-content: center;
      box-sizing: border-box;
      text-decoration: none;
    }
    .like-btn {
      background-color: #fff;
      color: #000;
    }
    .like-btn:hover { background-color: #f5f5f5; border-color: #222; }
    .buy-btn { background-color: #000; color: #fff; }
    .buy-btn:hover { background-color: #333; }
    .product-card {
      display: flex;
      gap: 15px;
      border: 1px solid #eee;
      border-radius: 8px;
      padding: 15px;
      margin-bottom: 15px;
      background-color: #fff;
    }
    /* 페이지네이션: coupon 페이지 스타일 적용 */
    .pagination {
      text-align: center;
      margin-top: 30px;
    }
    .pagination a {
      margin: 0 5px;
      text-decoration: none;
      color: #333;
      padding: 6px 10px;
      border-radius: 4px;
    }
    .pagination a.current {
      background: #333;
      color: #fff;
    }
  </style>
</head>
<body>
  <jsp:include page="/header" />
  <div class="layout">
    <%@ include file="mysidebar.jsp" %>
    <div class="content">
      <h2 style="font-size:20px; font-weight:bold; margin-bottom:10px;">좋아요</h2>
      <p style="font-size:13px; color:#555;">좋아요 누르신 상품 목록입니다.</p>
      <div id="likeListContainer">
        <c:forEach var="item" items="${likeList}">
          <c:if test="${not empty item.mainImage1 and not empty item.name}">
            <div class="product-card">
              <a href="${pageContext.request.contextPath}/productDetail?productId=${item.productId}">
                <img src="${pageContext.request.contextPath}/image/${item.mainImage1}" alt="${item.name}" style="width:90px;height:110px;object-fit:cover;border-radius:5px;">
              </a>
              <div style="flex:1;">
                <div style="font-weight:bold; margin-bottom:5px;">
                  <a href="${pageContext.request.contextPath}/productDetail?productId=${item.productId}" style="color:inherit; text-decoration:none;">${item.name}</a>
                </div>
                <div style="font-size:13px; color:#666; margin-bottom:10px;">${item.detail}</div>
                <div style="display:flex; gap:10px;">
                  <button class="btn like-btn" onclick="cancelLike(${item.likeId}, this)">좋아요 취소</button>
                  <a href="${pageContext.request.contextPath}/productDetail?productId=${item.productId}" class="btn buy-btn">구매하러 가기</a>
                </div>
              </div>
            </div>
          </c:if>
        </c:forEach>
      </div>

      <!-- 수정된 페이지네이션 -->
      <div class="pagination">
        <c:if test="${pageInfo.curPage > 1}">
          <a href="${pageContext.request.contextPath}/myLikeList?page=${pageInfo.curPage - 1}">&lt;</a>
        </c:if>
        <c:forEach var="page" begin="${pageInfo.startPage}" end="${pageInfo.endPage}">
          <a href="${pageContext.request.contextPath}/myLikeList?page=${page}" class="${page == pageInfo.curPage ? 'current' : ''}">${page}</a>
        </c:forEach>
        <c:if test="${pageInfo.curPage < pageInfo.allPage}">
          <a href="${pageContext.request.contextPath}/myLikeList?page=${pageInfo.curPage + 1}">&gt;</a>
        </c:if>
      </div>
    </div>
  </div>
  <script>
    const userId = "${sessionScope.userId}";
    const curPage = Number("${pageInfo.curPage}");
    function cancelLike(likeId, button) {
      if (!confirm("정말 좋아요를 취소하시겠습니까?")) return;
      fetch('unlike', { method: 'POST', headers: { 'Content-Type': 'application/x-www-form-urlencoded' }, body: "likeId=" + likeId })
      .then(res => res.text())
      .then(result => {
        if (result.trim() === 'success') {
          button.closest('.product-card').remove();
          window.location.reload();
        } else {
          alert('좋아요 취소 실패: ' + result);
        }
      })
      .catch(e => { console.error(e); alert('오류 발생: ' + e); });
    }
  </script>
  <jsp:include page="/common/footer.jsp" />
</body>
</html>
