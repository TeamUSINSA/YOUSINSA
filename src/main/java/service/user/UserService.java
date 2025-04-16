package service.user;

import dto.user.User;

public interface UserService {
	void join(User user) throws Exception;
    void withdraw(User user) throws Exception;
    User login(String userId,String password) throws Exception;
    boolean checkDoubleId(String userId) throws Exception;
}
