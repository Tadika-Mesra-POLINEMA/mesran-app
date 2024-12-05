import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mesran_app/src/config/injector.dart';
import 'package:mesran_app/src/config/styles/themes/colors/primary.dart';
import 'package:mesran_app/src/core/api/dio_client.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SharedPreferences? _prefs;
  late DioClient _dioClient;
  late GoRouter _router;

  bool _mounted = true;

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
      _dioClient = getIt<DioClient>();
      _router = getIt<GoRouter>();

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

    if (isFirstTimeAccess == null || isFirstTimeAccess) {
      _prefs?.setBool('first_time_access', false);
      context.go('/boarding');
    } else {
      try {
        final res = await _dioClient.get('api/users/me');

        if (res.statusCode == 200) {
          final data = res.data['data']["is_face_registered"] as bool;

          if (!data) {
            _router.go('/register/faces/verify');
          } else {
            _router.go('/home');
          }
        } else {
          _router.go('/login');
        }
      } catch (e) {
        debugPrint('Error fetching user data: $e');
        _router.go('/login');
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
