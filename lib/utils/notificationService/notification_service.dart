import 'dart:developer';
import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:device_info_plus/device_info_plus.dart';

class FirebaseNotificationService extends GetxService {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  String? _fcmToken;

  String? get fcmToken => _fcmToken;
// Future<void> checkBatteryOptimization() async {
//   DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
//   AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;

//   if (androidInfo.version.sdkInt >= 31) { // Android 12+
//     await Permission.ignoreBatteryOptimizations.request();
//   }
// }
  Future<FirebaseNotificationService> initialize() async {
    NotificationSettings settings =
        await _firebaseMessaging.requestPermission();
    if (settings.authorizationStatus == AuthorizationStatus.denied) return this;

    _fcmToken = await _firebaseMessaging.getToken();
    log("FCM Token: $_fcmToken");

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      _showNotification(message);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      _handleMessage(message);
    });

    _firebaseMessaging.getInitialMessage().then((RemoteMessage? message) {
      if (message != null) {
        _handleMessage(message);
      }
    });

    const AndroidInitializationSettings androidInitSettings =
        AndroidInitializationSettings('ic_stat_notification');
    //@drawable/ic_stat_notification
    final InitializationSettings initSettings =
        InitializationSettings(android: androidInitSettings);
    await _flutterLocalNotificationsPlugin.initialize(initSettings);

    return this;
  }

  Future<String?> getFcmToken() async {
    _fcmToken ??= await _firebaseMessaging.getToken();
    return _fcmToken;
  }
  Future<String> _getNotificationIcon() async {
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
  
  return androidInfo.version.sdkInt >= 34 
      ? 'ic_stat_notification' 
      : 'launcher_icon';   
}
  void _showNotification(RemoteMessage message) async {
    print("Notification Message: ${message.toMap()}");
   String iconName = await _getNotificationIcon();
    AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'high_importance_channel',
      'High Importance Notifications',
      importance: Importance.max,
      priority: Priority.high,
      icon: iconName,
    );
//     const AndroidNotificationDetails androidPlatformChannelSpecifics =
//     AndroidNotificationDetails(
//   'high_importance_channel',
//   'High Importance Notifications',
//   importance: Importance.max,
//   priority: Priority.high,
//   icon: '@drawable/ic_stat_notification', // Use the new icon here
// );

    NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    await _flutterLocalNotificationsPlugin.show(
      0,
      message.notification?.title ?? "New Notification",
      message.notification?.body ?? "No content",
      platformChannelSpecifics,
    );
  }

  void _handleMessage(RemoteMessage message) {
    log("Notification Clicked: ${message.data}");
    // Get.to(() => const NotificationScreen());
  }
}
