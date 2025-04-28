<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8"/>
  <title>공지사항 등록</title>
  <style>
    body { margin:0; padding:0; font-family:Arial,sans-serif; background:#f5f5f5; }
    .container {
      max-width:600px; margin:40px auto; padding:24px;
      background:#fff; border-radius:8px; box-shadow:0 2px 8px rgba(0,0,0,0.1);
    }
    h2 { text-align:center; margin-bottom:24px; font-size:22px; color:#333; }
    .form-group { margin-bottom:16px; }
    .form-group label { display:block; margin-bottom:6px; font-weight:bold; color:#555; }
    .form-group input[type="text"],
    .form-group textarea,
    .form-group input[type="file"] {
      width:100%; padding:10px; border:1px solid #ccc; border-radius:4px;
      font-size:14px; box-sizing:border-box;
    }
    .preview { text-align:center; margin-top:8px; }
    .preview img { max-width:100%; max-height:200px; border:1px solid #ddd; border-radius:4px; }
    .btn-group { text-align:right; margin-top:24px; }
    .btn {
      display:inline-block; padding:8px 16px; margin-left:8px;
      text-decoration:none; font-size:14px; border-radius:4px;
      border:1px solid #bbb; color:#333; background:#eee;
    }
    .btn:hover { background:#ddd; }
    .btn-primary { background:#4CAF50; border-color:#45A049; color:#fff; }
    .btn-primary:hover { background:#45A049; }
  </style>
</head>
<body>
<jsp:include page="/header" />
  <div class="container">
    <h2>공지사항 등록</h2>
    <form action="${pageContext.request.contextPath}/noticeAdd" method="post" enctype="multipart/form-data">
      <div class="form-group">
        <label for="title">제목</label>
        <input type="text" id="title" name="title" required/>
      </div>
      <div class="form-group">
        <label for="imageFile">이미지 선택</label>
        <input type="file" id="imageFile" name="imageFile" accept="image/*" onchange="previewImage(event)"/>
        <div class="preview">
          <img id="preview" style="display:none;" alt="미리보기"/>
        </div>
      </div>
      <div class="form-group">
        <label for="content">내용</label>
        <textarea id="content" name="content" rows="8" required></textarea>
      </div>
      <div class="btn-group">
        <button type="submit" class="btn btn-primary">등록 완료</button>
        <a href="${pageContext.request.contextPath}/notice" class="btn">취소</a>
      </div>
    </form>
  </div>
<jsp:include page="/footer" />
  <script>
    function previewImage(evt) {
      const file = evt.target.files[0], p = document.getElementById('preview');
      if (!file) { p.style.display='none'; return; }
      p.src = URL.createObjectURL(file);
      p.style.display = 'block';
    }
  </script>
</body>
</html>
