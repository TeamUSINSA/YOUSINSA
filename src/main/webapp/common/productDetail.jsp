<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8" />
  <title>${product.name} - 상세</title>
  <style>
    body { font-family: sans-serif; background: #fff; color: #333; font-size: 14px; margin: 0; padding: 0; }
    .container { max-width: 1200px; margin: auto; padding: 24px; }
    .grid { display: grid; grid-template-columns: 1fr 1fr; gap: 24px; }
    .border { border: 1px solid #ccc; border-radius: 8px; }
    .mb-4 { margin-bottom: 1rem; } .p-4 { padding: 1rem; }
    .text-xl { font-size: 20px; font-weight: bold; }
    .text-sm { font-size: 14px; color: #666; }
    .text-yellow { color: #facc15; }
    .button { padding: 8px 16px; border: 1px solid #333; background: #fff; cursor: pointer; }
    .button-black { background: #000; color: #fff; }
    .tab {
  display: flex;
  justify-content: center;  /* ← 가로 중앙 정렬 */
  gap: 20px;                /* 탭 링크 사이 간격 */
  margin-top: 40px;
  border-bottom: 1px solid #ccc;
  padding-bottom: 10px;
   position: sticky;
  top: 0;               /* 뷰포트 최상단에 붙입니다 */
  background: #fff;     /* 뒤에 가려지는 콘텐츠가 보이지 않도록 배경색을 채워주세요 */
  z-index: 1000;        /* 다른 요소 위로 떠 있도록 충분히 큰 값으로 설정 */
}
.tab a {
  text-decoration: none;
  color: #333;
  padding: 4px 8px;
}
.tab a:hover {
  color: #000;
  border-bottom: 2px solid #000;
}
    .thumbnails {
  display: flex;
  justify-content: center;  /* ← 가로 중앙 정렬 */
  gap: 8px;
  margin-top: 12px;
}
.thumbnails .thumb {
  width: 80px;
  height: 80px;
  object-fit: cover;
  border: 2px solid transparent;
  border-radius: 4px;
  cursor: pointer;
  opacity: 0.8;
  transition: opacity .2s, border-color .2s;
}
.thumbnails .thumb:hover,
.thumbnails .thumb.active {
  opacity: 1;
  border-color: #333;
}
/* 이미지 묶음 레이아웃 */
/* 기존 flex 레이아웃을 모두 제거하고, 세로 스택으로 변경 */
.image-group {
  display: block;
  margin: 16px 0;
}
.image-group img {
  display: block;
  width: 100%;         /* 필요에 따라 max-width로 제한하세요 */
  max-width: 400px;    /* 예시: 최대 400px */
  height: auto;
  margin: 8px auto;    /* 위아래 8px 간격, 가로 중앙 정렬 */
  border-radius: 4px;
  object-fit: cover;
}


/* 설명문 */
.description {
  margin: 16px 0;
  line-height: 1.6;
  color: #444;
}

/* 사이즈 차트 */
.size-chart {
  text-align: center;
  margin: 24px 0;
}
.size-chart img {
  max-width: 100%;
  height: auto;
  border: 1px solid #eee;
  border-radius: 4px;
}

  </style>
</head>
<body>
<jsp:include page="/header" />
<div class="container">
  <section class="grid">
    <div>
  <!-- 메인 이미지 (id="mainImage" 꼭 지정) -->
  <img
    id="mainImage"
    src="${pageContext.request.contextPath}/image/${product.mainImage1}"
    style="width:100%; height:400px; object-fit:cover; border-radius:8px;"
    alt="${product.name}"
  />

  <!-- 썸네일 3개 -->
  <div class="thumbnails">
    <img
      class="thumb active"
      src="${pageContext.request.contextPath}/image/${product.mainImage2}"
      data-index="2"
      alt="썸네일2"
    />
    <img
      class="thumb"
      src="${pageContext.request.contextPath}/image/${product.mainImage3}"
      data-index="3"
      alt="썸네일3"
    />
    <img
      class="thumb"
      src="${pageContext.request.contextPath}/image/${product.mainImage4}"
      data-index="4"
      alt="썸네일4"
    />
  </div>
</div>

   <div>
  <h2>${product.name}</h2>

  <!-- ⭐ 별점 & 리뷰 개수 -->
  <div style="margin: 6px 0;">
    <c:forEach begin="1" end="${avgRating}" var="i">⭐</c:forEach>
    <span style="color: #facc15;">리뷰 ${fn:length(reviewList)}개</span>
  </div>

  <div>가격: <span id="basePrice"><fmt:formatNumber value="${product.price}" type="number" />원</span></div>

  <!-- 드롭다운 -->
  <select id="colorSelect" style="margin-top: 10px;">
    <option value="" disabled selected>색상 선택</option>
  </select>

  <select id="sizeSelect" disabled style="margin-top: 10px;">
    <option value="" disabled selected>사이즈 선택</option>
  </select>

  <!-- 옵션 출력 -->
  <div id="optionContainer" class="option-box" style="margin-top: 12px;"></div>
  <div id="totalPrice" style="margin-top: 10px;">총 합계: 0원</div>

  <!-- 👍 좋아요 수 표시 -->
  <div style="margin: 20px 0;">
  <button id="likeBtn" 
          data-product-id="${product.productId}" 
          class="button" 
          style="font-size: 20px; display: flex; align-items: center; gap: 8px;">
    <!-- 아직 로그인 체크·likedByUser 속성이 없다면 기본 🤍 아이콘 사용 -->
    <span id="likeIcon">${likedByUser ? '💖' : '🤍'}</span>
    <span id="likeCount">${likeCount}</span>
  </button>
</div>

  <!-- 장바구니 / 구매 버튼 -->
  <div style="display: flex; gap: 10px;">
    <button id="addCartBtn" 
        data-product-id="${product.productId}" 
        class="button" 
        style="flex:1;">
  장바구니
</button>
    <button class="button button-black" style="flex:1;">구매하기</button>
  </div>
</div>
   
  </section>
  

  <div class="tab">
    <a href="#info">정보</a>
    <a href="#size">사이즈표</a>
    <a href="#review">후기</a>
    <a href="#inquiry">문의</a>
  </div>

  <section id="info" class="p-4 border mt-4">
  <h3>상품 설명</h3>

  <!-- 1~5번 이미지 -->
  <c:if test="${not empty product.image1 or not empty product.image2 or not empty product.image3 or not empty product.image4 or not empty product.image5}">
    <div class="image-group group1">
      <c:if test="${not empty product.image1}">
        <img src="${pageContext.request.contextPath}/image/${product.image1}" alt="Image1"/>
      </c:if>
      <c:if test="${not empty product.image2}">
        <img src="${pageContext.request.contextPath}/image/${product.image2}" alt="Image2"/>
      </c:if>
      <c:if test="${not empty product.image3}">
        <img src="${pageContext.request.contextPath}/image/${product.image3}" alt="Image3"/>
      </c:if>
      <c:if test="${not empty product.image4}">
        <img src="${pageContext.request.contextPath}/image/${product.image4}" alt="Image4"/>
      </c:if>
      <c:if test="${not empty product.image5}">
        <img src="${pageContext.request.contextPath}/image/${product.image5}" alt="Image5"/>
      </c:if>
    </div>
  </c:if>

  <!-- description1 -->
  <c:if test="${not empty product.description1}">
    <div class="description">
      ${product.description1}
    </div>
  </c:if>

  <!-- 6~10번 이미지 -->
  <c:if test="${not empty product.image6 or not empty product.image7 or not empty product.image8 or not empty product.image9 or not empty product.image10}">
    <div class="image-group group2">
      <c:if test="${not empty product.image6}">
        <img src="${pageContext.request.contextPath}/image/${product.image6}" alt="Image6"/>
      </c:if>
      <c:if test="${not empty product.image7}">
        <img src="${pageContext.request.contextPath}/image/${product.image7}" alt="Image7"/>
      </c:if>
      <c:if test="${not empty product.image8}">
        <img src="${pageContext.request.contextPath}/image/${product.image8}" alt="Image8"/>
      </c:if>
      <c:if test="${not empty product.image9}">
        <img src="${pageContext.request.contextPath}/image/${product.image9}" alt="Image9"/>
      </c:if>
      <c:if test="${not empty product.image10}">
        <img src="${pageContext.request.contextPath}/image/${product.image10}" alt="Image10"/>
      </c:if>
    </div>
  </c:if>

  <!-- description2 -->
  <c:if test="${not empty product.description2}">
    <div class="description">
      ${product.description2}
    </div>
  </c:if>

  <!-- 사이즈 차트 -->
  <c:if test="${not empty product.sizeChart}">
    <div class="size-chart">
      <img src="${pageContext.request.contextPath}/image/${product.sizeChart}" alt="사이즈 차트"/>
    </div>
  </c:if>
</section>

  <section id="review" class="p-4 border mt-4">
    <h3>후기 (${fn:length(reviewList)}개)</h3>
    <c:forEach var="review" items="${reviewList}">
      <div class="border p-4 mb-4 review-item">
        <strong>${review.userId}</strong> ⭐ ${review.rating}<br />
        <span>${review.content}</span>
      </div>
    </c:forEach>
  </section>

  <section id="inquiry" class="p-4 border mt-4">
    <h3>상품문의</h3>
    <c:forEach var="inq" items="${inquiryList}">
      <div class="border p-4 mb-4 inquiry-item">
        <strong>${inq.title}</strong><br />
        <c:choose>
          <c:when test="${inq.secret}">🔒 비밀글입니다.</c:when>
          <c:otherwise>${inq.content}</c:otherwise>
        </c:choose>
        <div class="text-sm">작성자: ${inq.writerId} | ${inq.regDate}</div>
      </div>
    </c:forEach>
  </section>
</div>
<jsp:include page="/footer" />


<!-- 1) 옵션 선택 & 총합 계산 스크립트 -->


<script>
document.addEventListener('DOMContentLoaded', () => {
  // 1) 가격 가져오기
  const basePrice = parseInt(
    document.getElementById('basePrice')
      .textContent.replace(/\D/g, ''), 10
  );

  // 2) 재고 리스트 JSON
  const stockList = [
    <c:forEach var="s" items="${stockList}" varStatus="st">
      { color:'<c:out value="${s.color}"/>',
        size:'<c:out value="${s.size}"/>',
        quantity:${s.quantity}
      }<c:if test="${!st.last}">,</c:if>
    </c:forEach>
  ];

  const colorSelect     = document.getElementById('colorSelect');
  const sizeSelect      = document.getElementById('sizeSelect');
  const optionContainer = document.getElementById('optionContainer');
  const totalPriceEl    = document.getElementById('totalPrice');

  // 3) 총합 계산 함수
  function updateTotal() {
    let sum = 0;
    document.querySelectorAll('.selected-item').forEach(div => {
      sum += parseInt(div.querySelector('.count').textContent, 10)
           * basePrice;
    });
    totalPriceEl.textContent = '총 합계: ' + sum.toLocaleString() + '원';
  }

  // 4) 색상 옵션 한 번 초기화
  [...new Set(stockList.map(i => i.color.trim()))]
    .forEach(col => {
      colorSelect.append(new Option(col, col));
    });

  // 5) 색상 선택 시 사이즈 채우기
  colorSelect.addEventListener('change', function() {
    sizeSelect.innerHTML = '<option value="">사이즈 선택</option>';
    sizeSelect.disabled = true;
    const c = this.value;
    if (!c) return;
    stockList
      .filter(item => item.color.trim() === c && item.quantity > 0)
      .forEach(item => {
        sizeSelect.append(
          new Option(
            item.size.trim() + ' - 재고: ' + item.quantity,
            item.size.trim()
          )
        );
      });
    sizeSelect.disabled = false;
  });

  // 6) 사이즈 선택 시 항목 추가
  sizeSelect.addEventListener('change', function() {
    const c = colorSelect.value;
    const s = this.value;
    if (!c || !s) return;

    // 중복 방지
    if (optionContainer.querySelector(
          `[data-color="${c}"][data-size="${s}"]`
        )) return;

    const div = document.createElement('div');
    div.className = 'selected-item';
    div.dataset.color = c;
    div.dataset.size  = s;
    div.style.cssText =
      'display:flex;align-items:center;gap:8px;'
      + 'border:1px solid #ccc;padding:10px;'
      + 'border-radius:8px;margin-top:10px;';

    div.innerHTML =
      '<span style="min-width:100px;display:inline-block;color:#000;">'
        + c + ' · ' + s +
      '</span>'
      + '<button class="minus button">-</button>'
      + '<span class="count">1</span>'
      + '<button class="plus button">+</button>'
      + '<span class="price">' + basePrice.toLocaleString() + '원</span>'
      + '<button class="remove button">×</button>';

    div.querySelector('.minus').addEventListener('click', () => {
      const cntEl = div.querySelector('.count');
      let cnt = parseInt(cntEl.textContent, 10);
      if (cnt > 1) { cntEl.textContent = --cnt; updateTotal(); }
    });
    div.querySelector('.plus').addEventListener('click', () => {
      const cntEl = div.querySelector('.count');
      let cnt = parseInt(cntEl.textContent, 10);
      if (cnt < stockList.find(i=>i.color.trim()===c&&i.size.trim()===s).quantity) {
        cntEl.textContent = ++cnt; updateTotal();
      } else {
        alert('재고를 초과할 수 없습니다.');
      }
    });
    div.querySelector('.remove').addEventListener('click', () => {
      div.remove(); updateTotal();
    });

    optionContainer.appendChild(div);
    updateTotal();
  });
});
</script>




<!-- 2) 좋아요 토글 스크립트 -->
<script>
  (function(){
    const btn   = document.getElementById('likeBtn');
    if (!btn) return;

    const icon  = document.getElementById('likeIcon');
    const cntEl = document.getElementById('likeCount');
    const pid   = btn.dataset.productId;
    // URL은 c:url 로 생성
    const likeUrl = '<%= response.encodeURL(request.getContextPath()+"/likeProduct") %>';

    btn.addEventListener('click', () => {
      fetch(likeUrl, {
        method: 'POST',
        // 세션 쿠키를 꼭 포함하라고 명시
        credentials: 'include',
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8'
        },
        body: 'productId=' + encodeURIComponent(pid)
      })
      .then(res => {
        if (res.status === 401) {
          alert('로그인 후 이용해주세요.');
          return Promise.reject('unauthorized');
        }
        if (!res.ok) return Promise.reject('fetch error');
        return res.json();
      })
      .then(json => {
        // 서버가 준 liked, count 로 UI 갱신
        icon.textContent = json.liked ? '💖' : '🤍';
        cntEl.textContent  = json.count;
      })
      .catch(err => {
        if (err !== 'unauthorized') console.error(err);
      });
    });
  })();
</script>

<script>
document.addEventListener('DOMContentLoaded', () => {
  const btn = document.getElementById('addCartBtn');
  if (!btn) return;

  btn.addEventListener('click', async () => {
    const ctx       = '<c:url value="/" />'.slice(0,-1); // contextPath
    const productId = btn.dataset.productId;

    // 1) 선택된 옵션 수집
    const items = Array.from(
      document.querySelectorAll('.selected-item')
    ).map(div => ({
      color:    div.dataset.color,
      size:     div.dataset.size,
      quantity: parseInt(div.querySelector('.count').textContent, 10)
    }));

    if (items.length === 0) {
      alert('옵션을 하나 이상 선택해주세요.');
      return;
    }

    try {
      // 2) 각각의 옵션을 서버에 전송
      for (const it of items) {
        const body = new URLSearchParams();
        body.append('productId', productId);
        body.append('color',      it.color);
        body.append('size',       it.size);
        body.append('quantity',   it.quantity);

        await fetch(`${ctx}/yousinsa/cartAdd`, {
          method: 'POST',
          credentials: 'include',
          headers: {
            'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8'
          },
          body: body.toString()
        });
      }

      // 3) 전송 완료 후 선택지 띄우기
      const goCart = confirm(
        '장바구니에 담겼습니다.\n\n' +
        '장바구니로 이동하시겠습니까?\n' +
        '(확인: 이동, 취소: 계속 쇼핑)'
      );
      if (goCart) {
        window.location.href = `${ctx}/yousinsa/cart`;
      }
      // else: 현재 페이지에 머뭅니다.

    } catch (e) {
      console.error(e);
      alert('장바구니 담기 중 오류가 발생했습니다.');
    }
  });
});
</script>

<script>
document.addEventListener('DOMContentLoaded', () => {
  const mainImg = document.getElementById('mainImage');
  const thumbs  = document.querySelectorAll('.thumbnails .thumb');

  thumbs.forEach(thumb => {
    thumb.addEventListener('click', () => {
      // 1) active 클래스 이동
      thumbs.forEach(t => t.classList.remove('active'));
      thumb.classList.add('active');

      // 2) src 스왑
      const tmp = mainImg.src;
      mainImg.src = thumb.src;
      thumb.src   = tmp;
    });
  });
});
</script>


</body>
</html>
