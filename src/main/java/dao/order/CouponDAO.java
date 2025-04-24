package dao.order;

import java.util.List;

import java.util.Map;

import dto.order.Coupon;

public interface CouponDAO {
    void insertCoupon(Coupon coupon) throws Exception;
    int insertUserCoupon(int couponId, String userId) throws Exception;
    List<Coupon> selectAllCoupons() throws Exception;
    void deleteCouponById(int couponId) throws Exception;
    List<Coupon> selectCouponPage(Map<String, Object> params) throws Exception;
    int getCouponCount() throws Exception;
	List<Coupon> selectValidCouponsByUser(String userId) throws Exception;

	List<Coupon> selectValidCoupons() throws Exception;
}


