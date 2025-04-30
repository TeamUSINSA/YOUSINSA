package service.user;

import dao.user.MyAddressDAO;
import dao.user.MyAddressDAOImpl;
import dto.user.User;

public class MyAddressServiceImpl implements MyAddressService {
	private MyAddressDAO myAddressDao = new MyAddressDAOImpl();

	@Override
	public User getUserAddresses(String userId) throws Exception {
		return myAddressDao.selectAddressesByUserId(userId);
	}

	@Override
	public void updateAddress(User user, int slot) throws Exception {
		switch (slot) {
		case 1:
			myAddressDao.updateAddress1(user);
			break;
		case 2:
			myAddressDao.updateAddress2(user);
			break;
		case 3:
			myAddressDao.updateAddress3(user);
			break;
		default:
			throw new IllegalArgumentException("Invalid address slot: " + slot);
		}
	}

	@Override
	public void deleteAddress(String userId, int slot) throws Exception {
		switch (slot) {
		case 1:
			myAddressDao.deleteAddress1(userId);
			break;
		case 2:
			myAddressDao.deleteAddress2(userId);
			break;
		case 3:
			myAddressDao.deleteAddress3(userId);
			break;
		default:
			throw new IllegalArgumentException("Invalid address slot: " + slot);
		}
	}
}
