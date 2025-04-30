package service.user;

import dto.user.User;

public interface NaverService {
	User naverLogin(String code) throws Exception;
}
