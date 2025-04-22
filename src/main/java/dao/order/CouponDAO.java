package dao.order;

import java.util.List;

import dto.order.Coupon;

public interface CouponDAO {

	int insertUserCoupon(int couponId, String userId) throws Exception;

	List<Coupon> selectValidCouponsByUser(String userId) throws Exception;

	List<Coupon> selectValidCoupons() throws Exception;

}
