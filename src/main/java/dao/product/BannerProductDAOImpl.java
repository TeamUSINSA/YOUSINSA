package dao.product;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import dto.product.BannerProduct;
import utils.MybatisSqlSessionFactory;

public class BannerProductDAOImpl implements BannerProductDAO {

    private SqlSession sqlSession;

    public BannerProductDAOImpl() {
        sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
    }

    @Override
    public List<BannerProduct> selectMainBannerList() throws Exception{
        return sqlSession.selectList("mapper.bannerproduct.selectMainBannerList");
    }
    
    @Override
    public List<BannerProduct> selectSubBannerList() throws Exception{
        return sqlSession.selectList("mapper.bannerproduct.selectSubBannerList");
    }
}
