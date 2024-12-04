import 'package:flutter/material.dart';
import 'package:mesran_app/src/config/styles/texts/semibold.dart';
import 'package:mesran_app/src/config/styles/themes/colors/neutral.dart';
import 'package:mesran_app/src/features/profiles/presentation/widgets/create_profile_akun_form.dart';
import 'package:mesran_app/src/shared/presentation/widgets/custom_app_bar.dart';
import 'package:mesran_app/src/shared/presentation/widgets/form/button.dart';

class CreateProfileAkun extends StatelessWidget {
  const CreateProfileAkun({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
          leadingText: 'Informasi Pribadi',
        ),
        body: const Padding(
          padding: EdgeInsets.all(16.0),
          child: CreateProfileAkunForm(),
        ),
        backgroundColor: white,
        bottomNavigationBar: BottomAppBar(
          color: white,
          child: Button(
              onPressed: () {},
              child: Text('Simpan',
                  style: titleOneSemiBold.copyWith(color: white))),
        ));
  }
}
