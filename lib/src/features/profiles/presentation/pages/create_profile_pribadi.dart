import 'package:flutter/material.dart';
import 'package:mesran_app/src/config/styles/texts/semibold.dart';
import 'package:mesran_app/src/config/styles/themes/colors/neutral.dart';
import 'package:mesran_app/src/features/profiles/presentation/widgets/create_profile_pribadi_form.dart';
import 'package:mesran_app/src/shared/presentation/widgets/custom_app_bar.dart';
import 'package:mesran_app/src/shared/presentation/widgets/form/button.dart';

class CreateProfilePribadi extends StatelessWidget {
  const CreateProfilePribadi({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        leadingText: 'Akun',
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: CreateProfilePribadiForm(),
      ),
      backgroundColor: white,
      bottomNavigationBar: BottomAppBar(
        color: white,
        child: Button(
            onPressed: () {},
            child: Text(
              'Simpan',
              style: titleOneSemiBold.copyWith(color: white),
            )),
      ),
    );
  }
}
