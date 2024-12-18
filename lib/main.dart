import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:mesran_app/src/config/background/init.dart';
import 'package:mesran_app/src/config/notifications/handler.dart';
import 'package:mesran_app/src/config/notifications/init.dart';
import 'package:mesran_app/src/config/injectors/injector.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('id_ID', null);
  await setupDependencyInjection();
  await enableBackgroundExecution();
  await setupLocalNotifications();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final GoRouter router;

  @override
  void initState() {
    super.initState();
    router = getIt<GoRouter>();
    handleNotificationConnection();
  }

  @override
  void dispose() {
    super.dispose();
    router.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerDelegate: router.routerDelegate,
      routeInformationParser: router.routeInformationParser,
      routeInformationProvider: router.routeInformationProvider,
      debugShowCheckedModeBanner: false,
    );
  }
}
