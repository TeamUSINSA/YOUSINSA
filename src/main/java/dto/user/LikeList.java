package dto.user;

public class LikeList {
	private int likeId;
	private int productId;
	private String userId;

	// 조인된 product 정보
	private String name;
	private String detail;
	private String price;
	private String mainImage1;

	public String getDetail() {
		return detail;
	}

	public void setDetail(String detail) {
		this.detail = detail;
	}

	public int getLikeId() {
		return likeId;
	}

	public void setLikeId(int likeId) {
		this.likeId = likeId;
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

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getPrice() {
		return price;
	}

	public void setPrice(String price) {
		this.price = price;
	}

	public String getMainImage1() {
		return mainImage1;
	}

	public void setMainImage1(String mainImage1) {
		this.mainImage1 = mainImage1;
	}

}
