package dto.user;

public class UserCoupon {
    private int couponId;
    private String userId;
    private boolean used;


    public UserCoupon() {}


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

