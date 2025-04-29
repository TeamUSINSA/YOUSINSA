package dto.product;

public class ProductQuantity {
	private String size;
	private Integer quantity;
	public ProductQuantity() {};
	public ProductQuantity(String size, Integer quantity) {
		super();
		this.size = size;
		this.quantity = quantity;
	}
	public String getSize() {
		return size;
	}
	public void setSize(String size) {
		this.size = size;
	}
	public Integer getQuantity() {
		return quantity;
	}
	public void setQuantity(Integer quantity) {
		this.quantity = quantity;
	}
}
