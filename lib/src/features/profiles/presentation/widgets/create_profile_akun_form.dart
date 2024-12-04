import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:mesran_app/src/config/styles/icons/custom.dart';
import 'package:mesran_app/src/shared/presentation/widgets/form/input_field.dart';
import 'package:mesran_app/src/shared/presentation/widgets/form/input_label.dart';
import 'package:mesran_app/src/shared/presentation/widgets/form/input_password_field.dart';

class CreateProfileAkunForm extends StatefulWidget {
  const CreateProfileAkunForm({super.key});

  @override
  State<CreateProfileAkunForm> createState() => _CreateProfileAkunFormState();
}

class _CreateProfileAkunFormState extends State<CreateProfileAkunForm> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController passwordKController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InputLabel(label: 'Email'),
        Gap(8),
        InputField(
            controller: emailController,
            prefixIcon: email,
            hintText: 'Masukkan email Anda'),
        Gap(16),
        InputLabel(label: 'Kata Sandi'),
        Gap(8),
        InputPasswordField(
            controller: passwordController, hintText: 'Masukkan kata sandi'),
        Gap(16),
        InputLabel(label: 'Konfirmasi Kata Sandi'),
        Gap(8),
        InputPasswordField(
            controller: passwordKController,
            hintText: 'Masukkan konfirmasi kata sandi')
      ],
    );
  }
}
