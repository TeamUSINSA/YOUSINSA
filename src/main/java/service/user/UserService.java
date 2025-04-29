package service.user;

import java.util.List;

import dto.user.User;
import dto.user.UserCoupon;

public interface UserService {
	void insertUser(User user) throws Exception;
    User getUserById(String userId) throws Exception;
    User getUserAddressList(String userId) throws Exception;
    int getUserPoint(String userId) throws Exception;
    User login(User user) throws Exception;
	void join(User user) throws Exception;
	boolean isDuplicateId(String userId) throws Exception;
	boolean checkDoubleId(String userId) throws Exception;
	void withdraw(User user) throws Exception;
	
	String findUserId(String name, String email, String phone) throws Exception;
	User findUserForPasswordReset(String name, String userId, String email);
	void updateUserPassword(String userId, String newPassword) throws Exception;
	List<UserCoupon> getUnusedCoupons(String userId) throws Exception;
	
	 User findUserById(String userId) throws Exception;
	 List<User> findUsersByName(String name) throws Exception;

}

