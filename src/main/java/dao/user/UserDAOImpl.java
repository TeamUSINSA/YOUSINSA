package dao.user;

import java.util.HashMap;
import java.util.List;
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


	public void updateUser(User user) throws Exception {
		sqlSession.update("mapper.user.updateUser", user);
		sqlSession.commit();
		}

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
	@Override
	public String findUserIdByInfo(String name, String email, String phone) throws Exception {
	    Map<String, String> map = new HashMap<>();
	    map.put("name", name);
	    map.put("email", email);
	    map.put("phone", phone);

	    return sqlSession.selectOne("mapper.user.findUserId", map);
	}
	
	@Override
	public User findUserForPasswordReset(String name, String userId, String email) {
	    Map<String, String> param = new HashMap<>();
	    param.put("name", name);
	    param.put("userId", userId);
	    param.put("email", email);

	    return sqlSession.selectOne("mapper.user.findUserForPasswordReset", param);
	}
	
	@Override
	public void updateUserPassword(String userId, String newPassword) throws Exception {
	    Map<String, String> param = new HashMap<>();
	    param.put("userId", userId);
	    param.put("newPassword", newPassword);

	    sqlSession.update("mapper.user.updateUserPassword", param);
	    sqlSession.commit();
	}
	
	 @Override
	    public User findById(String userId) throws Exception {
	        return sqlSession.selectOne("mapper.user.findById", userId);
	    }

	    @Override
	    public User findByMemberNo(int memberNo) throws Exception {
	        return sqlSession.selectOne("mapper.user.findByMemberNo", memberNo);
	    }


		@Override
		public User selectUserByUserId(String userId) throws Exception {
			// TODO Auto-generated method stub
			 return sqlSession.selectOne("mapper.user.selectUserByUserId", userId);
		}
		
		@Override
		public User findUserById(String userId) throws Exception {
		    return sqlSession.selectOne("mapper.user.findById", userId);
		}

		@Override
		public List<User> findUsersByName(String name) throws Exception {
		    return sqlSession.selectList("mapper.user.findByName", name);
		}
		
		@Override
		public void insertKakaoUser(User user) throws Exception {
		    sqlSession.insert("mapper.user.insertKakaoUser", user);
		    sqlSession.commit();
		}
		@Override
		public int checkPassword(String userId, String currentPassword) throws Exception {
		    Map<String, String> params = new HashMap<>();
		    params.put("userId", userId);
		    params.put("currentPassword", currentPassword);
		    return sqlSession.selectOne("mapper.user.checkPassword", params);
		}
		
		@Override
		public void updateFcmToken(String userId, String token) throws Exception {
		        Map<String, Object> params = new HashMap<>();
		        params.put("userId", userId);
		        params.put("token", token);
		        sqlSession.update("mapper.user.updateFcmToken", params);
		        sqlSession.commit();
		}
	
}
