import 'package:flutter/material.dart';
import 'package:mesran_app/src/config/styles/texts/regular.dart';
import 'package:mesran_app/src/config/styles/themes/colors/neutral.dart';

class InputLabel extends StatelessWidget {
  final String label;

  const InputLabel({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Text(label, style: titleOne.copyWith(color: neutralBase));
  }
}
