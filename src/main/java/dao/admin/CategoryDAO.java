package dao.admin;

import java.util.List;

import dto.product.Category;
import dto.product.SubCategory;

public interface CategoryDAO {
    void insertCategory(Category category);
    List<Category> selectCategoryList();

    void insertSubCategory(SubCategory subCategory);
    List<SubCategory> selectSubCategoryList();
	void deleteSubCategoryById(int subCategoryId);
	void deleteCategoryById(int categoryId);
}
