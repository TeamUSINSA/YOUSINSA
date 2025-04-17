package service.user;

import dao.user.UserDAO;
import dao.user.UserDAOImpl;
import dto.user.User;

public class UserServiceImpl implements UserService{
	
	private UserDAO userDao;
    public UserServiceImpl() {
        userDao = new UserDAOImpl();}

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
	public User login(String userId, String password) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public boolean checkDoubleId(String userId) throws Exception {
		User user = userDao.findUserByUserId(userId);
        if(user == null) return false;
        return true;
	}

}
