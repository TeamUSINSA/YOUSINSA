package service.user;

import dto.user.User;

public interface MyAddressService {
	User getUserAddresses(String userId) throws Exception;
	
	void updateAddress(User user, int slot) throws Exception;
	
	void deleteAddress(String userId, int slot) throws Exception;
}
