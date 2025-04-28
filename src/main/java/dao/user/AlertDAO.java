package dao.user;

public interface AlertDAO {
	int countUncheckedAlerts(String userId) throws Exception;
}
