import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:mesran_app/src/config/notifications/init.dart';

Future<void> showNotification(String title, String body) async {
  const androidDetails = AndroidNotificationDetails(
    'your_channel_id',
    'your_channel_name',
    channelDescription: 'your_channel_description',
    importance: Importance.max,
    priority: Priority.high,
  );

  const notificationDetails = NotificationDetails(android: androidDetails);

  await flutterLocalNotificationsPlugin.show(
    0,
    title,
    body,
    notificationDetails,
  );
}
