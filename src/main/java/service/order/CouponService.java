package service.order;

import java.time.LocalDate;
import java.util.List;

import dto.order.Coupon;

public interface CouponService {
    /** 전체 유효 쿠폰 조회 */
    List<Coupon> selectValidCoupons() throws Exception;
    /** 사용자별 아직 다운받지 않은 유효 쿠폰 조회 */
    List<Coupon> selectValidCouponsByUser(String userId) throws Exception;
    /** 사용자 쿠폰 다운로드 처리 */
    
	void markCouponUsed(String userId, int couponId) throws Exception;
	  
    Coupon getCouponById(int couponId) throws Exception;
    void downloadCoupon(int couponId, String userId,
                        LocalDate issueDate, LocalDate expireDate) throws Exception;
	void expireUserCoupons(String userId) throws Exception;
}