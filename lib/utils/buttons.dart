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

ButtonStyle buttonSecondaryBase = ElevatedButton.styleFrom(
    backgroundColor: white,
    elevation: 0,
    minimumSize: const Size(double.infinity, 52),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(64),
      side: BorderSide(
        color: neutral20,
        width: 1,
      ),
    ),
    overlayColor: Colors.transparent);
