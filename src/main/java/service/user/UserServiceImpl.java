package service.user;

import java.util.List;

import dao.user.UserCouponDAO;
import dao.user.UserCouponDAOImpl;
import dao.user.UserDAO;
import dao.user.UserDAOImpl;
import dto.user.User;
import dto.user.UserCoupon;

public class UserServiceImpl implements UserService{
	
	private UserDAO userDao;
	private UserCouponDAO couponDAO;
	
    public UserServiceImpl() {
        userDao = new UserDAOImpl();
        couponDAO  = new UserCouponDAOImpl();
    }

	@Override
	public void join(User user) throws Exception {
		User suser = userDao.findUserByUserId(user.getUserId());
        if(suser != null) throw new Exception("아이디 중복 오류");
        userDao.insertUser(user);
	}

	@Override
	public void withdraw(User user) throws Exception {
		User wuser = userDao.findUserByUserId(user.getUserId());
		userDao.withdrawUser(wuser);
	}


	@Override
	public boolean checkDoubleId(String userId) throws Exception {
		User user = userDao.findUserByUserId(userId);
        if(user == null) return false;
        return true;
	}


    @Override
    public int getUserPoint(String userId) throws Exception {
        return userDao.findUserPoint(userId);
    }
    @Override
    public User login(User user) throws Exception {
        return userDao.findUserByLogin(user);
    }

    @Override
    public boolean isDuplicateId(String userId) throws Exception{
        return userDao.isDuplicateId(userId);
    }

	@Override
	public void insertUser(User user) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public User getUserById(String userId) throws Exception {
		return userDao.findUserByUserId(userId);
	}

	@Override
	public User getUserAddressList(String userId) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}
	

	@Override
	public String findUserId(String name, String email, String phone) throws Exception {
	    return userDao.findUserIdByInfo(name, email, phone);
	}

	 @Override
	    public User findUserForPasswordReset(String name, String userId, String email) {
	        return userDao.findUserForPasswordReset(name, userId, email);
	    }
	 
	 @Override
	 public void updateUserPassword(String userId, String newPassword) throws Exception {
	     userDao.updateUserPassword(userId, newPassword);
	 }

	 @Override
	    public List<UserCoupon> getUnusedCoupons(String userId) throws Exception {
	        return couponDAO.selectUnusedCouponsByUserId(userId);
	    }
	 
	 @Override
	    public User findUserById(String userId) throws Exception{
	        return userDao.selectUserByUserId(userId);
	    }

	 @Override
	 public List<User> findUsersByName(String name) throws Exception {
	     return userDao.findUsersByName(name);
	 }
	 @Override
	 public boolean checkPassword(String userId, String currentPassword) throws Exception {
	     return userDao.checkPassword(userId, currentPassword) > 0;
	 }
	 
	 @Override
	 public void updateFcmToken(String userId, String token) throws Exception {
		 userDao.updateFcmToken(userId, token);
	 }
}
