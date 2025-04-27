package service.user;

public interface MyCancelService {
	/**
     * 주문 전체 취소 요청 처리
     *  1) cancel 테이블에 INSERT
     *  2) orderlist.delivery_status 를 '취소완료' 로 UPDATE
     *
     * @param orderId   취소할 주문 ID
     * @param userId    요청 사용자 ID
     * @param reason    취소 사유
     * @throws Exception
     */
    void requestCancel(int orderId, String userId, String reason) throws Exception;
}
