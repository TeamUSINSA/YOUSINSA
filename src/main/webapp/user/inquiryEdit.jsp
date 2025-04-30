<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/header" />

<div class="container" style="max-width:600px; margin:40px auto;">
  <h2>문의 수정</h2>
  <form action="${pageContext.request.contextPath}/myInquiryEdit" method="post">
    <input type="hidden" name="inquiryId" value="${inq.inquiryId}" />

    <div style="margin-bottom:16px;">
      <label>제목</label><br/>
      <input type="text" name="title" value="${inq.title}"
             style="width:100%; padding:8px; border:1px solid #ccc;" required/>
    </div>

    <div style="margin-bottom:16px;">
      <label>내용</label><br/>
      <textarea name="content" rows="6"
                style="width:100%; padding:8px; border:1px solid #ccc;"
                required>${inq.content}</textarea>
    </div>

    <div style="text-align:right;">
      <button type="submit"
              style="padding:8px 16px; background:#007bff; color:#fff; border:none;">
        저장
      </button>
      <button type="button"
              style="padding:8px 16px; margin-left:8px;"
              onclick="history.back();">
        취소
      </button>
    </div>
  </form>
</div>

<jsp:include page="/common/footer.jsp" />
