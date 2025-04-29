package dao.user;

import java.util.List;

import dto.user.UserCoupon;

public interface MyCouponDAO {
	/**
     * 특정 유저가 보유한 쿠폰 목록을 조회합니다.
     * 
     * @param userId 로그인된 유저의 ID
     * @return UserCoupon 리스트
     * @throws Exception DB 조회 중 예외 발생 시
     */
    List<UserCoupon> selectByUser(String userId) throws Exception;
}
