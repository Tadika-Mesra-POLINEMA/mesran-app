import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mesran_app/themes.dart';

class AuthenticationSuccessPage extends StatelessWidget {
  final String title;

  const AuthenticationSuccessPage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset('assets/images/login-success.png'),
              const SizedBox(
                height: 24,
              ),
              Column(
                children: [
                  Text(
                    title,
                    style: headingThreeSemiBold.copyWith(color: neutralBase),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Anda berhasil masuk ke akun. Nikmati semua fitur yang tersedia!',
                    style: titleTwo.copyWith(color: neutral40),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: white,
        child: ElevatedButton(
          onPressed: () => context.replace('/home'),
          style: ElevatedButton.styleFrom(
            backgroundColor: primaryBase,
            elevation: 0,
            minimumSize: const Size(double.infinity, 48),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(64),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Text(
              'Lanjut ke Beranda',
              style: titleOneSemiBold.copyWith(color: white),
            ),
          ),
        ),
      ),
    );
  }
}
