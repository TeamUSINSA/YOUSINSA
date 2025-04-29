package service.user;

import java.util.List;

import dao.user.MyRestockRequestDAO;
import dao.user.MyRestockRequestDAOImpl;
import dto.user.RestockRequest;

public class MyRestockRequestServiceImpl implements MyRestockRequestService{
	private MyRestockRequestDAO restockrequestDao = new MyRestockRequestDAOImpl();
	
	@Override
	public void requestRestock(RestockRequest req) throws Exception {
		restockrequestDao.insert(req);
		
	}

	@Override
	public List<RestockRequest> getMyRestockRequests(String userId) throws Exception {
		return restockrequestDao.selectByUser(userId);
	}

	@Override
	public void cancelRestockRequest(int requestId) throws Exception {
		restockrequestDao.delete(requestId);
		
	}

}
