package dto.order;

import java.sql.Date;

public class Exchange {
    private int exchangeId;
    private Date exchangeDate;
    private String reason;
    private String userId;
    private int orderItemId;
    private boolean approved;
    private boolean shippingFee;
    private String rejectReason;
    private boolean shippingFeePaid;
    private String size;
    private String color;

    // 기본 생성자
    public Exchange() {}

	public int getExchangeId() {
		return exchangeId;
	}

	public void setExchangeId(int exchangeId) {
		this.exchangeId = exchangeId;
	}

	public Date getExchangeDate() {
		return exchangeDate;
	}

	public void setExchangeDate(Date exchangeDate) {
		this.exchangeDate = exchangeDate;
	}

	public String getReason() {
		return reason;
	}

	public void setReason(String reason) {
		this.reason = reason;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public int getOrderItemId() {
		return orderItemId;
	}

	public void setOrderItemId(int orderItemId) {
		this.orderItemId = orderItemId;
	}

	public boolean isApproved() {
		return approved;
	}

	public void setApproved(boolean approved) {
		this.approved = approved;
	}

	public boolean isShippingFee() {
		return shippingFee;
	}

	public void setShippingFee(boolean shippingFee) {
		this.shippingFee = shippingFee;
	}

	public String getRejectReason() {
		return rejectReason;
	}

	public void setRejectReason(String rejectReason) {
		this.rejectReason = rejectReason;
	}

	public boolean isShippingFeePaid() {
		return shippingFeePaid;
	}

	public void setShippingFeePaid(boolean shippingFeePaid) {
		this.shippingFeePaid = shippingFeePaid;
	}

	public String getSize() {
		return size;
	}

	public void setSize(String size) {
		this.size = size;
	}

	public String getColor() {
		return color;
	}

	public void setColor(String color) {
		this.color = color;
	}
    
    
}

