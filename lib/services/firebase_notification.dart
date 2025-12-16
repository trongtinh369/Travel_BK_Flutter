import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

class FirebaseNotification {
  FirebaseNotification._();

   static Future<void> initFCM() async {
    final messaging = FirebaseMessaging.instance;

    await messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    // String? token = await messaging.getToken();
 

    FirebaseMessaging.onMessage.listen((message) {
      showNotification(
        message.notification?.title ?? 'Thông báo',
        message.notification?.body ?? '',
      );
    });
  }

  static Future<void> showNotification(String title, String body) async {
    await flutterLocalNotificationsPlugin.show(
      DateTime.now().millisecond,
      title,
      body,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'high_importance_channel',
          'Default',
          importance: Importance.high,
        ),
      ),
    );
  }

  static Future<void> initNotifications() async {
    await flutterLocalNotificationsPlugin.initialize(
      const InitializationSettings(
        android: AndroidInitializationSettings('@mipmap/ic_launcher'),
      ),
    );
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.createNotificationChannel(
          const AndroidNotificationChannel(
            'high_importance_channel',
            'Default',
            importance: Importance.high,
          ),
        );
  }
}
