package dto.order;

import java.sql.Date;

public class Coupon {

	private int couponId;
	private String name;
	private String description;
	private int discountAmount;
	private Date startDate;
	private Date endDate;
	private String type;
	private boolean active;
	private int period;
	
	private Coupon coupon;

	public Coupon() {
	}


	public Coupon(int couponId, String name, String description, int discountAmount, Date startDate, Date endDate,
			String type, boolean active) {
		this.couponId = couponId;
		this.name = name;
		this.description = description;
		this.discountAmount = discountAmount;
		this.startDate = startDate;
		this.endDate = endDate;
		this.type = type;
		this.active = active;
	}

	// Getter & Setter
	
	
	public int getCouponId() {
		return couponId;
	}

	public Coupon getCoupon() {
		return coupon;
	}


	public void setCoupon(Coupon coupon) {
		this.coupon = coupon;
	}


	public int getPeriod() {
		return period;
	}


	public void setPeriod(int period) {
		this.period = period;
	}


	public void setCouponId(int couponId) {
		this.couponId = couponId;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public int getDiscountAmount() {
		return discountAmount;
	}

	public void setDiscountAmount(int discountAmount) {
		this.discountAmount = discountAmount;
	}

	public Date getStartDate() {
		return startDate;
	}

	public void setStartDate(Date startDate) {
		this.startDate = startDate;
	}

	public Date getEndDate() {
		return endDate;
	}

	public void setEndDate(Date endDate) {
		this.endDate = endDate;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public boolean isActive() {
		return active;
	}

	public void setActive(boolean active) {
		this.active = active;
	}
}
