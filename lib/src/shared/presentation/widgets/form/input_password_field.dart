import 'package:flutter/material.dart';
import 'package:mesran_app/src/config/styles/icons/custom.dart';
import 'package:mesran_app/src/config/styles/texts/medium.dart';
import 'package:mesran_app/src/config/styles/themes/colors/neutral.dart';

class InputPasswordField extends StatefulWidget {
  final String hintText;
  final TextEditingController? controller;

  const InputPasswordField(
      {super.key, required this.hintText, this.controller});

  @override
  State<InputPasswordField> createState() => _InputPasswordFieldState();
}

class _InputPasswordFieldState extends State<InputPasswordField> {
  bool _isPasswordVisible = false;

  void _togglePasswordVisibility() {
    setState(() {
      _isPasswordVisible = !_isPasswordVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: !_isPasswordVisible,
      controller: widget.controller,
      decoration: InputDecoration(
        prefixIcon: lock,
        suffixIcon: IconButton(
          icon: Icon(
            _isPasswordVisible
                ? Icons.visibility_outlined
                : Icons.visibility_off_outlined,
          ),
          onPressed: _togglePasswordVisibility,
        ),
        hintText: widget.hintText,
        hintStyle: titleOneMedium.copyWith(color: neutral40),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: neutral20),
          borderRadius: BorderRadius.circular(12),
        ),
        border: OutlineInputBorder(
            borderSide: BorderSide(color: neutral20),
            borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}
