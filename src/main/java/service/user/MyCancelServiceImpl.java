package service.user;

import java.sql.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import dao.user.MyCancelDAO;
import dao.user.MyCancelDAOImpl;
import dto.order.Cancel;

public class MyCancelServiceImpl implements MyCancelService {
	private final MyCancelDAO cancelDAO = new MyCancelDAOImpl();

	@Override
	public void createCancel(Cancel cancel) throws Exception {
		// 1) cancel 테이블에 insert
		cancelDAO.insertCancel(cancel);
		// 2) orderlist.delivery_status 업데이트
		cancelDAO.updateOrderToCancelled(cancel.getOrderId());
	}

	@Override
	public List<Cancel> getCancels(String userId, String startDate, String endDate) throws Exception {
		Map<String, Object> params = new HashMap<>();
		params.put("userId", userId);
		params.put("startDate", startDate);
		params.put("endDate", endDate);
		// DAO에서 분리된 취소 리스트만 가져옴
		return cancelDAO.selectCancelList(params);
	}

	@Override
	public void requestCancel(int orderId, String userId, String reason) throws Exception {
		// 1) Cancel DTO 만들기
		Cancel cancel = new Cancel();
		cancel.setOrderId(orderId);
		cancel.setUserId(userId);
		cancel.setReason(reason);
		// 오늘 날짜를 java.sql.Date 로
		cancel.setCancelDate(new Date(System.currentTimeMillis()));

		// 2) DAO 호출: insert
		cancelDAO.insertCancel(cancel);
		// 3) DAO 호출: orderlist 상태 변경
		cancelDAO.updateOrderToCancelled(orderId);
	}
}
