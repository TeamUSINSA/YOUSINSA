package service.user;

import dto.user.User;

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

}

