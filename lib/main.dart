import 'package:booking_tour_flutter/app.dart';
import 'package:booking_tour_flutter/app/dependency_injection/configure_injectable.dart';
import 'package:booking_tour_flutter/services/firebase_notification.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebase_messaging/firebase_messaging.dart';


@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  if (kDebugMode) print("Background: ${message.notification?.title}");
  
}

void main() async {
  // Khởi tạo binding cho firebase
  WidgetsFlutterBinding.ensureInitialized();

  configureInjectable();

  // init firebase
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  await FirebaseNotification.initNotifications();
  await FirebaseNotification.initFCM();
  

  // Đăng ký background handler (khi app đóng/background)
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  runApp(const MyApp());
}




