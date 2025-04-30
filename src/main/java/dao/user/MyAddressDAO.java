package dao.user;

import dto.user.User;

public interface MyAddressDAO {

	/**
     * userId로 저장된 최대 3개의 배송지 정보를 조회
     * @param userId 조회할 사용자 아이디
     * @return address1~3 필드가 채워진 User DTO
     */
    User selectAddressesByUserId(String userId) throws Exception;
    
    int updateAddress1(User user) throws Exception;

    int updateAddress2(User user) throws Exception;
   
    int updateAddress3(User user) throws Exception;

    int deleteAddress1(String userId) throws Exception;

    int deleteAddress2(String userId) throws Exception;

    int deleteAddress3(String userId) throws Exception;
}
