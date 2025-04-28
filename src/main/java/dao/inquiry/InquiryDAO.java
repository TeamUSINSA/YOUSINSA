package dao.inquiry;

import java.util.List;
import dto.user.Inquiry;

public interface InquiryDAO {
    List<Inquiry> selectAll() throws Exception;

    Inquiry selectById(int inquiryId) throws Exception;

    void insertInquiry(Inquiry inquiry) throws Exception;

    void updateAnswer(int inquiryId, String answer, String status) throws Exception;
    
    List<Inquiry> selectByStatus(String status) throws Exception; // 👈 이거 추가
 
}
