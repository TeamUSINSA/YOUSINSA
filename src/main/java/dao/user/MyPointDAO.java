package dao.user;

import java.util.List;
import java.util.Map;

import dto.user.Point;

public interface MyPointDAO {
	void insertPoint(Point point) throws Exception;
    void updateUserTotalPoint(String userId, int point) throws Exception;
    List<Point> getPointsByDate(Map<String, Object> map) throws Exception;
    int getTotalPoint(String userId) throws Exception;
    List<Point> getPointsByUserAndDate(Map<String, Object> paramMap) throws Exception;
}
