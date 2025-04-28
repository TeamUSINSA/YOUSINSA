package dto.user;

public class RestockRequest {
    private int requestId;
    private int productId;
    private String userId;
    private String size;
    private String color;

    private String name;        // 상품명
    private int    stock;       // 재고 수량
    private String mainImage1;  // 대표 이미지 URL
    
    public RestockRequest() {}


	public int getRequestId() {
		return requestId;
	}


	
	public String getName() {
		return name;
	}


	public void setName(String name) {
		this.name = name;
	}


	public int getStock() {
		return stock;
	}


	public void setStock(int stock) {
		this.stock = stock;
	}


	public String getMainImage1() {
		return mainImage1;
	}


	public void setMainImage1(String mainImage1) {
		this.mainImage1 = mainImage1;
	}


	public void setRequestId(int requestId) {
		this.requestId = requestId;
	}


	public int getProductId() {
		return productId;
	}


	public void setProductId(int productId) {
		this.productId = productId;
	}


	public String getUserId() {
		return userId;
	}


	public void setUserId(String userId) {
		this.userId = userId;
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

