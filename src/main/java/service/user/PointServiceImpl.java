package service.user;

import dao.user.PointDAO;
import dao.user.PointDAOImpl;
import dto.user.Point;

public class PointServiceImpl implements PointService {

	private PointDAO pointDAO = new PointDAOImpl();

	@Override
	public void savePoint(Point p) throws Exception {
		pointDAO.savePoint(p);
	}
}
