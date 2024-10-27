import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mesran_app/themes.dart';

class RegisterBottomBar extends StatelessWidget {
  final Function onRegister;

  const RegisterBottomBar({super.key, required this.onRegister});

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      height: 128,
      color: white,
      child: Column(
        children: [
          ElevatedButton(
            onPressed: () => onRegister(),
            style: ElevatedButton.styleFrom(
              backgroundColor: neutral10,
              elevation: 0,
              minimumSize: const Size(double.infinity, 48),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(64),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Text(
                'Daftar',
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
                'Sudah mempunyai akun?',
                style: TextStyle(color: Colors.grey),
              ),
              TextButton(
                onPressed: () => context.push('/login'),
                child: const Text(
                  'Masuk',
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
