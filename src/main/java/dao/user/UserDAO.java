package dao.user;

import java.util.List;

import dto.user.User;

public interface UserDAO {
    void insertUser(User user) throws Exception;
    public void updateSingleField(String userId, String column, String value) throws Exception;
    void withdrawUser(User user) throws Exception;
    User findUserByUserId(String userId) throws Exception;
	int findUserPoint(String userId) throws Exception;
	User findUserAddressList(String userId) throws Exception;
	User findUserByLogin(User user) throws Exception;
	boolean isDuplicateId(String userId) throws Exception;
	void updateUser(User user) throws Exception;
	String findUserIdByInfo(String name, String email, String phone) throws Exception;
	User findUserForPasswordReset(String name, String userId, String email);
	void updateUserPassword(String userId, String newPassword) throws Exception;
	User findById(String userId) throws Exception;
	User findByMemberNo(int memberNo) throws Exception;
	User selectUserByUserId(String userId) throws Exception;
	User findUserById(String userId) throws Exception;
	List<User> findUsersByName(String name) throws Exception;
}
