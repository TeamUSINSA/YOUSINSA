package dto.order;

public class OrderItem {
    private int orderItemId;
    private int orderId;
    private int productId;
    private int quantity;
    private String status;
    private int couponId;
    private String color;
    private String size;
    private int price;
    
    private int discount; 
    private String name;
    private String mainImage1;
   
    private boolean hasReview;
    private int cost;
    public int getCost() { return cost; }
    public void setCost(int cost) { this.cost = cost; }

    public int getDiscount() { return discount; }
    public void setDiscount(int discount) { this.discount = discount; }

    public OrderItem() {}

    
	public boolean isHasReview() {
		return hasReview;
	}


	public void setHasReview(boolean hasReview) {
		this.hasReview = hasReview;
	}


	public int getprice() {
		return price;
	}


	public void setPrice(int price) {
		this.price = price;
	}


	public String getName() {
		return name;
	}


	public void setName(String name) {
		this.name = name;
	}


	public String getMainImage1() {
		return mainImage1;
	}


	public void setMainImage1(String mainImage1) {
		this.mainImage1 = mainImage1;
	}


	public int getOrderItemId() {
		return orderItemId;
	}

	public void setOrderItemId(int orderItemId) {
		this.orderItemId = orderItemId;
	}

	public int getOrderId() {
		return orderId;
	}

	public void setOrderId(int orderId) {
		this.orderId = orderId;
	}

	public int getProductId() {
		return productId;
	}

	public void setProductId(int productId) {
		this.productId = productId;
	}

	public int getQuantity() {
		return quantity;
	}

	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public int getCouponId() {
		return couponId;
	}

	public void setCouponId(int couponId) {
		this.couponId = couponId;
	}

	public String getColor() {
		return color;
	}

	public void setColor(String color) {
		this.color = color;
	}

	public String getSize() {
		return size;
	}

	public void setSize(String size) {
		this.size = size;
	}
    
}
