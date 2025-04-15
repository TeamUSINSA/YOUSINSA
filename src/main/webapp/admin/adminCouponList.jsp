<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>쿠폰 보기</title>
  <style>
    body {
      font-family: 'Pretendard', sans-serif;
      display: block;
      justify-content: center;
      align-items: center;
      min-height: 100vh;
      margin: 0;
      background-color: #f8f8f8;
    }

    .container {
      width: 800px;
      background-color: white;
      padding: 30px;
      border: 1px solid #ccc;
      border-radius: 12px;
      box-shadow: 0 0 10px rgba(0,0,0,0.05);
      margin: 0 auto;
    }

    h2 {
            width: 700px;
            margin: 50px auto 10px auto;
            text-align: left;
            font-size: 20px;
            font-weight: bold;
        }

    table {
      width: 100%;
      border-collapse: collapse;
    }

    thead {
      background-color: #e0e0e0;
    }

    th, td {
      padding: 12px;
      text-align: center;
      border-bottom: 1px solid #ddd;
    }

    .upload-btn {
      background-color: #d9d9d9;
      border: none;
      padding: 5px 10px;
      cursor: pointer;
      border-radius: 4px;
    }

    .delete-icon {
      cursor: pointer;
      font-size: 18px;
    }

    tbody tr:hover {
      background-color: #f4f4f4;
    }
  </style>
</head>
<body>
    <h2>쿠폰 보기</h2>
  <div class="container">
    
    <table>
      <thead>
        <tr>
          <th>쿠폰명</th>
          <th>할인금액</th>
          <th>쿠폰 발송</th>
          <th>삭제</th>
        </tr>
      </thead>
      <tbody>
        <tr><td>웰컴 쿠폰</td><td>10%</td><td>자동</td><td class="delete-icon">🗑️</td></tr>
        <tr><td>생일 쿠폰</td><td>5000원</td><td>자동</td><td class="delete-icon">🗑️</td></tr>
        <tr><td>5만원 이상 쿠폰</td><td>3000원</td><td>자동</td><td class="delete-icon">🗑️</td></tr>
        <tr><td>10만원 이상 쿠폰</td><td>5%</td><td>자동</td><td class="delete-icon">🗑️</td></tr>
        <tr><td>50만원 이상 쿠폰</td><td>10000원</td><td>자동</td><td class="delete-icon">🗑️</td></tr>
        <tr><td>100만원 이상 쿠폰</td><td>15%</td><td>자동</td><td class="delete-icon">🗑️</td></tr>
        <tr><td>감사 쿠폰</td><td>5%</td><td><button class="upload-btn">업로드</button></td><td class="delete-icon">🗑️</td></tr>
        <tr><td>봄맞이 쿠폰</td><td>5000원</td><td><button class="upload-btn">업로드</button></td><td class="delete-icon">🗑️</td></tr>
        <tr><td>쿠폰</td><td>3000원</td><td><button class="upload-btn">업로드</button></td><td class="delete-icon">🗑️</td></tr>
        <tr><td>감사 쿠폰</td><td>10%</td><td><button class="upload-btn">업로드</button></td><td class="delete-icon">🗑️</td></tr>
      </tbody>
    </table>
  </div>
</body>
</html>
