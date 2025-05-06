package service.order;

import java.util.List;
import dto.order.Return;

public interface ReturnService {
    List<Return> getAllReturns() throws Exception;
    List<Return> getReturnsByApproved(int approved) throws Exception;
    int getTotalPages() throws Exception;
	void rejectReturn(int returnId, String rejectReason) throws Exception;
	void approveReturn(int returnId) throws Exception;
	
	/**
     * 반품 요청 처리 (반품 테이블 등록 + 주문상품·주문 상태 변경)
     * @param returnRequest 반품 요청 정보
     * @return 등록 건수
     * @throws Exception
     */
    int requestReturn(Return returnRequest) throws Exception;

    /**
     * 사용자별 반품 내역 조회
     * @param userId 사용자 ID
     * @return 반품 목록
     * @throws Exception
     */
    List<Return> getReturnsByUser(String userId) throws Exception;

    /**
     * 단일 반품 정보 조회
     * @param returnId 반품 ID
     * @return 반품 상세 정보
     * @throws Exception
     */
    Return getReturnById(int returnId) throws Exception;
}
