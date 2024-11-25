import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:mesran_app/src/config/styles/icons/custom.dart';
import 'package:mesran_app/src/config/styles/texts/regular.dart';
import 'package:mesran_app/src/config/styles/themes/colors/primary.dart';
import 'package:mesran_app/src/features/users/presentation/blocs/register_bloc.dart';
import 'package:mesran_app/src/features/users/presentation/blocs/register_event.dart';
import 'package:mesran_app/src/features/users/presentation/blocs/register_state.dart';
import 'package:mesran_app/src/shared/presentation/widgets/form/input_field.dart';
import 'package:mesran_app/src/shared/presentation/widgets/form/input_label.dart';
import 'package:mesran_app/src/shared/presentation/widgets/form/input_password_field.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterBloc, RegisterState>(
        listener: (context, state) {
      // if (state is RegisterSuccess) {
      //   context.push('/login');
      // }
    }, builder: (context, state) {
      return Expanded(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InputLabel(label: 'Nama'),
          Gap(8),
          _UsernameInput(),
          Gap(16),
          InputLabel(label: 'Email'),
          Gap(8),
          _EmailInput(),
          Gap(16),
          InputLabel(label: 'No. Hp'),
          Gap(8),
          _PhoneInput(),
          Gap(16),
          InputLabel(label: 'Kata Sandi'),
          Gap(8),
          _PasswordInput(),
          Gap(16),
          InputLabel(label: 'Konfirmasi Kata Sandi'),
          Gap(8),
          _ConfirmPasswordInput(),
        ],
      ));
    });
  }
}

class _UsernameInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterBloc, RegisterState>(
      buildWhen: (previous, current) =>
          previous.username != current.username ||
          previous.isUsernameValid != current.isUsernameValid,
      builder: (context, state) {
        final isUsernameError =
            (state.username.isNotEmpty && !state.isUsernameValid);

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InputField(
              prefixIcon: profile,
              keyboardType: TextInputType.text,
              hintText: 'Masukkan nama Anda',
              isError: isUsernameError,
              onChanged: (username) => context
                  .read<RegisterBloc>()
                  .add(RegisterUsernameChanged(username)),
            ),
            if (isUsernameError) Gap(8),
            if (isUsernameError)
              Text(
                '*${state.errorMessage}',
                style: titleTwo.copyWith(color: primaryBase),
              ),
          ],
        );
      },
    );
  }
}

class _EmailInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterBloc, RegisterState>(
      buildWhen: (previous, current) =>
          previous.email != current.email ||
          previous.isEmailValid != current.isEmailValid,
      builder: (context, state) {
        final isEmailError = (state.email.isNotEmpty && !state.isEmailValid);

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InputField(
              prefixIcon: email,
              keyboardType: TextInputType.emailAddress,
              hintText: 'Masukkan email Anda',
              isError: isEmailError,
              onChanged: (email) =>
                  context.read<RegisterBloc>().add(RegisterEmailChanged(email)),
            ),
            if (isEmailError) Gap(8),
            if (isEmailError)
              Text(
                '*${state.errorMessage}',
                style: titleTwo.copyWith(color: primaryBase),
              ),
          ],
        );
      },
    );
  }
}

class _PhoneInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterBloc, RegisterState>(
      buildWhen: (previous, current) =>
          previous.phone != current.phone ||
          previous.isPhoneValid != current.isPhoneValid,
      builder: (context, state) {
        final isPhoneError = (state.phone.isNotEmpty && !state.isPhoneValid);

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InputField(
                prefixIcon: mobileDevice,
                hintText: 'Masukkan email Anda',
                keyboardType: TextInputType.phone,
                isError: isPhoneError,
                onChanged: (phone) => context
                    .read<RegisterBloc>()
                    .add(RegisterPhoneChanged(phone))),
            if (isPhoneError) Gap(8),
            if (isPhoneError)
              Text(
                '*${state.errorMessage}',
                style: titleTwo.copyWith(color: primaryBase),
              ),
          ],
        );
      },
    );
  }
}

class _PasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterBloc, RegisterState>(
      buildWhen: (previous, current) =>
          previous.password != current.password ||
          previous.isPasswordValid != current.isPasswordValid,
      builder: (context, state) {
        final isPasswordError =
            (state.password.isNotEmpty && !state.isPasswordValid);

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InputPasswordField(
                hintText: 'Buat kata sandi',
                isError: isPasswordError,
                onChanged: (password) => context
                    .read<RegisterBloc>()
                    .add(RegisterPasswordChanged(password))),
            if (isPasswordError) Gap(8),
            if (isPasswordError)
              Text(
                '*${state.errorMessage}',
                style: titleTwo.copyWith(color: primaryBase),
              ),
          ],
        );
      },
    );
  }
}

class _ConfirmPasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterBloc, RegisterState>(
      buildWhen: (previous, current) =>
          previous.isConfirmPasswordValid != current.isConfirmPasswordValid,
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InputPasswordField(
              hintText: 'Buat kata sandi',
              isError: !state.isConfirmPasswordValid,
              onChanged: (confirmPassword) => context
                  .read<RegisterBloc>()
                  .add(RegisterConfirmPasswordChanged(confirmPassword)),
            ),
          ],
        );
      },
    );
  }
}
