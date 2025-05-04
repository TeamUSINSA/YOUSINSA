package utils;

import com.google.firebase.messaging.FirebaseMessaging;
import com.google.firebase.messaging.Message;

public class FCMService {

    public static void sendNotification(String title, String body, String targetToken) throws Exception {
    	Message message = Message.builder()
    		    .setToken(targetToken)
    		    .putData("title", title)
    		    .putData("body", body)
    		    .putData("click_action", "/yousinsa/myAlarm")
    		    .build();

        System.out.println("📬 FCM 메시지 생성 완료");
        System.out.println("📤 전송 시작...");
        String response = FirebaseMessaging.getInstance().send(message);
        System.out.println("✅ FCM 전송 성공: " + response);
    }
}
