import 'package:go_router/go_router.dart';
import 'package:mesran_app/models/user.dart';
import 'package:mesran_app/pages/auth/login_page.dart';
import 'package:mesran_app/pages/auth/authentication_success_page.dart';
import 'package:mesran_app/pages/auth/register_page.dart';
import 'package:mesran_app/pages/auth/verify_otp_page.dart';
import 'package:mesran_app/pages/event/create_activities_page.dart';
import 'package:mesran_app/pages/event/create_event_page.dart';
import 'package:mesran_app/pages/event/event_activities_page.dart';
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
  ),

  // Authentication Routes
  GoRoute(
    path: '/login',
    builder: (context, state) => const LoginPage(),
  ),
  GoRoute(path: '/register', builder: (context, state) => const RegisterPage()),
  GoRoute(
      path: '/verify-otp', builder: (context, state) => const VerifyOtpPage()),
  GoRoute(
      path: '/auth-success',
      builder: (context, state) {
        final AuthenticationSuccess authSuccess =
            state.extra! as AuthenticationSuccess;
        return AuthenticationSuccessPage(title: authSuccess.title);
      }),

  // Events
  GoRoute(
      path: '/events/create',
      builder: (context, state) => const CreateEventPage()),
  GoRoute(
      path: '/events/activities',
      builder: (context, state) => const EventActivitiesPage(
            itemCount: 3,
          )),
  GoRoute(
      path: '/events/activities/create',
      builder: (context, state) => const CreateActivitiesPage()),
];
