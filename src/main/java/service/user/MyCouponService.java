package service.user;

import java.util.List;

import dto.user.UserCoupon;

public interface MyCouponService {
	/**
     * 특정 유저가 가진 쿠폰 목록을 반환한다.
     * 
     * @param userId 로그인한 유저의 ID
     * @return UserCoupon 객체 리스트
     * @throws Exception 조회 중 예외 발생 시
     */
    List<UserCoupon> getMyCoupons(String userId) throws Exception;
}
