package service.user;

import dto.user.User;

public interface KakaoService {
	User kakaoLogin(String code) throws Exception;
}
