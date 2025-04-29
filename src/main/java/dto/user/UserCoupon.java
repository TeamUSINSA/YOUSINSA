package dto.user;

import java.sql.Date;

import dto.order.Coupon;

public class UserCoupon {
    private int couponId;
    private String userId;
    private boolean used;
    private Date issueDate;
    private Date expireDate;

    private Coupon coupon;

    public UserCoupon() {}


    
    
	public Coupon getCoupon() {
		return coupon;
	}




	public void setCoupon(Coupon coupon) {
		this.coupon = coupon;
	}




	public Date getIssueDate() {
		return issueDate;
	}



	public void setIssueDate(Date issueDate) {
		this.issueDate = issueDate;
	}



	public Date getExpireDate() {
		return expireDate;
	}



	public void setExpireDate(Date expireDate) {
		this.expireDate = expireDate;
	}



	public int getCouponId() {
		return couponId;
	}


	public void setCouponId(int couponId) {
		this.couponId = couponId;
	}


	public String getUserId() {
		return userId;
	}


	public void setUserId(String userId) {
		this.userId = userId;
	}


	public boolean isUsed() {
		return used;
	}


	public void setUsed(boolean used) {
		this.used = used;
	}
    
    
}

