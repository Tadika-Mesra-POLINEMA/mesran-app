import 'package:go_router/go_router.dart';
import 'package:mesran_app/src/features/authentication/presentation/pages/auth_page.dart';
import 'package:mesran_app/src/features/authentication/presentation/pages/verification_page.dart';
import 'package:mesran_app/src/features/authentication/presentation/pages/verification_success_page.dart';
import 'package:mesran_app/src/features/users/presentation/pages/register_page.dart';

List<GoRoute> authRoutes = [
  GoRoute(
    path: '/login', 
    builder: (context, state) => const AuthPage()
  ),
  GoRoute(
    path: '/register', 
    builder: (context, state) => const RegisterPage()
  ),
  GoRoute(
    path: '/verify', 
    builder: (context, state) => const VerificationPage()
  ),
  GoRoute(
    path: '/verify/success', 
    builder: (context, state) => const VerificationSuccessPage()
  ),
];
