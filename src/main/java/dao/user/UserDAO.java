package dao.user;

import dto.user.User;

public interface UserDAO {
    void insertUser(User user) throws Exception;
    void updateUser(User user) throws Exception;
    void deleteUser(User user) throws Exception;
    User findUserByUserId(String userId) throws Exception;
	int findUserPoint(String userId) throws Exception;
	User findUserAddressList(String userId) throws Exception;
	User findUserByLogin(User user) throws Exception;
	boolean isDuplicateId(String userId) throws Exception;
}
