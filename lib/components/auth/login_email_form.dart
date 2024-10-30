import 'package:flutter/material.dart';
import 'package:mesran_app/utils/themes.dart';

class LoginEmailForm extends StatefulWidget {
  const LoginEmailForm({super.key});

  @override
  State<LoginEmailForm> createState() => _LoginEmailFormState();
}

class _LoginEmailFormState extends State<LoginEmailForm> {
  bool _isPasswordVisible = false;

  void _togglePasswordVisibility() {
    setState(() {
      _isPasswordVisible = !_isPasswordVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text('Email', style: titleOne.copyWith(color: neutralBase)),
      const SizedBox(height: 8),
      TextField(
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.email_outlined),
          hintText: 'Masukkan email Anda',
          hintStyle: titleOne.copyWith(color: neutral40),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: neutral20),
            borderRadius: BorderRadius.circular(12),
          ),
          border: OutlineInputBorder(
              borderSide: BorderSide(color: neutral20),
              borderRadius: BorderRadius.circular(12)),
        ),
      ),
      const SizedBox(height: 16),
      Text('Kata Sandi', style: titleOne.copyWith(color: neutralBase)),
      const SizedBox(height: 8),
      TextField(
        obscureText: !_isPasswordVisible,
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.lock_outline),
          suffixIcon: IconButton(
            icon: Icon(
              _isPasswordVisible
                  ? Icons.visibility_outlined
                  : Icons.visibility_off_outlined,
            ),
            onPressed: _togglePasswordVisibility,
          ),
          hintText: 'Masukkan kata sandi',
          hintStyle: titleOneMedium.copyWith(color: neutral40),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: neutral20),
            borderRadius: BorderRadius.circular(12),
          ),
          border: OutlineInputBorder(
              borderSide: BorderSide(color: neutral20),
              borderRadius: BorderRadius.circular(12)),
        ),
      ),
    ]);
  }
}