import 'package:flutter/material.dart';
import 'package:mesran_app/themes.dart';

class UndoButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String? label;

  const UndoButton({super.key, required this.onPressed, this.label});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
          color: white,
          shape: BoxShape.circle,
          border: Border.all(color: neutral20),
        ),
        child: Center(
          child: Icon(
            Icons.chevron_left,
            color: neutralBase,
            size: 32,
          ),
        ),
      ),
    );
  }
}
