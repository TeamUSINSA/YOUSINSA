package dto.order;

public class Order {
	private int orderId;
	private int cartId;
	private String userId; 
	private String receiverName;
	private String receiverPhone; 
	private String baseAddress;
	private String detailAddress;
	private int usedPoints;
	private String paymentMethod;
	private int productId;
	private String name;
	private String image;
	private String color;
	private String size;
	private int quantity;
	private int unitPrice;
	private Integer couponId; 


	public int getTotalPrice() {
		return unitPrice * quantity;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
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

	public String getBaseAddress() {
		return baseAddress;
	}

	public void setBaseAddress(String baseAddress) {
		this.baseAddress = baseAddress;
	}

	public String getDetailAddress() {
		return detailAddress;
	}

	public void setDetailAddress(String detailAddress) {
		this.detailAddress = detailAddress;
	}

	public int getUsedPoints() {
		return usedPoints;
	}

	public void setUsedPoints(int usedPoints) {
		this.usedPoints = usedPoints;
	}

	public String getPaymentMethod() {
		return paymentMethod;
	}

	public void setPaymentMethod(String paymentMethod) {
		this.paymentMethod = paymentMethod;
	}

	public int getProductId() {
		return productId;
	}

	public void setProductId(int productId) {
		this.productId = productId;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getImage() {
		return image;
	}

	public void setImage(String image) {
		this.image = image;
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

	public int getQuantity() {
		return quantity;
	}

	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}

	public int getUnitPrice() {
		return unitPrice;
	}

	public void setUnitPrice(int unitPrice) {
		this.unitPrice = unitPrice;
	}

	public Integer getCouponId() {
		return couponId;
	}

	public void setCouponId(Integer couponId) {
		this.couponId = couponId;
	}
	
	public int getOrderId() {
	    return orderId;
	}

	public void setOrderId(int orderId) {
	    this.orderId = orderId;
	}
	public int getCartId() {
	    return cartId;
	}

	public void setCartId(int cartId) {
	    this.cartId = cartId;
	}
}
