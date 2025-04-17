package dao.user;

import java.util.HashMap;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import dto.user.User;
import utils.MybatisSqlSessionFactory;

public class UserDAOImpl implements UserDAO{
	private SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();

	@Override
	public void insertUser(User user) throws Exception {
		sqlSession.insert("mapper.user.insertUser",user);
        sqlSession.commit();
		
	}

	@Override
	public void updateUser(User user) throws Exception {
		sqlSession.update("mapper.member.updateUser",user);
        sqlSession.commit();
		
	}

	@Override
	public void deleteUser(User user) throws Exception {
		// TODO Auto-generated method stub
		
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



}
