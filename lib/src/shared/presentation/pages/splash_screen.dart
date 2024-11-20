import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:mesran_app/src/config/injector.dart';
import 'package:mesran_app/src/config/styles/themes/colors/primary.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SharedPreferences? _prefs;
  late FlutterSecureStorage _secureStorage;

  @override
  void initState() {
    super.initState();
    _initializePreferences();
  }

  Future<void> _initializePreferences() async {
    await Future.delayed(const Duration(seconds: 2));
    _prefs = getIt<SharedPreferences>();
    _secureStorage = getIt<FlutterSecureStorage>();
    _navigateAfterSplash();
  }

  Future<void> _navigateAfterSplash() async {
    bool? isFirstTimeAccess = _prefs?.getBool('first_time_access');

    if (isFirstTimeAccess == null || isFirstTimeAccess) {
      _prefs?.setBool('first_time_access', false);
      context.push('/boarding');
    } else {
      // Check if already logged in in secure storage
      final isLoggedIn = _secureStorage.read(key: 'accessToken') as String;

      if (isLoggedIn.isNotEmpty) {
        context.go('/home');
      } else {
        context.go('/login');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryBase,
      body: Center(
        child: Image.asset(
          'assets/images/mesran-logo.png',
          width: 120,
          height: 120,
        ),
      ),
    );
  }
}
