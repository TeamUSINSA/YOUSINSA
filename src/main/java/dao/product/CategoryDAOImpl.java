package dao.product;

import java.util.List;
import org.apache.ibatis.session.SqlSession;

import dto.product.Category;
import dto.product.SubCategory;
import utils.MybatisSqlSessionFactory;

public class CategoryDAOImpl implements CategoryDAO {

    private SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession(true); // auto-commit

    @Override
    public void insertCategory(Category category) throws Exception{
        sqlSession.insert("mapper.category.insertCategory", category);
    }

    @Override
    public void deleteCategoryById(int categoryId) throws Exception {
        sqlSession.delete("mapper.category.deleteCategory", categoryId);
    }

    @Override
    public List<Category> selectCategoryList() throws Exception{
        return sqlSession.selectList("mapper.category.selectCategoryList");
    }

    @Override
    public void insertSubCategory(SubCategory subCategory) throws Exception{
        sqlSession.insert("mapper.category.insertSubCategory", subCategory);
    } 

    @Override
    public List<SubCategory> selectSubCategoryList() throws Exception{
        return sqlSession.selectList("mapper.category.selectSubCategoryList");
    }
    
    @Override
    public void deleteSubCategoryById(int subCategoryId) throws Exception{
        sqlSession.delete("mapper.category.deleteSubCategory", subCategoryId);
    }
    
    @Override
    public List<SubCategory> selectSubCategoriesByCategoryId(int categoryId) throws Exception{
        return sqlSession.selectList("mapper.category.selectSubCategoriesByCategoryId", categoryId);
    }

}
