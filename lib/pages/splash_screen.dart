import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkFirstTime();
  }

  Future<void> _checkFirstTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? isFirstTimeAccess = prefs.getBool('first_time_access');

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (isFirstTimeAccess == null || isFirstTimeAccess) {
        prefs.setBool('first_time_access', false);
        context.push('/first-time');
      } else {
        context.push('/first-time');
        // throw UnimplementedError();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: ElevatedButton(
                onPressed: () {
                  context.go('/first-time');
                },
                child: const Text('Get Started'))));
  }
}
