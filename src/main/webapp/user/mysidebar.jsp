<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>마이페이지 메뉴</title>
  <style>
    body {
      font-family: 'Arial', sans-serif;
    }
    .sidebar {
      width: 150px;
      border-right: 1px solid #ccc;
      padding: 20px 10px;
    }
    .sidebar h3 {
      font-size: 14px;
      margin: 0 0 10px 0;
      text-align: center;
    }
    .menu-section {
      margin-bottom: 20px;
    }
    hr {
      margin: 10px 0;
      border: none;
      border-top: 1px solid #ccc;
    }
    .menu-item {
      font-size: 13px;
      margin: 8px 0;
      text-align: center;
      cursor: pointer;
    }
    .menu-item:hover {
      text-decoration: underline;
    }
  </style>
</head>
<body>
  <div class="sidebar">
    <h3>마이페이지</h3>
    <hr>

    <div class="menu-section">
      <div class="menu-item"><a href="memberInfoEdit">정보</a></div>
      <div class="menu-item"><a href="myAddress">나의 주소지</a></div>
      <hr>
      <div class="menu-item"><a href="mycart">장바구니</a></div>
      <div class="menu-item"><a href="myOrderList">주문 / 배송조회</a></div>
      <div class="menu-item"><a href="myCancelList">취소 / 반품 내역</a></div>
      <div class="menu-item"><a href="myLikeList">좋아요 목록</a></div>
      <div class="menu-item"><a href="myRestockList">재입고 확인</a></div>
      <hr>
      <div class="menu-item"><a href="myCouponList">나의 쿠폰</a></div>
      <div class="menu-item"><a href="myPoint">포인트</a></div>
      <hr>
      <div class="menu-item"><a href="myReviewList">나의 후기</a></div>
      <div class="menu-item"><a href="myAlarm">나의 알림</a></div>
      <div class="menu-item"><a href="myInquiryList">나의 1:1 문의</a></div>
      <div class="menu-item"><a href="myQna">Q&A</a></div>
      <hr>
    </div>
  </div>
</body>
</html>
