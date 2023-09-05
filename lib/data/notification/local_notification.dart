import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotification {
  FlutterLocalNotificationsPlugin? plugin;

  static final LocalNotification _localNotification =
      LocalNotification._internal();

  factory LocalNotification() {
    return _localNotification;
  }

  LocalNotification._internal() {
    plugin ??= FlutterLocalNotificationsPlugin();
  }

  Future<void> initNotification(
      backgroundNotificationClicked, onForegroundNotificationClicked) async {
    await plugin?.initialize(
        InitializationSettings(
          android: initAndroidNotification(),
          iOS: initIOSNotification(),
        ),
        onDidReceiveNotificationResponse: onForegroundNotificationClicked,
        onDidReceiveBackgroundNotificationResponse:
            backgroundNotificationClicked);
  }

  AndroidInitializationSettings initAndroidNotification() {
    return const AndroidInitializationSettings("ic_launcher");
  }

  DarwinInitializationSettings initIOSNotification() {
    return const DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );
  }

  void showNotification(String title, String message) async {
    var id = DateTime.now().millisecondsSinceEpoch ~/ 1000;

    const NotificationDetails notificationSetting = NotificationDetails(
        android: AndroidNotificationDetails(
          "Handover",
          "Handover notification",
          importance: Importance.max,
          priority: Priority.max,
          channelShowBadge: true,
          icon: "ic_launcher",
        ),
        iOS: DarwinNotificationDetails(
          presentBadge: true,
          presentSound: true,
          presentAlert: true,
        ));

    await plugin?.show(
      id,
      title,
      message,
      notificationSetting,
    );
  }

  Future<void> requestPermission() async {
    plugin
        ?.resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestPermission();
  }
}
