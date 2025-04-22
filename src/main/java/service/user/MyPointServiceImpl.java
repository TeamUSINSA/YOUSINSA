package service.user;

import java.sql.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import dao.user.MyPointDAO;
import dao.user.MyPointDAOImpl;
import dto.user.Point;

public class MyPointServiceImpl implements MyPointService {

	private MyPointDAO pointDAO = new MyPointDAOImpl();

	 @Override
	    public void addPoint(Point point) throws Exception {
	        // 1. 포인트 적립 또는 사용 이력 INSERT
	        pointDAO.insertPoint(point);

	        // 2. user 테이블의 총 보유 포인트 UPDATE
	        pointDAO.updateUserTotalPoint(point.getUserId(), point.getPoint());
	    }

	    @Override
	    public List<Point> getPointsByDate(Map<String, Object> paramMap) throws Exception {
	        return pointDAO.getPointsByUserAndDate(paramMap);
	    }

	    @Override
	    public int getTotalPoint(String userId) throws Exception {
	        return pointDAO.getTotalPoint(userId);
	    }
}
