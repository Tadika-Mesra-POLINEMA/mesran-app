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
  bool _mounted = true; // Untuk memastikan widget masih aktif

  @override
  void initState() {
    super.initState();
    _initializePreferences();
  }

  @override
  void dispose() {
    _mounted = false;
    super.dispose();
  }

  Future<void> _initializePreferences() async {
    try {
      await Future.delayed(const Duration(seconds: 2));
      _prefs = getIt<SharedPreferences>();
      _secureStorage = getIt<FlutterSecureStorage>();

      if (_mounted) {
        await _navigateAfterSplash();
      }
    } catch (e) {
      debugPrint('Error initializing preferences: $e');
    }
  }

  Future<void> _navigateAfterSplash() async {
    if (!mounted) return;
    bool? isFirstTimeAccess = _prefs?.getBool('first_time_access');

    await _secureStorage.write(key: 'test', value: 'test');
    final res = await _secureStorage.read(key: 'test');

    debugPrint('Result ${res}');

    if (isFirstTimeAccess == null || isFirstTimeAccess) {
      _prefs?.setBool('first_time_access', false);
      context.push('/boarding');
    } else {
      final isLoggedIn = await _secureStorage.read(key: 'accessToken');

      if (isLoggedIn != null && isLoggedIn.isNotEmpty) {
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
