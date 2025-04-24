package dao.user;

import java.util.List;

import dto.user.UserCoupon;

public interface UserCouponDAO {

	List<UserCoupon> selectUnusedCouponsByUserId(String userId) throws Exception;

}
