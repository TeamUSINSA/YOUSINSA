package dao.user;

import java.util.List;

import dto.order.Cancel;

public interface myCancelDAO {
	/**
     * 주문 취소 정보를 cancel 테이블에 기록
     */
    void insertCancel(Cancel cancel) throws Exception;

    /**
     * orderlist.delivery_status 를 '취소완료' 로 변경
     */
    void updateOrderToCancelled(int orderId) throws Exception;
}
