package dto.user;

import java.util.Date;
import java.util.List;
import dto.order.OrderItem;

public class CancelReturn {
    private int orderId;
    private Date orderDate;
    private Date actionDate;      // 취소일자 혹은 반품일자
    private String reason;
    private String status;        // deliveryStatus
    private List<OrderItem> items;
    private String type;          // "C" (취소) or "R" (반품)

    public CancelReturn() {}

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

    public Date getActionDate() {
        return actionDate;
    }
    public void setActionDate(Date actionDate) {
        this.actionDate = actionDate;
    }

    public String getReason() {
        return reason;
    }
    public void setReason(String reason) {
        this.reason = reason;
    }

    public String getStatus() {
        return status;
    }
    public void setStatus(String status) {
        this.status = status;
    }

    public List<OrderItem> getItems() {
        return items;
    }
    public void setItems(List<OrderItem> items) {
        this.items = items;
    }

    public String getType() {
        return type;
    }
    public void setType(String type) {
        this.type = type;
    }
}
