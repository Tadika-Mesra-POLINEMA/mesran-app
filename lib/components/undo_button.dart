import 'package:flutter/material.dart';
import 'package:mesran_app/utils/themes.dart';

class UndoButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String? label;
  final Widget? rightSection;

  const UndoButton({
    super.key,
    required this.onPressed,
    this.label,
    this.rightSection,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: white,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(12),
        border: (label != null && label!.isEmpty)
            ? Border.all(color: neutral20)
            : null,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: onPressed,
                child: Icon(
                  Icons.chevron_left,
                  color: neutralBase,
                  size: 24,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                label ?? '',
                style: headingTwoSemiBold.copyWith(color: neutralBase),
              ),
            ],
          ),
          if (rightSection != null) rightSection!,
        ],
      ),
    );
  }
}
