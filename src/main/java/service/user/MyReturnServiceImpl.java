package service.user;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import dao.user.MyReturnDAO;
import dao.user.MyReturnDAOImpl;
import dto.order.Return;

public class MyReturnServiceImpl implements MyReturnService{
	private MyReturnDAO returnDAO = new MyReturnDAOImpl();
	
	@Override
	public void createReturn(Return returnEntity) throws Exception {
		// 1) return 테이블에 insert
        returnDAO.insertReturn(returnEntity);
        // 2) orderitem.status 업데이트
        returnDAO.updateOrderItemToReturned(returnEntity.getOrderItemId());
		
	}

	@Override
	public List<Return> getReturns(String userId, String startDate, String endDate) throws Exception {
		Map<String,Object> params = new HashMap<>();
        params.put("userId",    userId);
        params.put("startDate", startDate);
        params.put("endDate",   endDate);
        // DAO에서 분리된 반품 리스트만 가져옴
        return returnDAO.selectReturnList(params);
	}

}
