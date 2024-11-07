import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mesran_app/utils/icons.dart';
import 'package:mesran_app/utils/themes.dart';

class CreateProfilePribadiForm extends StatelessWidget {
  const CreateProfilePribadiForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Nama', style: titleOneMedium.copyWith(color: neutralBase)),
        const SizedBox(height: 8),
        TextFormField(
          decoration: InputDecoration(
            prefixIcon:
                profile.copyWith(width: 24, height: 24, color: neutralBase),
            hintText: 'Valentina Sherina',
            hintStyle: titleOne.copyWith(color: neutral40),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: neutral20),
              borderRadius: BorderRadius.circular(12),
            ),
            border: OutlineInputBorder(
                borderSide: BorderSide(color: neutral20),
                borderRadius: BorderRadius.circular(12)),
          ),
        ),
        const SizedBox(height: 16),
        Text('No. Hp', style: titleOneMedium.copyWith(color: neutralBase)),
        TextFormField(
          decoration: InputDecoration(
            prefixIcon:
                device.copyWith(width: 24, height: 24, color: neutralBase),
            hintText: '089523834238',
            hintStyle: titleOne.copyWith(color: neutral40),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: neutral20),
              borderRadius: BorderRadius.circular(12),
            ),
            border: OutlineInputBorder(
                borderSide: BorderSide(color: neutral20),
                borderRadius: BorderRadius.circular(12)),
          ),
        ),
        Spacer(flex: 12),
        TextButton(
          onPressed: () {
            // Add your button's action here
          },
          style: TextButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            backgroundColor:
                Colors.white, // Background color similar to TextFormField
            shape: RoundedRectangleBorder(
              side: BorderSide(color: primary10),
              borderRadius: BorderRadius.circular(64),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Keluar',
                style: titleOne.copyWith(color: primaryBase),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
