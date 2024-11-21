import 'package:go_router/go_router.dart';
import 'package:mesran_app/src/features/home/presentation/pages/home_page.dart';
import 'package:mesran_app/src/shared/presentation/pages/boarding_page.dart';
import 'package:mesran_app/src/shared/presentation/pages/splash_screen.dart';

List<GoRoute> mainRoutes = [
  GoRoute(
    path: '/', 
    builder: (context, state) => const SplashScreen()
  ),
  GoRoute(
    path: '/boarding', 
    builder: (context, state) => const BoardingPage()
  ),
  GoRoute(
    path: '/home', 
    builder: (context, state) => const HomePage()
  ),
];
