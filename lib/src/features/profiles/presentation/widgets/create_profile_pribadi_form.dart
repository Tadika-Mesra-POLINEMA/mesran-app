import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:mesran_app/src/config/styles/icons/custom.dart';
import 'package:mesran_app/src/features/profiles/presentation/bloc/account_bloc.dart';
import 'package:mesran_app/src/features/profiles/presentation/bloc/account_state.dart';
import 'package:mesran_app/src/shared/presentation/widgets/form/input_field.dart';
import 'package:mesran_app/src/shared/presentation/widgets/form/input_label.dart';

class CreateProfilePribadiForm extends StatelessWidget {
  final UpdateProfileController controllers;

  const CreateProfilePribadiForm({super.key, required this.controllers});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AccountBloc, AccountState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InputLabel(label: 'Nama'),
              Gap(8),
              InputField(
                  controller: controllers.nameController,
                  prefixIcon: profile,
                  hintText: 'Masukkan nama Anda'),
              Gap(16),
              InputLabel(label: 'No. Hp'),
              Gap(8),
              InputField(
                  controller: controllers.phoneController,
                  keyboardType: TextInputType.number,
                  formatInput: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  prefixIcon: mobileDevice,
                  hintText: 'Masukkan No. Hp Anda'),
            ],
          );
        });
  }
}

class UpdateProfileController {
  final TextEditingController nameController;
  final TextEditingController phoneController;

  UpdateProfileController(this.nameController, this.phoneController);
}
