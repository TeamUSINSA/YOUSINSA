package dao.order;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import dto.order.Coupon;
import utils.MybatisSqlSessionFactory;

public class CouponDAOImpl implements CouponDAO {

	@Override
	public void insertCoupon(Coupon coupon) throws Exception {
		try (SqlSession session = utils.MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			session.insert("mapper.coupon.insertCoupon", coupon);
			session.commit();
		}
	}

	@Override
	public List<Coupon> selectAllCoupons() throws Exception {
		try (SqlSession session = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return session.selectList("mapper.coupon.selectAllCoupons");
		}
	}

	@Override
	public void deleteCouponById(int couponId) throws Exception {
		try (SqlSession session = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			session.delete("mapper.coupon.deleteCouponById", couponId);
			session.commit();
		}
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
}