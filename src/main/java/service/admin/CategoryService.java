package service.admin;

import java.util.List;
import dto.admin.Category;
import dto.admin.SubCategory;

public interface CategoryService {
    void insertCategory(Category category);
    List<Category> selectCategoryList();

    void insertSubCategory(SubCategory subCategory);
    List<SubCategory> selectSubCategoryList();
}
