package dto.user;

import java.sql.Date;

public class CancelReturn {
	// ──────────────────────────────────────────────────────
    // 주문 헤더
    private int    orderId;       // 주문번호
    private Date   orderDate;     // 주문일자
    // ──────────────────────────────────────────────────────
    // 상품 정보 (OrderItem 재활용)
    private int    orderItemId;   // 상품항목ID (취소면 0)
    private int    productId;     // 상품ID
    private String name;          // 상품명
    private String mainImage1;    // 상품이미지
    private String color;         // 색상
    private String size;          // 사이즈
    private int    quantity;      // 수량
    private int    price;         // 단가
    // ──────────────────────────────────────────────────────
    // 상태 및 완료일
    private String status;        // 항상 orderlist.delivery_status
    private Date   actionDate;    // cancel.cancel_date or return.return_date
    // ──────────────────────────────────────────────────────

    public CancelReturn() {}

    // getters / setters...
    public int getOrderId()           { return orderId; }
    public void setOrderId(int o)     { orderId = o; }
    public Date getOrderDate()        { return orderDate; }
    public void setOrderDate(Date d)  { orderDate = d; }

    public int getOrderItemId()           { return orderItemId; }
    public void setOrderItemId(int i)     { orderItemId = i; }
    public int getProductId()             { return productId; }
    public void setProductId(int p)       { productId = p; }
    public String getName()               { return name; }
    public void setName(String n)         { name = n; }
    public String getMainImage1()         { return mainImage1; }
    public void setMainImage1(String m)   { mainImage1 = m; }
    public String getColor()              { return color; }
    public void setColor(String c)        { color = c; }
    public String getSize()               { return size; }
    public void setSize(String s)         { size = s; }
    public int getQuantity()              { return quantity; }
    public void setQuantity(int q)        { quantity = q; }
    public int getPrice()                 { return price; }
    public void setPrice(int p)           { price = p; }

    public String getStatus()             { return status; }
    public void setStatus(String s)       { status = s; }
    public Date getActionDate()           { return actionDate; }
    public void setActionDate(Date d)     { actionDate = d; }
}