import 'package:flutter/material.dart';
import 'package:mesran_app/utils/themes.dart';

class CardTemplate extends StatelessWidget {
  const CardTemplate({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8, right: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 148,
            height: 170,
            decoration: BoxDecoration(
              color: primary20,
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            'Template',
            style: titleTwoMedium.copyWith(color: neutralBase),
          ),
          Text(
            'Template',
            style: titleTwo.copyWith(color: neutral40),
          ),
        ],
      ),
    );
  }
}
