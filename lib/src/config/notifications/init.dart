import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:mesran_app/src/config/notifications/permission.dart';

late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

Future<void> setupLocalNotifications() async {
  await requestNotificationPermission();

  /// Setup local notifications
  flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');
  final InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
  );

  await flutterLocalNotificationsPlugin.initialize(initializationSettings);
}
