package service.user;

import java.util.List;

import dao.user.AlertDAO;
import dao.user.AlertDAOImpl;
import dto.user.Alert;

public class AlertServiceImpl implements AlertService {
    private AlertDAO dao = new AlertDAOImpl();

    public int countUncheckedAlerts(String userId) throws Exception {
    	     return dao.countUncheckedAlerts(userId);
    	}

	@Override
	public List<Alert> getAlertsByUser(String userId) throws Exception {
		return dao.selectByUser(userId);
	}

	@Override
	public void markAsChecked(int alertId) throws Exception {
		dao.markAsChecked(alertId);
		
	}
}
