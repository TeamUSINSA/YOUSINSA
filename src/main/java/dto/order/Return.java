package dto.order;

import java.util.Date;

public class Return {
    private int returnId;
    private Date returnDate;
    private String reason;
    private String userId;
    private int orderItemId;
    private int approved;
    private String rejectReason;


    public Return() {}


	public int getReturnId() {
		return returnId;
	}


	public void setReturnId(int returnId) {
		this.returnId = returnId;
	}


	public Date getReturnDate() {
		return returnDate;
	}


	public void setReturnDate(Date returnDate) {
		this.returnDate = returnDate;
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


	public int isApproved() {
		return approved;
	}


	public void setApproved(int approved) {
		this.approved = approved;
	}


	public String getRejectReason() {
		return rejectReason;
	}


	public void setRejectReason(String rejectReason) {
		this.rejectReason = rejectReason;
	}
    
    
}
