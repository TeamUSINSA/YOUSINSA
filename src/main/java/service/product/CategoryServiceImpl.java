package service.product;

import java.util.List;

import dao.product.CategoryDAO;
import dao.product.CategoryDAOImpl;
import dto.product.Category;
import dto.product.SubCategory;

public class CategoryServiceImpl implements CategoryService {

    private CategoryDAO categoryDao;

    public CategoryServiceImpl() {
        this.categoryDao = new CategoryDAOImpl();
    }

    @Override
    public void insertCategory(Category category) {
        categoryDao.insertCategory(category);
    }
    
    @Override
    public void deleteCategoryById(int categoryId) {
        categoryDao.deleteCategoryById(categoryId);
    }

    @Override
    public List<Category> selectCategoryList() {
        return categoryDao.selectCategoryList();
    }

    @Override
    public void insertSubCategory(SubCategory subCategory) {
        categoryDao.insertSubCategory(subCategory);
    }
    
    @Override
    public void deleteSubCategoryById(int subCategoryId) {
        categoryDao.deleteSubCategoryById(subCategoryId);
    }


    @Override
    public List<SubCategory> selectSubCategoryList() {
        return categoryDao.selectSubCategoryList();
    }
    
    @Override
    public List<SubCategory> selectSubCategoriesByCategoryId(int categoryId) {
        return categoryDao.selectSubCategoriesByCategoryId(categoryId);
    }

}
