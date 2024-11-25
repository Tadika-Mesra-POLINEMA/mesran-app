import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mesran_app/src/config/injector.dart';
import 'package:mesran_app/src/config/styles/texts/medium.dart';
import 'package:mesran_app/src/config/styles/texts/regular.dart';
import 'package:mesran_app/src/config/styles/texts/semibold.dart';
import 'package:mesran_app/src/config/styles/themes/colors/neutral.dart';
import 'package:mesran_app/src/config/styles/themes/colors/primary.dart';
import 'package:mesran_app/src/features/users/presentation/blocs/register_bloc.dart';
import 'package:mesran_app/src/features/users/presentation/blocs/register_event.dart';
import 'package:mesran_app/src/features/users/presentation/blocs/register_state.dart';
import 'package:mesran_app/src/features/users/presentation/widgets/register_form.dart';
import 'package:mesran_app/src/shared/presentation/widgets/custom_app_bar.dart';
import 'package:mesran_app/src/shared/presentation/widgets/form/button.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<RegisterBloc>(),
      child: Scaffold(
          appBar: CustomAppBar(),
          backgroundColor: white,
          body: SingleChildScrollView(
            child: IntrinsicHeight(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Daftarkan akun Anda!',
                      style: headingTwoSemiBold.copyWith(color: neutralBase),
                    ),
                    const Gap(8),
                    Text(
                      'Isi data yang diperlukan dan bergabunglah dengan komunitas kami dalam beberapa langkah mudah!',
                      style: titleTwo.copyWith(color: neutral40),
                    ),
                    const Gap(32),
                    RegisterForm(),
                  ],
                ),
              ),
            ),
          ),
          bottomNavigationBar: BottomRegisterPage()),
    );
  }
}

class BottomRegisterPage extends StatelessWidget {
  const BottomRegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterBloc, RegisterState>(
        listener: (context, state) {
      if (state.status == RegisterStatus.success) {
        context.go('/register/faces/verify');
      }
    }, builder: (context, state) {
      return BottomAppBar(
        height: 140,
        color: white,
        child: Column(
          children: [
            Button(
                onPressed: () {
                  state.isFormValid
                      ? context
                          .read<RegisterBloc>()
                          .add(const RegisterSubmitted())
                      : null;
                },
                type: state.isFormValid
                    ? ButtonType.primary
                    : ButtonType.secondaryFill,
                child: Text(
                  'Lanjut',
                  style: titleOneSemiBold.copyWith(
                      color: state.isFormValid ? white : neutral40),
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
      );
    });
  }
}
