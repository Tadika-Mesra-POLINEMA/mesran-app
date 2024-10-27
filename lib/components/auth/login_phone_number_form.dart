import 'package:flutter/material.dart';
import 'package:mesran_app/themes.dart';

class LoginPhoneNumberForm extends StatefulWidget {
  const LoginPhoneNumberForm({super.key});

  @override
  State<LoginPhoneNumberForm> createState() => _LoginPhoneNumberFormState();
}

class _LoginPhoneNumberFormState extends State<LoginPhoneNumberForm> {
  bool _isPasswordVisible = false;

  void _togglePasswordVisibility() {
    setState(() {
      _isPasswordVisible = !_isPasswordVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text('No. Hp', style: titleOne.copyWith(color: neutralBase)),
      const SizedBox(height: 8),
      TextField(
        decoration: InputDecoration(
            prefixIcon: const Icon(Icons.phone_iphone_outlined),
            hintText: 'Masukkan No. Hp Anda',
            hintStyle: titleOne.copyWith(color: neutral40),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: neutral20),
                borderRadius: BorderRadius.circular(12)),
            border: OutlineInputBorder(
              borderSide: BorderSide(color: neutral20),
              borderRadius: BorderRadius.circular(12),
            )),
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
              borderRadius: BorderRadius.circular(12)),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: neutral20),
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    ]);
  }
}
