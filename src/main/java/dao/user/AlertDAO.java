package dao.user;

import java.util.List;

import dto.user.Alert;

public interface AlertDAO {
	int countUncheckedAlerts(String userId) throws Exception;
	
	List<Alert> selectByUser(String userId) throws Exception;
	
	void markAsChecked(int alertId) throws Exception;

	int insertAlert(Alert alert) throws Exception;

	List<Alert> selectUncheckedAlertsByUser(String userId) throws Exception;
}
