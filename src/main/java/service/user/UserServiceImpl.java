package service.user;

import dao.user.UserDAO;
import dao.user.UserDAOImpl;
import dto.user.User;
import service.user.UserService;


public class UserServiceImpl implements UserService {

    private UserDAO userDao;

    public UserServiceImpl() {
        this.userDao = new UserDAOImpl();
    }

    @Override
    public void insertUser(User user) throws Exception {
        userDao.insertUser(user);
    }

    @Override
    public User getUserById(String userId) throws Exception {
        return userDao.findUserByUserId(userId);
    }

    @Override
    public User getUserAddressList(String userId) throws Exception {
        return userDao.findUserAddressList(userId);
    }

    @Override
    public int getUserPoint(String userId) throws Exception {
        return userDao.findUserPoint(userId);
    }
    @Override
    public User login(String userId, String password) throws Exception {
        return userDao.findUserByLogin(userId, password);
    }
}
