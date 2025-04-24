package service.user;

import java.util.List;
import java.util.Map;

import dto.user.Point;

public interface MyPointService {
	// 포인트 적립 또는 사용
    void addPoint(Point point) throws Exception;

    // 포인트 내역 조회
    List<Point> getPointsByDate(Map<String, Object> paramMap) throws Exception;

    // 총 보유 포인트 조회
    int getTotalPoint(String userId) throws Exception;
}
