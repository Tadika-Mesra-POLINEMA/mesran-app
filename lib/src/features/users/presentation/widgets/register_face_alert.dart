import 'package:flutter/material.dart';
import 'package:mesran_app/src/config/styles/texts/medium.dart';
import 'package:mesran_app/src/config/styles/themes/colors/error.dart';
import 'package:mesran_app/src/config/styles/themes/colors/neutral.dart';
import 'package:mesran_app/src/config/styles/themes/colors/success.dart';
import 'package:mesran_app/src/config/styles/themes/colors/warning.dart';

class RegisterFaceAlert extends StatelessWidget {
  final String text;
  final RegisterFaceType type;

  const RegisterFaceAlert({super.key, required this.text, required this.type});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: _getColor(type),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: _getBorderColor(type), width: 1)),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Text(
          text,
          style: titleOneMedium.copyWith(color: neutralBase),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Color _getColor(RegisterFaceType type) {
    switch (type) {
      case RegisterFaceType.success:
        return success10;
      case RegisterFaceType.loading:
        return neutral10;
      case RegisterFaceType.error:
        return error10;
      case RegisterFaceType.warning:
        return warning10;
    }
  }

  Color _getBorderColor(RegisterFaceType type) {
    switch (type) {
      case RegisterFaceType.success:
        return success30;
      case RegisterFaceType.loading:
        return neutral30;
      case RegisterFaceType.error:
        return error30;
      case RegisterFaceType.warning:
        return warning30;
    }
  }
}

enum RegisterFaceType {
  success,
  loading,
  error,
  warning,
}
