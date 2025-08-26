import 'package:capitalhub_crm/utils/helper/helper.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class NotificationService {
   Future<String> _getNotificationIcon() async {
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
  
  return androidInfo.version.sdkInt >= 34 
      ? 'ic_stat_notification' 
      : 'launcher_icon';   
}
  static final NotificationService _instance = NotificationService._internal();
  factory NotificationService() => _instance;
  NotificationService._internal();

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  // Initialize the notification plugin
  Future<void> init() async {
    var androidInitializationSettings =
        AndroidInitializationSettings('ic_stat_notification');
    var initializationSettings =
        InitializationSettings(android: androidInitializationSettings);

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse details) {
        _onNotificationTap(details);
      },
    );
  }

  // Handle notification tap in the foreground
  void _onNotificationTap(NotificationResponse response) async {
    debugPrint("✅ Notification tapped (foreground): ${response.payload}");
    Helper.launchUrl(response.payload ?? "");
  }

  // Show a progress notification
  Future<void> showProgressNotification({
    required int id,
    required String title,
    required String body,
    required int progress,
    String? payload,
  }) async {
   String iconName = await _getNotificationIcon();
    
    var androidDetails = AndroidNotificationDetails(
        'download_channel', 'Download Progress',
        channelDescription: 'Progress notifications for downloads',
        importance: Importance.max,
        priority: Priority.high,
        progress: progress,
        maxProgress: 100,
        showProgress: true,
        icon:iconName,
        enableVibration: false,
        playSound: false);

    var notificationDetails = NotificationDetails(android: androidDetails);

    await flutterLocalNotificationsPlugin.show(
      id,
      title,
      body,
      notificationDetails,
      payload: payload,
    );
  }

  // Show a simple notification
  Future<void> showNotification({
    required int id,
    required String title,
    required String body,
    String? payload,
  }) async {
   String iconName = await _getNotificationIcon();

    var androidDetails = AndroidNotificationDetails(
      'default_channel',
      'Default Channel',
      channelDescription: 'For simple notifications',
      importance: Importance.max,
      priority: Priority.high,icon: iconName,
    );

    var notificationDetails = NotificationDetails(android: androidDetails);

    await flutterLocalNotificationsPlugin.show(
      id,
      title,
      body,
      notificationDetails,
      payload: payload,
    );
  }

  void cancelNotification(int id) {
    flutterLocalNotificationsPlugin.cancel(id);
  }
}
