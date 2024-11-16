import 'package:flutter/material.dart';
import 'package:mesran_app/utils/themes.dart';

class Button extends StatelessWidget {
  final Function() onPressed;
  final ButtonType? type;
  final Widget child;

  const Button(
      {super.key, required this.onPressed, required this.child, this.type});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            color: _getButtonColor(type ?? ButtonType.primary),
            borderRadius: BorderRadius.all(Radius.circular(24)),
            border: Border.all(
                color: _getBorderColor(type ?? ButtonType.primary),
                width: type != ButtonType.primary ? 0 : 1,
                style: BorderStyle.solid)),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Center(child: child),
        ),
      ),
    );
  }

  Color _getButtonColor(ButtonType type) {
    switch (type) {
      case ButtonType.primary:
        return primaryBase;

      case ButtonType.secondary:
        return white;
    }
  }

  Color _getBorderColor(ButtonType type) {
    switch (type) {
      case ButtonType.primary:
      // None
      case ButtonType.secondary:
        return neutral20;
    }
  }
}

enum ButtonType { primary, secondary }
