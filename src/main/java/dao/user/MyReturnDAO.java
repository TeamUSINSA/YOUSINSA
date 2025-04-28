package dao.user;

import java.util.List;
import java.util.Map;

import dto.order.Return;

public interface MyReturnDAO {
	/**
     * 반품 정보를 return 테이블에 기록
     */
    void insertReturn(Return returnEntity) throws Exception;

    /**
     * orderitem.status 를 '반품완료' 로 변경
     */
    void updateOrderItemToReturned(int orderItemId) throws Exception;

    /**
     * 특정 기간 동안의 반품 내역 조회
     * @param params "userId", "startDate", "endDate" 키를 갖는 Map
     */
    List<Return> selectReturnList(Map<String,Object> params) throws Exception;
}
