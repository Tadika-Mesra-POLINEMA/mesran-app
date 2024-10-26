import 'package:go_router/go_router.dart';
import 'package:mesran_app/pages/home_page.dart';
import 'package:mesran_app/pages/onboarding_page.dart';
import 'package:mesran_app/pages/splash_screen.dart';

final List<GoRoute> routes = [
  GoRoute(path: '/', builder: (context, state) => const SplashScreen()),
  GoRoute(
    path: '/first-time',
    builder: (context, state) => const OnboardingPage(),
  ),
  GoRoute(
    path: '/home',
    builder: (context, state) => const HomePage(),
  )
];
