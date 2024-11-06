import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mesran_app/utils/icons.dart';
import 'package:mesran_app/utils/themes.dart';

class CreateProfileAkunForm extends StatefulWidget {
  const CreateProfileAkunForm({super.key});

  @override
  State<CreateProfileAkunForm> createState() => _CreateProfileAkunFormState();
}

class _CreateProfileAkunFormState extends State<CreateProfileAkunForm> {
  bool _isPasswordVisible = false;

  void _togglePasswordVisibility() {
    setState(() {
      _isPasswordVisible = !_isPasswordVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Email', style: titleOneMedium.copyWith(color: neutralBase)),
        const SizedBox(height: 8),
        TextFormField(
          decoration: InputDecoration(
            prefixIcon:
                email.copyWith(width: 24, height: 24, color: neutralBase),
            hintText: 'katakbhizer@gmail.com',
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
        Text('Kata Sandi', style: titleOneMedium.copyWith(color: neutralBase)),
        TextFormField(
          obscureText: !_isPasswordVisible,
          decoration: InputDecoration(
            prefixIcon:
                lock.copyWith(width: 24, height: 24, color: neutralBase),
            suffixIcon: IconButton(
              icon: Icon(
                _isPasswordVisible
                    ? Icons.visibility_outlined
                    : Icons.visibility_off_outlined,
              ),
              onPressed: _togglePasswordVisibility,
            ),
            hintText: '******',
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
        Text('Konfirmasi Kata Sandi',
            style: titleOneMedium.copyWith(color: neutralBase)),
        TextFormField(
          obscureText: !_isPasswordVisible,
          decoration: InputDecoration(
            prefixIcon:
                lock.copyWith(width: 24, height: 24, color: neutralBase),
            suffixIcon: IconButton(
              icon: Icon(
                _isPasswordVisible
                    ? Icons.visibility_outlined
                    : Icons.visibility_off_outlined,
              ),
              onPressed: _togglePasswordVisibility,
            ),
            hintText: '******',
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
        Spacer(flex: 12),
        TextButton(
          onPressed: () {
            // Add your button's action here
          },
          style: TextButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            backgroundColor:
                Colors.white, // Background color similar to TextFormField
            shape: RoundedRectangleBorder(
              side: BorderSide(color: primary10),
              borderRadius: BorderRadius.circular(64),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Keluar',
                style: titleOne.copyWith(color: primaryBase),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
