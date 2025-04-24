package service.order;

import java.util.List;
import dto.order.Exchange;

public interface ExchangeService {
	List<Exchange> getAllExchanges() throws Exception;

	int getTotalPages() throws Exception;
	
	List<Exchange> getExchangesByApproved(int approved) throws Exception;
	
	Exchange getExchangeDetailById(int exchangeId) throws Exception;
	
	// service.order.ExchangeService
	void approveExchange(int exchangeId) throws Exception;
	void rejectExchange(int exchangeId, String reason) throws Exception;
}