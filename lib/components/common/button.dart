import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final Function onPressed;
  final Widget child;
  final ButtonStyle style;

  const Button(
      {super.key,
      required this.onPressed,
      required this.style,
      required this.child});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () => onPressed(), style: style, child: child);
  }
}
