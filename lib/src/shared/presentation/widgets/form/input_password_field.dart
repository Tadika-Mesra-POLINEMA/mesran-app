import 'package:flutter/material.dart';
import 'package:mesran_app/src/config/styles/icons/custom.dart';
import 'package:mesran_app/src/config/styles/texts/medium.dart';
import 'package:mesran_app/src/config/styles/themes/colors/error.dart';
import 'package:mesran_app/src/config/styles/themes/colors/neutral.dart';
import 'package:mesran_app/src/config/styles/themes/colors/primary.dart';

class InputPasswordField extends StatefulWidget {
  final String hintText;
  final Function(String)? onChanged;
  final TextInputType? keyboardType;
  final TextEditingController? controller;
  final bool? isError;

  const InputPasswordField(
      {super.key,
      required this.hintText,
      this.controller,
      this.keyboardType,
      this.onChanged,
      this.isError = false});

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
      onChanged: widget.onChanged,
      keyboardType: widget.keyboardType ?? TextInputType.visiblePassword,
      decoration: InputDecoration(
        prefixIcon: lock.copyWith(color: neutralBase),
        suffixIcon: IconButton(
          icon: Icon(
            _isPasswordVisible
                ? Icons.visibility_outlined
                : Icons.visibility_off_outlined,
          ),
          style: ButtonStyle(
              overlayColor: WidgetStateProperty.all(Colors.transparent)),
          onPressed: _togglePasswordVisibility,
        ),
        hintText: widget.hintText,
        hintStyle: titleOneMedium.copyWith(color: neutral40),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: widget.isError != null && widget.isError == true
                  ? errorBase
                  : neutral20),
          borderRadius: BorderRadius.circular(12),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: primaryBase, width: 2),
          borderRadius: BorderRadius.circular(12),
        ),
        border: OutlineInputBorder(
            borderSide: BorderSide(color: neutral20),
            borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}
