package dto.user;

import java.sql.Date;

public class Point {
	private int pointId;
	private Date date;
	private int point;          // 양수: 적립, 음수: 사용
	private int orderId;
	private String userId;
	
	private int balance;        // 누적 포인트 화면용

	 public Point() { }


	    public Point(int orderId, String userId, int point) {
	        this.orderId = orderId;
	        this.userId  = userId;
	        this.point   = point;
	    }


	public int getBalance() {
		return balance;
	}


	public void setBalance(int balance) {
		this.balance = balance;
	}


	public int getPointId() {
		return pointId;
	}

	public void setPointId(int pointId) {
		this.pointId = pointId;
	}

	public Date getDate() {
		return date;
	}

	public void setDate(Date date) {
		this.date = date;
	}

	public int getPoint() {
		return point;
	}

	public void setPoint(int point) {
		this.point = point;
	}

	public int getOrderId() {
		return orderId;
	}

	public void setOrderId(int orderId) {
		this.orderId = orderId;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}
}
