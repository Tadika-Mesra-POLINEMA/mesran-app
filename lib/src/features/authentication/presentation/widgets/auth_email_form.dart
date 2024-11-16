import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:mesran_app/src/config/styles/icons/custom.dart';
import 'package:mesran_app/src/features/authentication/domain/entity/auth_request.dart';
import 'package:mesran_app/src/features/authentication/presentation/blocs/auth_bloc.dart';
import 'package:mesran_app/src/features/authentication/presentation/blocs/auth_event.dart';
import 'package:mesran_app/src/features/authentication/presentation/blocs/auth_state.dart';
import 'package:mesran_app/src/shared/presentation/widgets/form/button.dart';
import 'package:mesran_app/src/shared/presentation/widgets/form/input_field.dart';
import 'package:mesran_app/src/shared/presentation/widgets/form/input_label.dart';
import 'package:mesran_app/src/shared/presentation/widgets/form/input_password_field.dart';
import 'package:mesran_app/utils/themes.dart';

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
          // TODO: Implement routing to home page
          context.go('/verify');
        } else if (state is AuthFailure) {
          // TODO: Implement error handling
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
                  Button(
                      onPressed: () {
                        context.read<AuthBloc>().add(
                              LoginEvent(AuthRequest(
                                  email: emailController.text,
                                  password: passwordController.text)),
                            );
                      },
                      child: Text(
                        'Masuk',
                        style: titleOneSemiBold.copyWith(color: white),
                      )),
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
