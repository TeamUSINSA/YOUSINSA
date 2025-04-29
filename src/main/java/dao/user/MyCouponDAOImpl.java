package dao.user;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import dto.user.UserCoupon;
import utils.MybatisSqlSessionFactory;

public class MyCouponDAOImpl implements MyCouponDAO {

	@Override
	public List<UserCoupon> selectByUser(String userId) throws Exception {
		try (SqlSession session = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			// mapper id: mapper.user.mycoupon.selectByUser
			List<UserCoupon> list = session.selectList("mapper.user.mycoupon.selectByUser", userId);
			return list;
		}
	}
}
