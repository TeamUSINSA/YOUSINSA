package dao.user;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import dto.user.UserCoupon;
import utils.MybatisSqlSessionFactory;

public class UserCouponDAOImpl implements UserCouponDAO {

	private SqlSession sqlSession;

	public UserCouponDAOImpl() {
		this.sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession(true);
	}

	public List<UserCoupon> selectUnusedCouponsByUserId(String userId) {
		return sqlSession.selectList("mapper.userCoupon.selectUnusedCouponsByUserId", userId);
	}
}
