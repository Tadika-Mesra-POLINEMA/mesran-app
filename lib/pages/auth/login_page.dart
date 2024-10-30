import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mesran_app/components/auth/login_bottom_bar.dart';
import 'package:mesran_app/components/auth/login_email_form.dart';
import 'package:mesran_app/components/auth/login_phone_number_form.dart';
import 'package:mesran_app/components/undo_button.dart';
import 'package:mesran_app/utils/themes.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String loginType = 'email';

  void _toggleChangeLoginType(String type) {
    setState(() {
      loginType = type;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 16, top: 16),
          child: UndoButton(onPressed: () => context.pop()),
        ),
        leadingWidth: double.infinity,
        backgroundColor: white,
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 32,
            ),
            Text(
              'Daftarkan akun Anda!',
              style: headingTwoSemiBold.copyWith(color: neutralBase),
            ),
            const SizedBox(height: 8),
            Text(
              'Isi informasi yang diperlukan, dan Anda akan siap untuk memulai dalam hitungan menit!',
              style: titleTwo.copyWith(color: neutral40),
            ),
            const SizedBox(height: 32),
            Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: neutral10,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () => _toggleChangeLoginType("email"),
                      child: Container(
                        decoration: BoxDecoration(
                          color: loginType == "email" ? white : neutral10,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        alignment: Alignment.center,
                        child: Text(
                          'Email',
                          style: titleOneMedium.copyWith(
                              color: loginType == "email"
                                  ? neutralBase
                                  : neutral40),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => _toggleChangeLoginType("phone"),
                      child: Container(
                        decoration: BoxDecoration(
                          color: loginType == "phone" ? white : neutral10,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        alignment: Alignment.center,
                        child: Text(
                          'No. Hp',
                          style: titleOneMedium.copyWith(
                              color: loginType == "phone"
                                  ? neutralBase
                                  : neutral40),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            Container(
              child: loginType == "email"
                  ? const LoginEmailForm()
                  : const LoginPhoneNumberForm(),
            )
          ],
        ),
      ),
      bottomNavigationBar: LoginBottomBar(
        onLogin: () => context.push('/verify-otp'),
      ),
      backgroundColor: white,
    );
  }
}
