import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:mesran_app/src/config/styles/texts/semibold.dart';
import 'package:mesran_app/src/config/styles/themes/colors/neutral.dart';
import 'package:mesran_app/src/config/styles/themes/colors/primary.dart';
import 'package:mesran_app/src/shared/presentation/widgets/form/button.dart';

class ErrorBottomSheet extends StatelessWidget {
  final String message;

  const ErrorBottomSheet({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(16),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset('assets/images/finding.png'),
          Gap(16),
          Text(
            "Oops!, Terjadi Kesalahan",
            style: headingOneSemiBold.copyWith(color: primaryBase),
          ),
          Gap(16),
          Text(
            message,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              color: Colors.black,
            ),
          ),
          Gap(16),
          Button(
              onPressed: () {
                context.pop();
              },
              type: ButtonType.primary,
              child: Text(
                'Tutup',
                style: titleOneSemiBold.copyWith(color: white),
              )),
        ],
      ),
    );
  }
}
