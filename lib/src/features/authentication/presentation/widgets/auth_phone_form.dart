import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:mesran_app/src/config/styles/icons/custom.dart';
import 'package:mesran_app/src/config/styles/texts/semibold.dart';
import 'package:mesran_app/src/config/styles/themes/colors/neutral.dart';
import 'package:mesran_app/src/shared/presentation/widgets/form/button.dart';
import 'package:mesran_app/src/shared/presentation/widgets/form/input_field.dart';
import 'package:mesran_app/src/shared/presentation/widgets/form/input_label.dart';
import 'package:mesran_app/src/shared/presentation/widgets/form/input_password_field.dart';

class AuthPhoneForm extends StatelessWidget {
  const AuthPhoneForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InputLabel(label: 'No. Hp'),
          Gap(8),
          InputField(
              prefixIcon: mobileDevice, hintText: 'Masukkan No. Hp Anda'),
          Gap(16),
          InputLabel(label: 'Kata Sandi'),
          Gap(8),
          InputPasswordField(hintText: 'Masukkan kata sandi'),
          Spacer(),
          Column(
            children: [
              Button(
                  onPressed: () {},
                  child: Text(
                    'Masuk',
                    style: titleOneSemiBold.copyWith(color: white),
                  )),
              Gap(12),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Belum mempunyai akun?',
                    style: TextStyle(color: Colors.grey),
                  ),
                  TextButton(
                    onPressed: () => context.push('/register'),
                    child: const Text(
                      'Daftar',
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
