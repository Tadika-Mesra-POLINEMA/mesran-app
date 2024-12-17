import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:mesran_app/src/config/styles/icons/custom.dart';
import 'package:mesran_app/src/features/profiles/presentation/bloc/private_bloc.dart';
import 'package:mesran_app/src/features/profiles/presentation/bloc/private_state.dart';
import 'package:mesran_app/src/shared/presentation/widgets/form/input_field.dart';
import 'package:mesran_app/src/shared/presentation/widgets/form/input_label.dart';
import 'package:mesran_app/src/shared/presentation/widgets/form/input_password_field.dart';

class CreateProfileAkunForm extends StatelessWidget {
  final UpdatePrivateController controller;
  const CreateProfileAkunForm({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PrivateBloc, PrivateState>(
        listener: (context, state) => {},
        builder: (context, State) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InputLabel(label: 'Email'),
              Gap(8),
              InputField(
                  controller: controller.emailController,
                  prefixIcon: email,
                  hintText: 'Masukkan email Anda'),
              Gap(16),
              InputLabel(label: 'Kata Sandi Lama'),
              Gap(8),
              InputPasswordField(
                  controller: controller.passwordBController,
                  hintText: 'Masukkan kata sandi lama'),
              Gap(16),
              InputLabel(label: 'Kata Sandi Baru'),
              Gap(8),
              InputPasswordField(
                  controller: controller.passwordController,
                  hintText: 'Masukkan kata sandi baru'),
              Gap(16),
              InputLabel(label: 'Konfirmasi Kata Sandi'),
              Gap(8),
              InputPasswordField(
                  controller: controller.passwordKController,
                  hintText: 'Masukkan konfirmasi kata sandi')
            ],
          );
        });
  }
}

class UpdatePrivateController {
  TextEditingController emailController;
  TextEditingController passwordBController;
  TextEditingController passwordController;
  TextEditingController passwordKController;

  UpdatePrivateController(this.emailController, this.passwordBController,
      this.passwordController, this.passwordKController);
}
