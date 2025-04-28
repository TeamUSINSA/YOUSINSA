package service.user;

import java.util.List;

import dto.order.Return;

public interface MyReturnService {
	/** 개별 상품 반품(테이블 insert + 상태 변경) */
    void createReturn(Return returnEntity) throws Exception;

    /** 특정 기간 동안의 반품 내역 조회 */
    List<Return> getReturns(String userId, String startDate, String endDate) throws Exception;
}
