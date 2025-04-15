package dao.admin;

import java.util.List;

import dto.admin.Category;
import dto.admin.SubCategory;

public interface CategoryDAO {
    void insertCategory(Category category);
    List<Category> selectCategoryList();

    void insertSubCategory(SubCategory subCategory);
    List<SubCategory> selectSubCategoryList();
}
