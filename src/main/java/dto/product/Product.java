package dto.product;

import java.sql.Date;
import java.util.ArrayList;
import java.util.List;

public class Product {
	private int productId;
	private String name;
	private int cost;
	private int price;
	private int discount;
	private int subCategoryId;
	private String type;
	private Date regDate;
	private String description1;
	private String description2;
	private String mainImage1;
	private String mainImage2;
	private String mainImage3;
	private String mainImage4;
	private String image1;
	private String image2;
	private String image3;
	private String image4;
	private String image5;
	private String image6;
	private String image7;
	private String image8;
	private String image9;
	private String image10;
	private String sizeChart;
	private String sizeType;
	// Product.java 안에 아래 추가


	private String category1;
	private String category2;
	private String code;

	private String sizeImage;
	private int quantity; // 판매량
	private int sales; // 총매출 (판매량 * 가격)

	public int getQuantity() {
		return quantity;
	}

	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}

	public int getSales() {
		return sales;
	}

	public void setSales(int sales) {
		this.sales = sales;
	}

	public String getSizeImage() {
		return sizeImage;
	}

	public void setSizeImage(String sizeImage) {
		this.sizeImage = sizeImage;
	}

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public String getCategory1() {
		return category1;
	}

	public void setCategory1(String category1) {
		this.category1 = category1;
	}

	public String getCategory2() {
		return category2;
	}

	public void setCategory2(String category2) {
		this.category2 = category2;
	}

	public Product() {
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

	public int getCost() {
		return cost;
	}

	public void setCost(int cost) {
		this.cost = cost;
	}

	public int getPrice() {
		return price;
	}

	public void setPrice(int price) {
		this.price = price;
	}

	public int getDiscount() {
		return discount;
	}

	public void setDiscount(int discount) {
		this.discount = discount;
	}

	public int getSubCategoryId() {
		return subCategoryId;
	}

	public void setSubCategoryId(int subCategoryId) {
		this.subCategoryId = subCategoryId;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public Date getRegDate() {
		return regDate;
	}

	public void setRegDate(Date regDate) {
		this.regDate = regDate;
	}

	public String getDescription1() {
		return description1;
	}

	public void setDescription1(String description1) {
		this.description1 = description1;
	}

	public String getDescription2() {
		return description2;
	}

	public void setDescription2(String description2) {
		this.description2 = description2;
	}

	public String getMainImage1() {
		return mainImage1;
	}

	public void setMainImage1(String mainImage1) {
		this.mainImage1 = mainImage1;
	}

	public String getMainImage2() {
		return mainImage2;
	}

	public void setMainImage2(String mainImage2) {
		this.mainImage2 = mainImage2;
	}

	public String getMainImage3() {
		return mainImage3;
	}

	public void setMainImage3(String mainImage3) {
		this.mainImage3 = mainImage3;
	}

	public String getMainImage4() {
		return mainImage4;
	}

	public void setMainImage4(String mainImage4) {
		this.mainImage4 = mainImage4;
	}

	public String getImage1() {
		return image1;
	}

	public void setImage1(String image1) {
		this.image1 = image1;
	}

	public String getImage2() {
		return image2;
	}

	public void setImage2(String image2) {
		this.image2 = image2;
	}

	public String getImage3() {
		return image3;
	}

	public void setImage3(String image3) {
		this.image3 = image3;
	}

	public String getImage4() {
		return image4;
	}

	public void setImage4(String image4) {
		this.image4 = image4;
	}

	public String getImage5() {
		return image5;
	}

	public void setImage5(String image5) {
		this.image5 = image5;
	}

	public String getImage6() {
		return image6;
	}

	public void setImage6(String image6) {
		this.image6 = image6;
	}

	public String getImage7() {
		return image7;
	}

	public void setImage7(String image7) {
		this.image7 = image7;
	}

	public String getImage8() {
		return image8;
	}

	public void setImage8(String image8) {
		this.image8 = image8;
	}

	public String getImage9() {
		return image9;
	}

	public void setImage9(String image9) {
		this.image9 = image9;
	}

	public String getImage10() {
		return image10;
	}

	public void setImage10(String image10) {
		this.image10 = image10;
	}

	public String getSizeChart() {
		return sizeChart;
	}

	public void setSizeChart(String sizeChart) {
		this.sizeChart = sizeChart;
	}

	public List<String> getImageList() {
		List<String> list = new ArrayList<>();

		if (this.getMainImage1() != null)
			list.add(this.getMainImage1());
		if (this.getMainImage2() != null)
			list.add(this.getMainImage2());
		if (this.getMainImage3() != null)
			list.add(this.getMainImage3());
		if (this.getMainImage4() != null)
			list.add(this.getMainImage4());

		return list;
	}

	public int getDiscountPrice() {
		if (price > 0 && discount > 0) {
			return price - (price * discount / 100);
		}
		return price;
	}

	public List<String> getDescriptionImages() {
		List<String> list = new ArrayList<>();

		if (this.getImage1() != null)
			list.add(this.getImage1());
		if (this.getImage2() != null)
			list.add(this.getImage2());
		if (this.getImage3() != null)
			list.add(this.getImage3());
		if (this.getImage4() != null)
			list.add(this.getImage4());
		if (this.getImage5() != null)
			list.add(this.getImage5());
		if (this.getImage6() != null)
			list.add(this.getImage6());
		if (this.getImage7() != null)
			list.add(this.getImage7());
		if (this.getImage8() != null)
			list.add(this.getImage8());
		if (this.getImage9() != null)
			list.add(this.getImage9());
		if (this.getImage10() != null)
			list.add(this.getImage10());

		return list;
	}

	public String getDescription() {
		StringBuilder sb = new StringBuilder();
		if (description1 != null)
			sb.append(description1);
		if (description2 != null)
			sb.append("\n").append(description2);
		return sb.toString();
	}
}
