package service.user;

import dao.user.MyCancelDAOImpl;
import dao.user.myCancelDAO;
import dto.order.Cancel;

public class MyCancelServiceImpl implements MyCancelService{
	private final myCancelDAO cancelDao = new MyCancelDAOImpl();

	@Override
	public void requestCancel(int orderId, String userId, String reason) throws Exception {
		// 1) cancel 테이블에 INSERT
        Cancel c = new Cancel();
        c.setOrderId(orderId);
        c.setUserId(userId);
        c.setReason(reason);
        cancelDao.insertCancel(c);

        // 2) orderlist.delivery_status 를 '취소완료' 로 UPDATE
        cancelDao.updateOrderToCancelled(orderId);
	}

}
