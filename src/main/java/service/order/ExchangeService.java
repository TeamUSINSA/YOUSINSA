package service.order;

import java.util.List;
import java.util.Map;

import dto.order.Exchange;
import dto.order.OrderItem;
import dto.user.User;
import service.user.UserServiceImpl;

public interface ExchangeService {
	List<Exchange> getAllExchanges() throws Exception;

	int getTotalPages() throws Exception;
	
	List<Exchange> getExchangesByApproved(Map<String, Object> param) throws Exception;
	
	Exchange getExchangeDetailById(int exchangeId) throws Exception;
	
	// service.order.ExchangeService
	void approveExchange(int exchangeId) throws Exception;
	void rejectExchange(int exchangeId, String reason) throws Exception;
	
//	마이페이지
	/** 배송완료된 주문아이템 목록 조회 */
    List<OrderItem> getDeliveredItems(String userId, int orderId) throws Exception;

    /** 교환 신청 (exchange 테이블 insert + orderitem 상태 변경) */
    void applyExchange(Exchange exchange) throws Exception;
    
    
    
}