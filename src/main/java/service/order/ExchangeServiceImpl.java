package service.order;

import java.util.List;
import java.util.Map;

import dao.order.ExchangeDAO;
import dao.order.ExchangeDAOImpl;
import dao.order.OrderItemDAO;
import dao.order.OrderItemDAOImpl;
import dto.order.Exchange;

public class ExchangeServiceImpl implements ExchangeService {

	private ExchangeDAO exchangeDAO;
	private OrderItemDAO orderItemDAO = new OrderItemDAOImpl();

	public ExchangeServiceImpl() {
		this.exchangeDAO = new ExchangeDAOImpl();
	}

	@Override
	public List<Exchange> getAllExchanges() throws Exception {
		return exchangeDAO.selectAllExchanges();
	}

	@Override
	public int getTotalPages() throws Exception {
		return exchangeDAO.getTotalPages();
	}

	@Override
	public List<Exchange> getExchangesByApproved(Map<String, Object> param) throws Exception {
	    return exchangeDAO.selectExchangesByApproved(param);
	}
	
	@Override
	public Exchange getExchangeDetailById(int exchangeId) throws Exception {
	    return exchangeDAO.selectExchangeById(exchangeId);
	}
	
	@Override
	public void approveExchange(int exchangeId) throws Exception {
	    exchangeDAO.approveExchange(exchangeId);
	    
	    int orderItemId = exchangeDAO.getOrderItemIdByExchangeId(exchangeId);
	    orderItemDAO.updateOrderItemStatus(orderItemId, "교환승인");
	}

	@Override
	public void rejectExchange(int exchangeId, String reason) throws Exception {
	    exchangeDAO.rejectExchange(exchangeId, reason);
	    
	    int orderItemId = exchangeDAO.getOrderItemIdByExchangeId(exchangeId);
	    orderItemDAO.updateOrderItemStatus(orderItemId, "교환반려");
	}
}