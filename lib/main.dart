import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mesran_app/routes.dart';

void main() {
  runApp(const MyApp());
}

final GoRouter router = GoRouter(initialLocation: '/', routes: routes);

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
