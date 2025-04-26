package dao.user;

import java.util.List;
import java.util.Map;

import dto.user.CancelReturn;

public interface MyCancelReturnDAO {
	/**
     * 완료된 취소·반품 내역을 조회합니다.
     * @param params userId, startDate(String yyyy-MM-dd), endDate(String yyyy-MM-dd)
     */
    List<CancelReturn> selectCancelReturnList(Map<String,Object> params) throws Exception;
}
