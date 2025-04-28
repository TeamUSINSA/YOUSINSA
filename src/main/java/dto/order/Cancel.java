package dto.order;

import java.sql.Date;
import java.util.List;

public class Cancel {
    private int cancelId;
    private Date cancelDate;
    private String reason;
    private String userId;
    private int orderId;
    
    private OrderList order;
    private List<OrderItem> orderItems;
    private int price;
    
    
    
    public int getPrice() {
		return price;
	}

	public void setPrice(int price) {
		this.price = price;
	}

	public Cancel() {}

	public int getCancelId() {
		return cancelId;
	}

	public List<OrderItem> getOrderItems() {
		return orderItems;
	}

	public void setOrderItems(List<OrderItem> orderItems) {
		this.orderItems = orderItems;
	}

	public OrderList getOrder() {
		return order;
	}

	public void setOrder(OrderList order) {
		this.order = order;
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

