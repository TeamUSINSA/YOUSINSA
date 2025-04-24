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
    public void insertCategory(Category category) throws Exception{
        categoryDao.insertCategory(category);
    }
    
    @Override
    public void deleteCategoryById(int categoryId) throws Exception{
        categoryDao.deleteCategoryById(categoryId);
    }

    @Override
    public List<Category> selectCategoryList() throws Exception{
        return categoryDao.selectCategoryList();
    }

    @Override
    public void insertSubCategory(SubCategory subCategory) throws Exception{
        categoryDao.insertSubCategory(subCategory);
    }
    
    @Override
    public void deleteSubCategoryById(int subCategoryId) throws Exception{
        categoryDao.deleteSubCategoryById(subCategoryId);
    }


    @Override
    public List<SubCategory> selectSubCategoryList() throws Exception{
        return categoryDao.selectSubCategoryList();
    }
    
    @Override
    public List<SubCategory> selectSubCategoriesByCategoryId(int categoryId) throws Exception{
        return categoryDao.selectSubCategoriesByCategoryId(categoryId);
    }
    
    @Override
    public List<Category> selectCategoryWithSubList() throws Exception{
        return categoryDao.selectCategoryWithSubList();
    }



}
