package dao.user;

import java.util.HashMap;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import dto.user.User;
import utils.MybatisSqlSessionFactory;

public class UserDAOImpl implements UserDAO {
	private SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();

	@Override
	public void insertUser(User user) throws Exception {
		sqlSession.insert("mapper.user.insertUser", user);
		sqlSession.commit();

	}

	@Override
<<<<<<< HEAD
	public void updateUser(User user) throws Exception {
		sqlSession.update("mapper.member.updateUser", user);
		sqlSession.commit();

	}

	@Override
	public void deleteUser(User user) throws Exception {
		// TODO Auto-generated method stub

=======
	public void updateSingleField(String userId, String column, String value) throws Exception {
		Map<String, String> params = new HashMap<>();
	    params.put("userId", userId);
	    params.put("column", column);
	    params.put("value", value);
	    sqlSession.update("mapper.user.updateSingleField", params);
	    sqlSession.commit();
	}

	@Override
	public void withdrawUser(User user) throws Exception {
		sqlSession.update("mapper.user.withdrawUser",user);
		sqlSession.commit();
		
>>>>>>> 682b3c0bc01fde93f8e6f3967534e05f9bb7cff9
	}

	@Override
	public User findUserByUserId(String userId) throws Exception {
		return sqlSession.selectOne("mapper.user.selectUser", userId);
	}

	@Override
	public User findUserAddressList(String userId) throws Exception {
		return sqlSession.selectOne("mapper.user.selectUserAddressList", userId);
	}

	@Override
	public int findUserPoint(String userId) throws Exception {
		return sqlSession.selectOne("mapper.user.selectUserPoint", userId);
	}

	@Override
	public User findUserByLogin(User user) throws Exception {
		return sqlSession.selectOne("mapper.user.loginUser", user);
	}

	@Override
	public boolean isDuplicateId(String userId) throws Exception {
		int count = sqlSession.selectOne("mapper.user.isDuplicateId", userId);
		return count > 0;
	}

}
