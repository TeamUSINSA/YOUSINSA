package utils;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.annotation.WebListener;

import com.google.auth.oauth2.GoogleCredentials;
import com.google.firebase.FirebaseApp;
import com.google.firebase.FirebaseOptions;

import java.io.InputStream;

@WebListener
public class FirebaseInitializer implements ServletContextListener {

    @Override
    public void contextInitialized(ServletContextEvent sce) {
        try {
            InputStream serviceAccount = getClass().getClassLoader()
                .getResourceAsStream("firebase-admin.json");

            if (serviceAccount == null) {
                System.err.println("❌ firebase-admin.json 파일을 찾을 수 없습니다.");
                return;
            }

            FirebaseOptions options = FirebaseOptions.builder()
                    .setCredentials(GoogleCredentials.fromStream(serviceAccount))
                    .build();

            if (FirebaseApp.getApps().isEmpty()) {
                FirebaseApp.initializeApp(options);
                System.out.println("✅ Firebase 초기화 완료");
            }

        } catch (Exception e) {
            e.printStackTrace();
            System.err.println("❌ Firebase 초기화 중 오류: " + e.getMessage());
        }
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        // 필요 없음
    }
}
