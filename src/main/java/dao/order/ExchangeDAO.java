package dao.order;

import java.util.List;
import java.util.Map;

import dto.order.Exchange;
import dto.order.OrderItem;

public interface ExchangeDAO {
	List<Exchange> selectAllExchanges() throws Exception;

	int getTotalPages() throws Exception;
	
	List<Exchange> selectExchangesByApproved(Map<String, Object> param) throws Exception;
	
	Exchange selectExchangeById(int exchangeId) throws Exception;
	
	// 대신 아래처럼 구체적인 메서드 2개로 나누는 걸 추천:
	void approveExchange(int exchangeId) throws Exception;
	void rejectExchange(int exchangeId, String reason) throws Exception;
	int getOrderItemIdByExchangeId(int exchangeId) throws Exception;

	
	/** 배송완료된 주문 아이템(교환 신청 대상) 조회 */
    List<OrderItem> selectDeliveredItemsByOrder(String userId, int orderId) throws Exception;

    /** 교환 신청 저장 */
    void insertExchange(Exchange exchange) throws Exception;
    
    /** 교환신청 후 주문아이템 상태 변경 */
    void updateOrderItemToCancelPending(int orderItemId) throws Exception;


}