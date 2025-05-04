package service.user;

import java.util.List;

import dao.inquiry.InquiryDAO;
import dao.inquiry.InquiryDAOImpl;
import dto.user.Inquiry;

public class InquiryServiceImpl implements InquiryService {
    private InquiryDAO inquiryDAO = new InquiryDAOImpl();

    @Override
    public List<Inquiry> getByProductId(int productId) throws Exception {
        return inquiryDAO.selectByProductId(productId);
    }

    @Override
    public void addInquiry(Inquiry inquiry) throws Exception {
        inquiryDAO.insertInquiry(inquiry);
    }
    
    @Override
    public String getUserIdByInquiryId(int inquiryId) throws Exception {
        return inquiryDAO.getUserIdByInquiryId(inquiryId);
    }
}
