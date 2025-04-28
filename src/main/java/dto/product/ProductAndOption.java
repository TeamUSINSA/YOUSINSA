package dto.product;

import java.util.ArrayList;
import java.util.List;

public class ProductAndOption {
	private Product product;
	
	private List<ProductOption> optionList = new ArrayList<>();
	
	public Product getProduct() {
		return product;
	}
	public void setProduct(Product product) {
		this.product = product;
	}
	public List<ProductOption> getOptionList() {
		return optionList;
	}
}
