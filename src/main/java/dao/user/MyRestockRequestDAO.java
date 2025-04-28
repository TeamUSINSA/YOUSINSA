package dao.user;

import java.util.List;

import dto.user.RestockRequest;

public interface MyRestockRequestDAO {
	int insert(RestockRequest req) throws Exception;
    List<RestockRequest> selectByUser(String userId) throws Exception;
    int delete(int requestId) throws Exception;
}
