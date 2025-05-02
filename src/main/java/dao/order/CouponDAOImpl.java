package dao.order;



import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import dto.order.Coupon;
import dto.user.UserCoupon;
import utils.MybatisSqlSessionFactory;

public class CouponDAOImpl implements CouponDAO {

	private SqlSession sqlSession;
	
	public CouponDAOImpl() {
		sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession(true); // auto commit
	}
	
	@Override
	public void insertCoupon(Coupon coupon) throws Exception {
		sqlSession.insert("mapper.coupon.insertCoupon", coupon);
		sqlSession.commit();
	}

	@Override
	public List<Coupon> selectAllCoupons() throws Exception {
		return sqlSession.selectList("mapper.coupon.selectAllCoupons");
	}
	    
	    @Override
	    public void updateUserCouponUsed(UserCoupon uc) throws Exception {
	        sqlSession.update("mapper.userCoupon.updateUserCouponUsed", uc);
	    }

	@Override
	public void deleteCouponById(int couponId) throws Exception {
		sqlSession.delete("mapper.coupon.deleteCouponById", couponId);
		sqlSession.commit();
	}


	@Override
	public List<Coupon> selectCouponPage(Map<String, Object> params) throws Exception {
		try (SqlSession session = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return session.selectList("mapper.coupon.selectCouponPage", params);
		}
	}

	@Override
	public int getCouponCount() throws Exception {
		try (SqlSession session = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return session.selectOne("mapper.coupon.getCouponCount");
		}
	}
	
	@Override
    public List<Coupon> selectValidCoupons() throws Exception {
        // active=1, type='normal', 오늘 날짜 사이의 쿠폰 전체 조회
        return sqlSession.selectList(
            "mapper.coupon.selectValidManualCoupons"
        );
    }

    @Override
    public List<Coupon> selectValidCouponsByUser(String userId) throws Exception {
        // 사용자가 아직 다운받지 않은 유효 쿠폰 조회
        return sqlSession.selectList(
            "mapper.coupon.selectValidManualCouponsByUser",
            userId
        );
    }

    @Override
    public Coupon selectCouponById(int couponId) throws Exception {
        return sqlSession.selectOne("mapper.coupon.selectCouponById", couponId);
    }

    @Override
    public int insertUserCoupon(Map<String, Object> params) throws Exception {
        return sqlSession.insert("mapper.coupon.insertUserCoupon", params);
    }

}

