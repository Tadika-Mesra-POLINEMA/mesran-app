import 'package:flutter/material.dart';
import 'package:mesran_app/themes.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  void _togglePasswordVisibility() {
    setState(() {
      _isPasswordVisible = !_isPasswordVisible;
    });
  }

  void _togglePasswordConfirmationVisibility() {
    setState(() {
      _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text('Nama', style: titleOne.copyWith(color: neutralBase)),
      const SizedBox(height: 8),
      TextField(
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.person_outline),
          hintText: 'Masukkan nama Anda',
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
      Text('No. Hp', style: titleOne.copyWith(color: neutralBase)),
      const SizedBox(height: 8),
      TextField(
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.phone_iphone),
          hintText: 'Masukkan No. Hp Anda',
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
          hintText: 'Buat kata sandi',
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
      const SizedBox(height: 16),
      Text('Konfirmasi Kata Sandi',
          style: titleOne.copyWith(color: neutralBase)),
      const SizedBox(height: 8),
      TextField(
        obscureText: !_isConfirmPasswordVisible,
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.lock_outline),
          suffixIcon: IconButton(
            icon: Icon(
              _isConfirmPasswordVisible
                  ? Icons.visibility_outlined
                  : Icons.visibility_off_outlined,
            ),
            onPressed: _togglePasswordConfirmationVisibility,
          ),
          hintText: 'Ulangi kata sandi',
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
