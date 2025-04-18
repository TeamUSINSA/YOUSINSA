package dao.product;

import java.util.List;
import org.apache.ibatis.session.SqlSession;

import dto.product.Category;
import dto.product.SubCategory;
import utils.MybatisSqlSessionFactory;

public class CategoryDAOImpl implements CategoryDAO {

    private SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession(true); // auto-commit

    @Override
    public void insertCategory(Category category) {
        sqlSession.insert("mapper.category.insertCategory", category);
    }

    @Override
    public void deleteCategoryById(int categoryId) {
        sqlSession.delete("mapper.category.deleteCategory", categoryId);
    }

    @Override
    public List<Category> selectCategoryList() {
        return sqlSession.selectList("mapper.category.selectCategoryList");
    }

    @Override
    public void insertSubCategory(SubCategory subCategory) {
        sqlSession.insert("mapper.category.insertSubCategory", subCategory);
    } 

    @Override
    public List<SubCategory> selectSubCategoryList() {
        return sqlSession.selectList("mapper.category.selectSubCategoryList");
    }
    
    @Override
    public void deleteSubCategoryById(int subCategoryId) {
        sqlSession.delete("mapper.category.deleteSubCategory", subCategoryId);
    }
    
    @Override
    public List<SubCategory> selectSubCategoriesByCategoryId(int categoryId) {
        return sqlSession.selectList("mapper.category.selectSubCategoriesByCategoryId", categoryId);
    }
    
    @Override
    public List<Category> selectCategoryWithSubList() {
        return sqlSession.selectList("mapper.category.selectCategoryWithSubList");
    }


}
