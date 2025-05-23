package dto.order;

import java.sql.Date;
import java.util.List;

public class OrderList {


    private int orderId;
    private Date orderDate;
    private int totalPrice;
    private String deliveryStatus;
    private String deliveryRequest;
    private String deliveryMethod;
    private String paymentMethod;
    private String userId;
    private int pointId;
    private String receiverName;
    private String receiverPhone;
    private String receiverAddress;
    private int usedPoint;
    private int couponDiscount;
    private String paymentStatus; 
    private String paymentKey; 
    private Date approvedAt;
    
    
    private List<OrderItem> items;
    
    public List<OrderItem> getItems() {
		return items;
	}


	public void setItems(List<OrderItem> items) {
		this.items = items;
	}

	// 기본 생성자

    public OrderList() {}


	public int getOrderId() {
		return orderId;
	}


	public void setOrderId(int orderId) {
		this.orderId = orderId;
	}


	public Date getOrderDate() {
		return orderDate;
	}


	public void setOrderDate(Date orderDate) {
		this.orderDate = orderDate;
	}


	public int getTotalPrice() {
		return totalPrice;
	}


	public void setTotalPrice(int totalPrice) {
		this.totalPrice = totalPrice;
	}


	public String getDeliveryStatus() {
		return deliveryStatus;
	}


	public void setDeliveryStatus(String deliveryStatus) {
		this.deliveryStatus = deliveryStatus;
	}


	public String getDeliveryRequest() {
		return deliveryRequest;
	}


	public void setDeliveryRequest(String deliveryRequest) {
		this.deliveryRequest = deliveryRequest;
	}


	public String getDeliveryMethod() {
		return deliveryMethod;
	}


	public void setDeliveryMethod(String deliveryMethod) {
		this.deliveryMethod = deliveryMethod;
	}


	public String getPaymentMethod() {
		return paymentMethod;
	}


	public void setPaymentMethod(String paymentMethod) {
		this.paymentMethod = paymentMethod;
	}


	public String getUserId() {
		return userId;
	}


	public void setUserId(String userId) {
		this.userId = userId;
	}


	public int getPointId() {
		return pointId;
	}


	public void setPointId(int pointId) {
		this.pointId = pointId;
	}


	public String getReceiverName() {
		return receiverName;
	}


	public void setReceiverName(String receiverName) {
		this.receiverName = receiverName;
	}


	public String getReceiverPhone() {
		return receiverPhone;
	}


	public void setReceiverPhone(String receiverPhone) {
		this.receiverPhone = receiverPhone;
	}


	public String getReceiverAddress() {
		return receiverAddress;
	}


	public void setReceiverAddress(String receiverAddress) {
		this.receiverAddress = receiverAddress;
	}


	public int getUsedPoint() {
		return usedPoint;
	}


	public void setUsedPoint(int usedPoint) {
		this.usedPoint = usedPoint;
	}


	public int getCouponDiscount() {
		return couponDiscount;
	}


	public void setCouponDiscount(int couponDiscount) {
		this.couponDiscount = couponDiscount;
	}


	public String getPaymentStatus() {
		return paymentStatus;
	}


	public void setPaymentStatus(String paymentStatus) {
		this.paymentStatus = paymentStatus;
	}


	public String getPaymentKey() {
		return paymentKey;
	}


	public void setPaymentKey(String paymentKey) {
		this.paymentKey = paymentKey;
	}


	public Date getApprovedAt() {
		return approvedAt;
	}


	public void setApprovedAt(Date approvedAt) {
		this.approvedAt = approvedAt;
	}


	
}



