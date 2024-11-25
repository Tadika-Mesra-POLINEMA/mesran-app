import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mesran_app/src/config/injector.dart';
import 'package:mesran_app/src/config/routes/routes.dart';
import 'my_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupInjection();
  final GoRouter router = GoRouter(
    initialLocation: '/',
    routes: Routes().getRoutes(),
  );
  runApp(MyApp(router: router));
}
