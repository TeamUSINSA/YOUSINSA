package dao.order;

import java.util.List;

import java.util.Map;

import dto.order.Coupon;
import dto.user.UserCoupon;

public interface CouponDAO {
    void insertCoupon(Coupon coupon) throws Exception;
    List<Coupon> selectAllCoupons() throws Exception;
    void deleteCouponById(int couponId) throws Exception;
    List<Coupon> selectCouponPage(Map<String, Object> params) throws Exception;
    int getCouponCount() throws Exception;
	List<Coupon> selectValidCouponsByUser(String userId) throws Exception;

	List<Coupon> selectValidCoupons() throws Exception;
	
	void updateUserCouponUsed(UserCoupon uc) throws Exception;
	int insertUserCoupon(Map<String,Object> params) throws Exception;
	Coupon selectCouponById(int couponId) throws Exception;
	int expireCouponsByUser(String userId) throws Exception;
	List<Coupon> selectValidCouponsByType(String type) throws Exception;
	int countUserCoupon(String userId, int couponId) throws Exception;

}


