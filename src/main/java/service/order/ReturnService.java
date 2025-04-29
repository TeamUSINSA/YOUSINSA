package service.order;

import java.util.List;
import dto.order.Return;

public interface ReturnService {
    List<Return> getAllReturns() throws Exception;
    List<Return> getReturnsByApproved(int approved) throws Exception;
    int getTotalPages() throws Exception;
	void rejectReturn(int returnId, String rejectReason) throws Exception;
	void approveReturn(int returnId) throws Exception;
}
