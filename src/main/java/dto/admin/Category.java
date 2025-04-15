package dto.admin;

public class Category {
	
	int categoryid;
	String categoryname;
	
	
	public Category() {
		super();
		// TODO Auto-generated constructor stub
	}

	public Category(int categoryid, String categoryname) {
		super();
		this.categoryid = categoryid;
		this.categoryname = categoryname;
	}

	public int getCategoryId() {
		return categoryid;
	}

	public void setCategoryId(int categoryid) {
		this.categoryid = categoryid;
	}

	public String getCategoryName() {
		return categoryname;
	}

	public void setCategoryName(String categoryname) {
		this.categoryname = categoryname;
	}

	

}
