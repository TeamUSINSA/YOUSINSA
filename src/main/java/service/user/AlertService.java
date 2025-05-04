package service.user;

import java.util.List;

import dto.user.Alert;

public interface AlertService {
	int countUncheckedAlerts(String userId) throws Exception;
	/**
     * 특정 유저가 받은 모든 알림을 반환한다.
     *
     * @param userId 알림을 조회할 대상 유저의 ID
     * @return Alert 객체 리스트
     * @throws Exception 조회 중 오류 발생 시
     */
    List<Alert> getAlertsByUser(String userId) throws Exception;
    
    void markAsChecked(int alertId) throws Exception;
	int insertAlert(Alert alert) throws Exception;
	List<Alert> selectUncheckedAlertsByUser(String userId) throws Exception;
}
