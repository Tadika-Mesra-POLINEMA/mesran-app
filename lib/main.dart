import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mesran_app/src/config/injector.dart';
import 'package:mesran_app/src/config/routes/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupInjection();
  runApp(const MyApp());
}

final GoRouter router =
    GoRouter(initialLocation: '/', routes: Routes().getRoutes());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
