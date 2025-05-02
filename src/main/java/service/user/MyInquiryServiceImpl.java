package service.user;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import dao.user.MyInquiryDAO;
import dao.user.MyInquiryDAOImpl;
import dto.user.Inquiry;
import utils.PageInfo;

public class MyInquiryServiceImpl implements MyInquiryService{
	
	private MyInquiryDAO inquiryDao = new MyInquiryDAOImpl();
	private static final int PAGE_SIZE = 10;
    private static final int PAGE_BLOCK = 5;

	@Override
	public List<Inquiry> getInquiriesByUserId(String userId, PageInfo pageInfo) throws Exception {
		// 1) 전체 건수 조회
        int totalCount = inquiryDao.countByUserId(userId);

        // 2) 전체 페이지 수 계산
        int allPage = (int) Math.ceil(totalCount / (double) PAGE_SIZE);
        pageInfo.setAllPage(allPage);

        // 3) 화면에 보일 페이지 블록 계산
        int cur = pageInfo.getCurPage();
        int startPage = ((cur - 1) / PAGE_BLOCK) * PAGE_BLOCK + 1;
        int endPage = Math.min(startPage + PAGE_BLOCK - 1, allPage);
        pageInfo.setStartPage(startPage);
        pageInfo.setEndPage(endPage);

        // 4) offset, limit 설정
        int offset = (cur - 1) * PAGE_SIZE;
        Map<String,Object> params = new HashMap<>();
        params.put("userId", userId);
        params.put("limit", PAGE_SIZE);
        params.put("offset", offset);

        // 5) 페이징된 리스트 조회
        return inquiryDao.selectByUserId(params);
	}

	@Override
	public int countByUserId(String userId) throws Exception {
		return inquiryDao.countByUserId(userId);
	}

	@Override
	public Inquiry getInquiryById(String userId, int inquiryId) throws Exception {
		Map<String,Object> params = new HashMap<>();
        params.put("userId", userId);
        params.put("inquiryId", inquiryId);
        return inquiryDao.selectById(params);
	}

	@Override
	public void updateInquiry(Inquiry inquiry) throws Exception {
		inquiryDao.updateByUser(inquiry);
		
	}

	@Override
	public void deleteInquiry(String userId, int inquiryId) throws Exception {
		Map<String,Object> params = new HashMap<>();
        params.put("userId", userId);
        params.put("inquiryId", inquiryId);
        inquiryDao.deleteByUser(params);
	}


}
