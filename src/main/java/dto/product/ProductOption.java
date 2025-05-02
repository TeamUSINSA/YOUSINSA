package dto.product;

import java.util.List;

public class ProductOption {
	private String color;
	private List<ProductQuantity> sizeQuanity;
	
	public ProductOption() {};
	public ProductOption(String color) {
		this.color=color;
	}
	public String getColor() {
		return color;
	}
	public void setColor(String color) {
		this.color = color;
	}
	public List<ProductQuantity> getSizeQuanity() {
		return sizeQuanity;
	}
	public void setSizeQuanity(List<ProductQuantity> sizeQuanity) {
		this.sizeQuanity = sizeQuanity;
	}
	@Override
	public String toString() {
		return "ProductOption [color=" + color + ", sizeQuanity=" + sizeQuanity + "]";
	}
}
