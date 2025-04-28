package dao.user;

import dto.user.Point;

public interface PointDAO {

	/**
	 * 포인트 히스토리 기록 → user.total_point 업데이트
	 * @param p Point.point 에는 (음수=사용, 양수=적립) 값
	 */
	void savePoint(Point p) throws Exception;

}
