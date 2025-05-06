package dao.order;

import java.util.List;
import dto.order.Return;

public interface ReturnDAO {
    List<Return> selectAllReturns() throws Exception;
    List<Return> selectReturnsByApproved(int approved) throws Exception;
    int getTotalPages() throws Exception;

    // ✅ 추가: 반품 승인
    void updateApprovedStatus(int returnId, int approved) throws Exception;

    // ✅ 추가: 반품 반려 + 사유 등록
    void updateRejectedStatus(int returnId, int approved, String rejectReason) throws Exception;
    
    Return selectReturnById(int returnId) throws Exception;
	int getOrderItemIdByReturnId(int returnId) throws Exception;
}
