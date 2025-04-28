package service.user;

import java.util.List;

import dto.user.Inquiry;

public interface InquiryService {

	List<Inquiry> getByProductId(int productId) throws Exception;

	void addInquiry(Inquiry inquiry) throws Exception;

}
