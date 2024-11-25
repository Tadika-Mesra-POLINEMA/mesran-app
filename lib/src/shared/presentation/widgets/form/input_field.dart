import 'package:flutter/material.dart';
import 'package:mesran_app/src/config/styles/icons/template.dart' as ic;
import 'package:mesran_app/src/config/styles/texts/regular.dart';
import 'package:mesran_app/src/config/styles/themes/colors/error.dart';
import 'package:mesran_app/src/config/styles/themes/colors/neutral.dart';
import 'package:mesran_app/src/config/styles/themes/colors/primary.dart';

class InputField extends StatelessWidget {
  final ic.Icon prefixIcon;
  final String hintText;
  final TextEditingController? controller;
  final InputDecoration? decoration;
  final Function(String)? onChanged;
  final TextInputType? keyboardType;
  final bool? isError;

  const InputField({
    super.key,
    required this.prefixIcon,
    required this.hintText,
    this.keyboardType,
    this.decoration,
    this.onChanged,
    this.controller,
    this.isError = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onChanged,
      controller: controller,
      keyboardType: keyboardType ?? TextInputType.text,
      decoration: decoration ??
          InputDecoration(
            prefixIcon: prefixIcon.copyWith(color: neutralBase),
            hintText: hintText,
            hintStyle: titleOne.copyWith(color: neutral40),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: isError != null && isError == true
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
