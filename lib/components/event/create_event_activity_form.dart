import 'package:flutter/material.dart';
import 'package:mesran_app/utils/themes.dart';

class CreateEventActivityForm extends StatefulWidget {
  const CreateEventActivityForm({super.key});

  @override
  State<CreateEventActivityForm> createState() =>
      _CreateEventActivityFormState();
}

class _CreateEventActivityFormState extends State<CreateEventActivityForm> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Nama Acara', style: titleOneMedium.copyWith(color: neutralBase)),
        const SizedBox(height: 8),
        TextFormField(
          decoration: InputDecoration(
            hintText: 'Masukkan nama',
            hintStyle: titleOne.copyWith(color: neutral40),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: neutral20),
              borderRadius: BorderRadius.circular(12),
            ),
            border: OutlineInputBorder(
                borderSide: BorderSide(color: neutral20),
                borderRadius: BorderRadius.circular(12)),
          ),
        ),
        const SizedBox(height: 16),
        Text('Deskripsi', style: titleOneMedium.copyWith(color: neutralBase)),
        const SizedBox(height: 8),
        TextFormField(
          maxLines: 5,
          decoration: InputDecoration(
            hintText: 'Tulis deskripsi',
            hintStyle: titleOne.copyWith(color: neutral40),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: neutral20),
              borderRadius: BorderRadius.circular(12),
            ),
            border: OutlineInputBorder(
                borderSide: BorderSide(color: neutral20),
                borderRadius: BorderRadius.circular(12)),
          ),
        ),
        const SizedBox(height: 16),
        Text('Waktu', style: titleOneMedium.copyWith(color: neutralBase)),
        const SizedBox(height: 8),
        TextFormField(
          decoration: InputDecoration(
            hintText: 'Pilih waktu',
            hintStyle: titleOne.copyWith(color: neutral40),
            suffixIcon: const Icon(Icons.schedule),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: neutral20),
              borderRadius: BorderRadius.circular(12),
            ),
            border: OutlineInputBorder(
                borderSide: BorderSide(color: neutral20),
                borderRadius: BorderRadius.circular(12)),
          ),
        ),
        const Spacer(),
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(backgroundColor: primaryBase),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Center(
              child:
                  Text('Simpan', style: titleOneMedium.copyWith(color: white)),
            ),
          ),
        ),
      ],
    );
  }
}
