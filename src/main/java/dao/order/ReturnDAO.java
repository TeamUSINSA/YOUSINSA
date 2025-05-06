package dao.order;

import java.util.List;
import dto.order.Return;

public interface ReturnDAO {
	List<Return> selectAllReturns() throws Exception;

	List<Return> selectReturnsByApproved(int approved) throws Exception;


    // ✅ 추가: 반품 반려 + 사유 등록
    void updateRejectedStatus(int returnId, int approved, String rejectReason) throws Exception;
    
    Return selectReturnById(int returnId) throws Exception;
	int getOrderItemIdByReturnId(int returnId) throws Exception;

	int getTotalPages() throws Exception;

	// ✅ 추가: 반품 승인
	void updateApprovedStatus(int returnId, int approved) throws Exception;

	/** 반품 신청 등록 */
	int insertReturn(Return returnRequest) throws Exception;

	/** 개별 반품 조회 */
	Return selectReturnByReturnId(int returnId) throws Exception;

	/** 사용자별 반품 내역 조회 */
	List<Return> selectReturnsByUserId(String userId) throws Exception;

	/** 반품 요청 시 orderitem 상태 변경 */
	int updateOrderItemStatus(Return returnRequest) throws Exception;

	/** 반품 요청 시 orderlist 상태 변경 */
	int updateOrderListStatus(Return returnRequest) throws Exception;

}
