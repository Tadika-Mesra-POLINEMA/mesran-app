import 'package:flutter_background/flutter_background.dart';
import 'package:flutter/widgets.dart';

Future<void> enableBackgroundExecution() async {
  WidgetsBinding.instance.addPostFrameCallback((_) async {
    final androidConfig = FlutterBackgroundAndroidConfig(
      notificationTitle: "App Running in Background",
      notificationText: "The app is running and connected to the server.",
      notificationIcon: AndroidResource(name: 'drawable/ic_notification'),
    );

    bool hasPermissions = await FlutterBackground.initialize(androidConfig: androidConfig);
    if (hasPermissions) {
      await FlutterBackground.enableBackgroundExecution();
    }
  });
}
