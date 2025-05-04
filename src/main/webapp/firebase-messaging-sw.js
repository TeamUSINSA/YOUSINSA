importScripts('https://www.gstatic.com/firebasejs/9.6.11/firebase-app-compat.js');
importScripts('https://www.gstatic.com/firebasejs/9.6.11/firebase-messaging-compat.js');

firebase.initializeApp({
  apiKey: "AIzaSyChh1pWhBBB1jFsI_YHR4id1PjM8htrFwU",
  authDomain: "yousinsa-c83ae.firebaseapp.com",
  projectId: "yousinsa-c83ae",
  messagingSenderId: "372484059502",
  appId: "1:372484059502:web:0d322309f20c8c7c79d17f"
});

const messaging = firebase.messaging();

messaging.onBackgroundMessage(payload => {
  console.log('📩 백그라운드 수신:', payload);

  const notificationTitle = payload.data.title;
  const notificationOptions = {
    body: payload.data.body,
    icon: '/favicon.ico',
    data: {
      url: payload.data.click_action || '/yousinsa'  // ✅ 경로를 data.url로 저장
    }
  };

  self.registration.showNotification(notificationTitle, notificationOptions);
});

// ✅ 클릭 처리: 등록된 경로로 이동
self.addEventListener('notificationclick', function(event) {
  event.notification.close();

  const data = event.notification.data || {}; // 안전하게 fallback 처리
  const urlToOpen = data.click_action || '/yousinsa'; // FCM에서 click_action으로 전달했었음

  event.waitUntil(clients.openWindow(urlToOpen));
});