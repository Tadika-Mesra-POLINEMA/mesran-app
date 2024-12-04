import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:mesran_app/src/config/styles/icons/template.dart' as ic;
import 'package:mesran_app/src/config/styles/texts/medium.dart';
import 'package:mesran_app/src/config/styles/texts/semibold.dart';
import 'package:mesran_app/src/config/styles/themes/colors/neutral.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? leadingText;
  final String? middleText;
  final List<PopupItem>? dropdownItems;
  final Widget? endSection;

  const CustomAppBar({
    super.key,
    this.leadingText,
    this.middleText,
    this.dropdownItems,
    this.endSection,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: white,
      elevation: 0,
      automaticallyImplyLeading: false,
      title: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () => context.pop(),
                  child: Icon(
                    Icons.arrow_back_ios,
                    color: neutralBase,
                    size: 16,
                  ),
                ),
                Gap(8),
                if (leadingText?.isNotEmpty == true &&
                    (middleText?.isEmpty ?? true))
                  Text(
                    leadingText!,
                    style: titleOneMedium.copyWith(color: neutralBase),
                  ),
              ],
            ),
            if (middleText != '' && middleText != null)
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: 300,
                    child: Text(
                      middleText!,
                      textAlign: TextAlign.center,
                      style: headingTwoSemiBold.copyWith(color: neutralBase),
                    ),
                  ),
                ],
              ),
            if (dropdownItems != null && dropdownItems!.isNotEmpty)
              PopupMenu(items: dropdownItems!),
            if (endSection != null) endSection!,
            if (dropdownItems == null && endSection == null) const SizedBox(),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class PopupMenu extends StatelessWidget {
  final List<PopupItem> items;

  const PopupMenu({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      icon: Icon(
        Icons.more_vert,
        color: neutralBase,
      ),
      offset: const Offset(-4, 48),
      elevation: 0,
      color: white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: neutral20),
      ),
      style: ButtonStyle(
          overlayColor: WidgetStateProperty.all(Colors.transparent)),
      tooltip: '',
      onSelected: (value) {
        final item = items.firstWhere((item) => item.value == value);
        item.onPressed();
      },
      itemBuilder: (BuildContext context) {
        List<PopupMenuEntry<String>> menuItems = [];
        for (int i = 0; i < items.length; i++) {
          menuItems.add(items[i]);
          if (i < items.length - 1) {
            menuItems.add(const PopupMenuDivider());
          }
        }
        return menuItems;
      },
    );
  }
}

class PopupItem extends PopupMenuItem<String> {
  final VoidCallback onPressed;
  final ic.Icon icon;
  final String label;

  PopupItem({
    super.key,
    required this.onPressed,
    required this.icon,
    required this.label,
  }) : super(
          padding: const EdgeInsets.all(2),
          child: Row(
            children: [
              icon,
              Gap(2),
              Text(
                label,
                style: titleOneMedium.copyWith(color: neutralBase),
              ),
            ],
          ),
        );
}
