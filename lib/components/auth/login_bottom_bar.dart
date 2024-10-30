import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mesran_app/utils/themes.dart';

class LoginBottomBar extends StatelessWidget {
  final Function onLogin;

  const LoginBottomBar({super.key, required this.onLogin});

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      height: 128,
      color: white,
      child: Column(
        children: [
          ElevatedButton(
            onPressed: () => onLogin(),
            style: ElevatedButton.styleFrom(
              backgroundColor: neutral10,
              elevation: 0,
              minimumSize: const Size(double.infinity, 48),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(64),
              ),
            ),
            onHover: (value) => {},
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Text(
                'Masuk',
                style: titleOneSemiBold.copyWith(color: neutral40),
              ),
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Belum mempunyai akun?',
                style: TextStyle(color: Colors.grey),
              ),
              TextButton(
                onPressed: () => context.push('/register'),
                child: const Text(
                  'Daftar',
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
