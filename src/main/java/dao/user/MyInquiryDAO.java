package dao.user;

import java.util.List;
import java.util.Map;

import dto.user.Inquiry;

public interface MyInquiryDAO {
	/**
     * 특정 사용자(userId)가 남긴 문의 목록 조회
     * @param userId 사용자 아이디
     * @return Inquiry 리스트
     * @throws Exception
     */
    List<Inquiry> selectByUserId(Map<String,Object> params) throws Exception;
    
    int countByUserId(String userId) throws Exception;

    Inquiry selectById(Map<String, Object> params) throws Exception;

    int updateByUser(Inquiry inquiry) throws Exception;

    int deleteByUser(Map<String, Object> params) throws Exception;
}
