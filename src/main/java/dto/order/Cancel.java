package dto.order;

import java.sql.Date;

public class Cancel {
    private int cancelId;
    private Date cancelDate;
    private String reason;
    private String userId;
    private int orderId;

    
    public Cancel() {}

	public int getCancelId() {
		return cancelId;
	}

	public void setCancelId(int cancelId) {
		this.cancelId = cancelId;
	}

	public Date getCancelDate() {
		return cancelDate;
	}

	public void setCancelDate(Date cancelDate) {
		this.cancelDate = cancelDate;
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

	public int getOrderId() {
		return orderId;
	}

	public void setOrderId(int orderId) {
		this.orderId = orderId;
	}
    
    
}

