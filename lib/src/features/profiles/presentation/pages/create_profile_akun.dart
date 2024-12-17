import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mesran_app/src/config/injector.dart';
import 'package:mesran_app/src/config/styles/texts/semibold.dart';
import 'package:mesran_app/src/config/styles/themes/colors/neutral.dart';
import 'package:mesran_app/src/features/profiles/presentation/bloc/account_bloc.dart';
import 'package:mesran_app/src/features/profiles/presentation/bloc/private_bloc.dart';
import 'package:mesran_app/src/features/profiles/presentation/bloc/private_event.dart';
import 'package:mesran_app/src/features/profiles/presentation/bloc/private_state.dart';
import 'package:mesran_app/src/features/profiles/presentation/widgets/create_profile_akun_form.dart';
import 'package:mesran_app/src/shared/presentation/widgets/custom_app_bar.dart';
import 'package:mesran_app/src/shared/presentation/widgets/form/button.dart';

class CreateProfileAkun extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordBController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController passwordKController = TextEditingController();
  CreateProfileAkun({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<PrivateBloc>(),
      child: Scaffold(
        appBar: CustomAppBar(
          leadingText: 'Akun',
        ),
        body: Padding(
          padding: EdgeInsets.all(16.0),
          child: CreateProfileAkunForm(
            controller: UpdatePrivateController(emailController,
                passwordBController, passwordController, passwordKController),
          ),
        ),
        backgroundColor: white,
        bottomNavigationBar: BottomAppBar(
          color: white,
          child: BlocBuilder<PrivateBloc, PrivateState>(
            builder: (context, state) {
              return Button(
                onPressed: () {
                  context.read<PrivateBloc>().add(
                        UpdatePrivate(
                          emailController.text,
                          passwordBController.text,
                          passwordController.text,
                          passwordKController.text,
                        ),
                      );
                },
                child: Text(
                  'Simpan',
                  style: titleOneSemiBold.copyWith(color: white),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
