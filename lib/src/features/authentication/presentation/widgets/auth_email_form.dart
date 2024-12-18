import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:mesran_app/src/config/styles/icons/custom.dart';
import 'package:mesran_app/src/config/styles/texts/medium.dart';
import 'package:mesran_app/src/config/styles/texts/regular.dart';
import 'package:mesran_app/src/config/styles/texts/semibold.dart';
import 'package:mesran_app/src/config/styles/themes/colors/error.dart';
import 'package:mesran_app/src/config/styles/themes/colors/neutral.dart';
import 'package:mesran_app/src/config/styles/themes/colors/primary.dart';
import 'package:mesran_app/src/features/authentication/domain/entity/auth_request.dart';
import 'package:mesran_app/src/features/authentication/presentation/blocs/auth_bloc.dart';
import 'package:mesran_app/src/features/authentication/presentation/blocs/auth_event.dart';
import 'package:mesran_app/src/features/authentication/presentation/blocs/auth_state.dart';
import 'package:mesran_app/src/shared/presentation/widgets/form/button.dart';
import 'package:mesran_app/src/shared/presentation/widgets/form/input_field.dart';
import 'package:mesran_app/src/shared/presentation/widgets/form/input_label.dart';
import 'package:mesran_app/src/shared/presentation/widgets/form/input_password_field.dart';

class AuthEmailForm extends StatefulWidget {
  const AuthEmailForm({super.key});

  @override
  State<AuthEmailForm> createState() => _AuthEmailFormState();
}

class _AuthEmailFormState extends State<AuthEmailForm> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthSuccess) {
          context.go('/verify');
        } else if (state is AuthFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: errorBase,
            ),
          );
        }
      },
      builder: (context, state) {
        return Expanded(
          child: Column(
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
                  controller: passwordController,
                  hintText: 'Masukkan kata sandi'),
              Spacer(),
              Column(
                children: [
                  BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
                    return Button(
                        onPressed: () {
                          if (emailController.text.isNotEmpty &&
                              passwordController.text.isNotEmpty) {
                            context.read<AuthBloc>().add(
                                  LoginEvent(AuthRequest(
                                      email: emailController.text,
                                      password: passwordController.text)),
                                );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: const Text(
                                    'Email dan kata sandi wajib diisi'),
                                backgroundColor: errorBase,
                              ),
                            );
                          }
                        },
                        type: state is AuthLoading
                            ? ButtonType.secondaryFill
                            : ButtonType.primary,
                        child: Text(
                          'Masuk',
                          style: titleOneSemiBold.copyWith(
                              color: state is AuthLoading ? neutral40 : white),
                        ));
                  }),
                  Gap(12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Belum mempunyai akun?',
                        style: titleOne.copyWith(color: neutral40),
                      ),
                      TextButton(
                        onPressed: () => context.push('/register'),
                        style: ButtonStyle(
                          overlayColor:
                              WidgetStateProperty.all(Colors.transparent),
                        ),
                        child: Text(
                          'Daftar',
                          style: titleOneMedium.copyWith(color: primaryBase),
                        ),
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
