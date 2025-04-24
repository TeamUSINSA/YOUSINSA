package dao.order;

import java.util.List;
import dto.order.Exchange;

public interface ExchangeDAO {
	List<Exchange> selectAllExchanges() throws Exception;

	int getTotalPages() throws Exception;
	
	List<Exchange> selectExchangesByApproved(int approved) throws Exception;
	
	Exchange selectExchangeById(int exchangeId) throws Exception;
	
	// 대신 아래처럼 구체적인 메서드 2개로 나누는 걸 추천:
	void approveExchange(int exchangeId) throws Exception;
	void rejectExchange(int exchangeId, String reason) throws Exception;
}