package service.user;

import dto.user.User;

public interface UserService {
    void insertUser(User user) throws Exception;
    User getUserById(String userId) throws Exception;
    User getUserAddressList(String userId) throws Exception;
    int getUserPoint(String userId) throws Exception;
    User login(String userId, String password) throws Exception;
}

