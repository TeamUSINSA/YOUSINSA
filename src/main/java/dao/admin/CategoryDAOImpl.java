package dao.admin;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import dto.admin.Category;
import dto.admin.SubCategory;
import utils.MybatisSqlSessionFactory;

public class CategoryDAOImpl implements CategoryDAO {

    private SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession(true); // auto-commit

    @Override
    public void insertCategory(Category category) {
        sqlSession.insert("mapper.category.insertCategory", category);
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
}
