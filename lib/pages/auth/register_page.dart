import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mesran_app/components/auth/register_bottom_bar.dart';
import 'package:mesran_app/components/auth/register_form.dart';
import 'package:mesran_app/components/undo_button.dart';
import 'package:mesran_app/models/user.dart';
import 'package:mesran_app/utils/themes.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 16, top: 16),
          child: UndoButton(onPressed: () => context.pop()),
        ),
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
              'Isi data yang diperlukan dan bergabunglah dengan komunitas kami dalam beberapa langkah mudah!',
              style: titleTwo.copyWith(color: neutral40),
            ),
            const SizedBox(height: 32),
            const RegisterForm()
          ],
        ),
      ),
      bottomNavigationBar: RegisterBottomBar(
        onRegister: () => context.push('/auth-success',
            extra: AuthenticationSuccess(title: 'Anda berhasil mendaftar!')),
      ),
      backgroundColor: white,
    );
  }
}
