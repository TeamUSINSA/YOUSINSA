package dao.user;

import dto.user.User;

public interface UserDAO {
    void insertUser(User user) throws Exception;
    public void updateSingleField(String userId, String column, String value) throws Exception;
    void withdrawUser(User user) throws Exception;
    User findUserByUserId(String userId) throws Exception;
}
