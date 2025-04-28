package service.user;

import dao.user.AlertDAO;
import dao.user.AlertDAOImpl;

public class AlertServiceImpl implements AlertService {
    private AlertDAO dao = new AlertDAOImpl();

    public int countUncheckedAlerts(String userId) throws Exception {
    	     return dao.countUncheckedAlerts(userId);
    	}
}
