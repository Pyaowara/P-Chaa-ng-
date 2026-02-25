import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:pchaa_flutter/services/app_services.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  debugPrint('[FCM] Background message: ${message.messageId}');
}

class NotificationService {
  static final NotificationService _instance = NotificationService._();
  factory NotificationService() => _instance;
  NotificationService._();

  final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _localNotifications =
      FlutterLocalNotificationsPlugin();
  String? _fcmToken;

  String? get fcmToken => _fcmToken;

  Future<void> initialize() async {
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    final settings = await _messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );
    debugPrint('[FCM] Permission status: ${settings.authorizationStatus}');

    const androidSettings = AndroidInitializationSettings(
      '@mipmap/ic_launcher',
    );
    const initSettings = InitializationSettings(android: androidSettings);
    await _localNotifications.initialize(initSettings);

    const channel = AndroidNotificationChannel(
      'login_notifications',
      'Login Notifications',
      description: 'แจ้งเตือนเมื่อผู้ใช้เข้าสู่ระบบ',
      importance: Importance.high,
    );
    await _localNotifications
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.createNotificationChannel(channel);

    _fcmToken = await _messaging.getToken();
    debugPrint('[FCM] Token: $_fcmToken');

    _messaging.onTokenRefresh.listen((newToken) {
      _fcmToken = newToken;
      debugPrint('[FCM] Token refreshed: $newToken');
      _updateTokenOnServer(newToken);
    });

    // Show notification even in foreground
    FirebaseMessaging.onMessage.listen(_handleForegroundMessage);

    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      debugPrint('[FCM] Notification tapped: ${message.data}');
    });
  }

  void _handleForegroundMessage(RemoteMessage message) {
    debugPrint('[FCM] Foreground message: ${message.notification?.title}');

    final notification = message.notification;
    if (notification == null) return;

    _localNotifications.show(
      notification.hashCode,
      notification.title,
      notification.body,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'login_notifications',
          'Login Notifications',
          channelDescription: 'แจ้งเตือนเมื่อผู้ใช้เข้าสู่ระบบ',
          importance: Importance.high,
          priority: Priority.high,
          icon: '@mipmap/ic_launcher',
        ),
      ),
    );
  }

  Future<void> registerTokenWithServer() async {
    if (_fcmToken == null) {
      debugPrint('[FCM] No token to register');
      return;
    }
    try {
      await client.notification.registerToken(_fcmToken!);
      debugPrint('[FCM] Token registered with server');
    } catch (e) {
      debugPrint('[FCM] Failed to register token: $e');
    }
  }

  Future<void> removeTokenFromServer() async {
    if (_fcmToken == null) return;
    try {
      await client.notification.removeToken(_fcmToken!);
      debugPrint('[FCM] Token removed from server');
    } catch (e) {
      debugPrint('[FCM] Failed to remove token: $e');
    }
  }

  Future<void> _updateTokenOnServer(String token) async {
    try {
      await client.notification.registerToken(token);
      debugPrint('[FCM] Refreshed token registered with server');
    } catch (e) {
      debugPrint('[FCM] Failed to update refreshed token: $e');
    }
  }
}
