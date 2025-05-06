package dao.user;

import java.util.List;
import java.util.Map;

import dto.order.Cancel;

public interface MyCancelDAO {
	/**
     * 주문 취소 정보를 cancel 테이블에 기록
     */
    void insertCancel(Cancel cancel) throws Exception;

    /**
     * orderlist.delivery_status 를 '취소완료' 로 변경
     */
    void updateOrderToCancelled(int orderId) throws Exception;
    
    /**
    +    * 특정 기간 동안의 취소 내역 조회
    +    * @param params "userId", "startDate", "endDate"를 키로 갖는 Map
    +    */
    List<Cancel> selectCancelList(Map<String,Object> params) throws Exception;
    // 단일 취소 상세 조회
    Cancel selectCancelById(int cancelId) throws Exception;
}
