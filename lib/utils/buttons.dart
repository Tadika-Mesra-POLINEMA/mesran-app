import 'package:flutter/material.dart';
import 'package:mesran_app/utils/themes.dart';

ButtonStyle buttonPrimaryBase = ElevatedButton.styleFrom(
  backgroundColor: primaryBase,
  elevation: 0,
  minimumSize: const Size(double.infinity, 52),
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(64),
  ),
);