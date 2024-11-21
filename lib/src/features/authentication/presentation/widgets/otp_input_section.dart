import 'package:flutter/material.dart';
import 'package:mesran_app/src/config/styles/themes/colors/neutral.dart';

class OtpInputSection extends StatelessWidget {
  final int otpLength;
  final List<FocusNode> focusNodes;
  final Function(String, int) onOtpChanged;

  const OtpInputSection({
    super.key,
    required this.otpLength,
    required this.focusNodes,
    required this.onOtpChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(otpLength, (index) {
        return Container(
          width: 50,
          margin: const EdgeInsets.only(right: 8),
          child: TextField(
            focusNode: focusNodes[index],
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            maxLength: 1,
            onChanged: (value) => onOtpChanged(value, index),
            decoration: InputDecoration(
              counterText: "",
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: neutral20),
                borderRadius: BorderRadius.circular(12),
              ),
              border: OutlineInputBorder(
                borderSide: BorderSide(color: neutral20),
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        );
      }),
    );
  }
}
