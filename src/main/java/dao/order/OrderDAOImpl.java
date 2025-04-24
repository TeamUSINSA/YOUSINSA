package dao.order;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import dto.order.Coupon;
import dto.order.Order;
import dto.user.User;
import dto.user.UserCoupon;
import utils.MybatisSqlSessionFactory;

public class OrderDAOImpl implements OrderDAO {

	private SqlSession sqlSession;

	public OrderDAOImpl() {
		sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession(true); // auto commit
	}

	@Override
	public void insertOrderList(Order order) throws Exception {
		sqlSession.insert("mapper.orderproduct.insertOrderList", order);
	}

	@Override
	public void insertOrderItem(Order order) throws Exception {
		sqlSession.insert("mapper.orderproduct.insertOrderItem", order);
	}

	@Override
	public List<Order> selectOrdersByUser(String userId) throws Exception {
		return sqlSession.selectList("mapper.order.selectOrdersByUser", userId);
	}
	
	@Override
    public User selectUserById(String userId) throws Exception {
        return sqlSession.selectOne("mapper.user.selectUser", userId);
    }
	
	 @Override
	    public List<Coupon> selectUnusedCouponsByUserId(String userId) throws Exception {
	        return sqlSession.selectList(
	            "mapper.userCoupon.selectUnusedCouponsByUserId",
	            userId
	        );
	    }

	    @Override
	    public void markCouponUsed(UserCoupon uc) throws Exception {
	        sqlSession.update(
	            "mapper.userCoupon.markCouponUsed",
	            uc
	        );
	    }

}
