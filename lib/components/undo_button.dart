import 'package:flutter/material.dart';
import 'package:mesran_app/themes.dart';

class UndoButton extends StatelessWidget {
  final VoidCallback onPressed;

  const UndoButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () => onPressed(),
        style: ElevatedButton.styleFrom(
            shape: const CircleBorder(),
            padding: const EdgeInsets.all(2),
            shadowColor: Colors.transparent,
            side: BorderSide(color: neutral20),
            backgroundColor: white),
        child: Icon(
          Icons.chevron_left,
          color: neutralBase,
        ));
  }
}
