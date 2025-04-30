package service.user;

import java.util.List;

import dao.user.MyCouponDAO;
import dao.user.MyCouponDAOImpl;
import dto.user.UserCoupon;

public class MyCouponServiceImpl implements MyCouponService {
	private MyCouponDAO myCouponDao = new MyCouponDAOImpl();

	@Override
	public List<UserCoupon> getMyCoupons(String userId) throws Exception {
		// DAO 에서 userId 기준으로 쿠폰 목록 조회
		return myCouponDao.selectByUser(userId);
	}
}
