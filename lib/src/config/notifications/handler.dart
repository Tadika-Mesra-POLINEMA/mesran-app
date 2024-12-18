import 'package:mesran_app/src/config/notifications/ui.dart';
import 'package:mesran_app/src/core/utils/options.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mesran_app/src/config/injectors/injector.dart';

Future<void> handleNotificationConnection() async {
  final secureStorage = getIt<FlutterSecureStorage>();
  final String? token = await secureStorage.read(key: 'accessToken');

  final socket = io(
    Options.baseUrl,
    OptionBuilder()
        .setTransports(['websocket'])
        .setQuery({'token': token})
        .enableAutoConnect()
        .build(),
  );

  socket.on('notification', (data) {
    final notification = data['message'];
    showNotification('Mesran', notification['message']);
  });

  socket.connect();
}
