package dto.order;

import java.sql.Date;

public class Exchange {
    private int exchangeId;
    private Date exchangeDate;
    private String reason;
    private String userId;
    private int orderItemId;
    private int approved;             // ✅ boolean → int (DB에서 0/1/2)
    private int shippingFee;         // ✅ boolean → int
    private String rejectReason;
    private String shippingFeePaid;  // ✅ boolean → String (M, N 등으로 들어올 수 있음)
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

    public int getApproved() {
        return approved;
    }

    public void setApproved(int approved) {
        this.approved = approved;
    }

    public int getShippingFee() {
        return shippingFee;
    }

    public void setShippingFee(int shippingFee) {
        this.shippingFee = shippingFee;
    }

    public String getRejectReason() {
        return rejectReason;
    }

    public void setRejectReason(String rejectReason) {
        this.rejectReason = rejectReason;
    }

    public String getShippingFeePaid() {
        return shippingFeePaid;
    }

    public void setShippingFeePaid(String shippingFeePaid) {
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
