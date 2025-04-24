<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="sidebar">
  <h3>마이페이지</h3>
  <hr>

  <div class="menu-section">
    <div class="menu-item"><a href="memberInfoEdit">정보</a></div>
    <div class="menu-item"><a href="myAddress">나의 주소지</a></div>
    <hr>
    <div class="menu-item"><a href="mycart">장바구니</a></div>
    <div class="menu-item"><a href="myOrders">주문 / 배송조회</a></div>
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

<style>
  .sidebar {
    width: 200px;
    background-color: #fff;
    padding: 20px 15px;
    border-radius: 8px;
    box-sizing: border-box;
    box-shadow: 0 0 8px rgba(0, 0, 0, 0.05);
}


    .sidebar h4 {
        margin: 20px 0 10px;
        font-size: 14px;
        padding-bottom: 5px;
        border-bottom: 1px solid #ddd;
        color: #444;
    }

    .sidebar ul {
        list-style: none;
        padding: 0;
        margin: 0;
    }

    .sidebar li {
        margin: 6px 0;
    }

    .sidebar a {
        display: block;
        color: #333;
        font-size: 13px;
        text-decoration: none;
        padding: 6px 8px;
        border-radius: 4px;
        transition: background-color 0.2s;
    }

    .sidebar a:hover {
        background-color: #f0f0f0;
    }
</style>
