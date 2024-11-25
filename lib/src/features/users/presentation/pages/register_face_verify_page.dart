import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:mesran_app/src/config/injector.dart';
import 'package:mesran_app/src/config/styles/texts/medium.dart';
import 'package:mesran_app/src/config/styles/texts/regular.dart';
import 'package:mesran_app/src/config/styles/texts/semibold.dart';
import 'package:mesran_app/src/config/styles/themes/colors/neutral.dart';
import 'package:mesran_app/src/config/styles/themes/colors/primary.dart';
import 'package:mesran_app/src/shared/presentation/widgets/custom_app_bar.dart';
import 'package:mesran_app/src/shared/presentation/widgets/form/button.dart';

class RegisterFaceVerifyPage extends StatelessWidget {
  final _secureStorage = getIt<FlutterSecureStorage>();

  RegisterFaceVerifyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      backgroundColor: white,
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text(
              'Registrasi wajah',
              style: headingTwoSemiBold.copyWith(color: neutralBase),
            ),
            Gap(8),
            Text(
              'Sebentar lagi, kami akan meminta Anda untuk mengambil foto selfie dengan tersenyum. ini akan memberi tahu kami bahwa itu benar-benar Anda.',
              style: titleTwoRegular.copyWith(color: neutral40),
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        height: 140,
        color: white,
        child: Column(
          children: [
            Button(
                onPressed: () => _goToRegisterPage(context),
                type: ButtonType.primary,
                child: Text(
                  'Lanjut',
                  style: titleOneSemiBold.copyWith(color: white),
                )),
            Gap(12),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Sudah mempunyai akun?',
                  style: titleOne.copyWith(color: neutral40),
                ),
                TextButton(
                  onPressed: () => context.push('/login'),
                  style: ButtonStyle(
                    overlayColor: WidgetStateProperty.all(Colors.transparent),
                  ),
                  child: Text(
                    'Masuk',
                    style: titleOneMedium.copyWith(
                      color: primaryBase,
                      decoration: TextDecoration.underline,
                      decorationColor: primaryBase,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _goToRegisterPage(BuildContext context) async {
    final accessToken = await _secureStorage.read(key: 'accessToken');

    if (accessToken != null) {
      context.go('/register/faces');
      return;
    }
  }
}
