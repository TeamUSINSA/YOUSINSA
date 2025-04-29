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
    public List<BannerProduct> selectMainBannerList() throws Exception {
        return sqlSession.selectList("mapper.bannerproduct.selectMainBannerList");
    }

    @Override
    public List<BannerProduct> selectSubBannerList() throws Exception {
        return sqlSession.selectList("mapper.bannerproduct.selectSubBannerList");
    }

    @Override
    public List<BannerProduct> selectAllBanners() throws Exception {
        return sqlSession.selectList("mapper.bannerproduct.selectAllBannerList");  // 쿼리 추가
    }

    @Override
    public void insertBanner(BannerProduct banner) throws Exception {
        sqlSession.insert("mapper.bannerproduct.insertBanner", banner);
        sqlSession.commit();
    }

    @Override
    public void deleteBanner(int id) throws Exception {
        sqlSession.delete("mapper.bannerproduct.deleteBanner", id);
        sqlSession.commit(); // 꼭 커밋!
    }

    @Override
    public BannerProduct findBannerById(int id) throws Exception {
        return sqlSession.selectOne("mapper.bannerproduct.findBannerById", id);
    }
}
