package service.user;

import java.util.List;

import dto.order.Cancel;

public interface MyCancelService {
	/** 주문 전체 취소(테이블 insert + 상태 변경) */
    void createCancel(Cancel cancel) throws Exception;

    /** 특정 기간 동안의 취소 내역 조회 */
    List<Cancel> getCancels(String userId, String startDate, String endDate) throws Exception;
    
    /** 신규 ①—주문 취소 요청: cancel 테이블에 insert + orderlist 상태 변경 */
    void requestCancel(int orderId, String userId, String reason) throws Exception;
}
