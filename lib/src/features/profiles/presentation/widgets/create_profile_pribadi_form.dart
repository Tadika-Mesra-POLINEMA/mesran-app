import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:mesran_app/src/config/styles/icons/custom.dart';
import 'package:mesran_app/src/shared/presentation/widgets/form/input_field.dart';
import 'package:mesran_app/src/shared/presentation/widgets/form/input_label.dart';

class CreateProfilePribadiForm extends StatelessWidget {
  final TextEditingController namaController = TextEditingController();
  final TextEditingController nohp = TextEditingController();

  CreateProfilePribadiForm({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InputLabel(label: 'Nama'),
        Gap(8),
        InputField(
            controller: namaController,
            prefixIcon: profile,
            hintText: 'Masukkan nama Anda'),
        Gap(16),
        InputLabel(label: 'No. Hp'),
        Gap(8),
        InputField(
            controller: nohp,
            keyboardType: TextInputType.number,
            formatInput: [
              FilteringTextInputFormatter.digitsOnly,
            ],
            prefixIcon: mobileDevice,
            hintText: 'Masukkan No. Hp Anda'),
      ],
    );
  }
}
