import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mesran_app/src/config/injector.dart';
import 'package:mesran_app/src/config/styles/texts/semibold.dart';
import 'package:mesran_app/src/config/styles/themes/colors/neutral.dart';
import 'package:mesran_app/src/features/profiles/presentation/bloc/account_bloc.dart';
import 'package:mesran_app/src/features/profiles/presentation/bloc/account_event.dart';
import 'package:mesran_app/src/features/profiles/presentation/bloc/account_state.dart';
import 'package:mesran_app/src/features/profiles/presentation/widgets/create_profile_pribadi_form.dart';
import 'package:mesran_app/src/shared/presentation/widgets/custom_app_bar.dart';
import 'package:mesran_app/src/shared/presentation/widgets/form/button.dart';

class CreateProfilePribadi extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  CreateProfilePribadi({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<AccountBloc>(),
      child: Scaffold(
        appBar: CustomAppBar(
          leadingText: 'Akun',
        ),
        body: Padding(
          padding: EdgeInsets.all(16.0),
          child: CreateProfilePribadiForm(
            controllers:
                UpdateProfileController(nameController, phoneController),
          ),
        ),
        backgroundColor: white,
        bottomNavigationBar: BottomAppBar(
          color: white,
          child: BlocBuilder<AccountBloc, AccountState>(
            builder: (context, state) {
              return Button(
                  onPressed: () {
                    context.read<AccountBloc>().add(UpdateAccount(
                          nameController.text,
                          phoneController.text,
                        ));
                  },
                  child: Text(
                    'Simpan',
                    style: titleOneSemiBold.copyWith(color: white),
                  ));
            },
          ),
        ),
      ),
    );
  }
}
