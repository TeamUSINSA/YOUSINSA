package dto.product;

public class ProductStock {
	private int stockId;
	private int productId;
	private String color;
	private String size;
	private int quantity;

	public ProductStock() {}

	public int getStockId() {
		return stockId;
	}

	public void setStockId(int stockId) {
		this.stockId = stockId;
	}

	public int getProductId() {
		return productId;
	}

	public void setProductId(int productId) {
		this.productId = productId;
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

	@Override
	public String toString() {
		return "ProductStock [stockId=" + stockId + ", productId=" + productId + ", color=" + color + ", size=" + size
				+ ", quantity=" + quantity + "]";
	}
	
	
}
