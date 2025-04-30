package dao.product;

import java.util.List;

import dto.product.Category;
import dto.product.SubCategory;

public interface CategoryDAO {
	void insertCategory(Category category) throws Exception;

	List<Category> selectCategoryList() throws Exception;

	void insertSubCategory(SubCategory subCategory) throws Exception;

	List<SubCategory> selectSubCategoryList() throws Exception;

	void deleteSubCategoryById(int subCategoryId) throws Exception;

	void deleteCategoryById(int categoryId) throws Exception;

	List<SubCategory> selectSubCategoriesByCategoryId(int categoryId) throws Exception;

	List<Category> selectCategoryWithSubList() throws Exception;

	SubCategory selectSubCategoryById(int subCategoryId) throws Exception;

}
