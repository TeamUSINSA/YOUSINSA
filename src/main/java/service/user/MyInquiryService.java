package service.user;

import java.util.List;

import dto.user.Inquiry;
import utils.PageInfo;

public interface MyInquiryService {
	/**
     * 로그인 사용자(userId)의 문의 목록 조회
     * @param userId 사용자 아이디
     * @return Inquiry 객체 리스트
     * @throws Exception
     */
    List<Inquiry> getInquiriesByUserId(String userId, PageInfo pageInfo) throws Exception;
    
    int countByUserId(String userId) throws Exception;

    Inquiry getInquiryById(String userId, int inquiryId) throws Exception;

    void updateInquiry(Inquiry inquiry) throws Exception;

    void deleteInquiry(String userId, int inquiryId) throws Exception;
}
