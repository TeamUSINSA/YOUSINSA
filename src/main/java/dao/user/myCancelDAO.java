//package dao.user;
//
//import java.util.List;
//
//import dto.order.Cancel;
//
//public interface myCancelDAO {
//	/** 취소/반품 요청을 추가 */
//    void insertCancel(Cancel cancel) throws Exception;
//
//    /** 특정 사용자의 전체 취소/반품 내역 조회 */
//    List<Cancel> getCancelsByUserId(String userId) throws Exception;
//
//    /** 단일 취소/반품 내역 조회 */
//    Cancel getCancelById(int cancelId) throws Exception;
//
//    /** 주문별(또는 orderItem별)로 이미 취소 요청이 있는지 확인 */
//    int countCancelByOrderId(int orderId) throws Exception;
//}
