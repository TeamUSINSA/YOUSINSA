package service.user;

import java.util.List;

import dto.user.RestockRequest;

public interface MyRestockRequestService {
	void requestRestock(RestockRequest req) throws Exception;
    List<RestockRequest> getMyRestockRequests(String userId) throws Exception;
    void cancelRestockRequest(int requestId) throws Exception;
}
