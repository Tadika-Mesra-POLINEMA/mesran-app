import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mesran_app/utils/themes.dart';

class CreateEventForm extends StatelessWidget {
  const CreateEventForm({super.key});

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
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Alamat', style: titleOneMedium.copyWith(color: neutralBase)),
            Text(
              'Buka Peta',
              style: titleTwo.copyWith(
                  color: primaryBase,
                  decoration: TextDecoration.underline,
                  decorationColor: primaryBase),
            )
          ],
        ),
        const SizedBox(height: 8),
        TextFormField(
          decoration: InputDecoration(
            hintText: 'Tulis alamat',
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
        Text('Tanggal', style: titleOneMedium.copyWith(color: neutralBase)),
        const SizedBox(height: 8),
        TextFormField(
          decoration: InputDecoration(
            hintText: 'Pilih tanggal',
            hintStyle: titleOne.copyWith(color: neutral40),
            suffixIcon: Icon(
              Icons.event,
              color: neutralBase,
            ),
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
        Text('Hari & Waktu',
            style: titleOneMedium.copyWith(color: neutralBase)),
        const SizedBox(height: 16),
        Text('Tambahan', style: titleOneMedium.copyWith(color: neutralBase)),
        const SizedBox(height: 8),
        TextButton(
          onPressed: () => context.push('/events/activities'),
          style: TextButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              side: BorderSide(color: neutral20),
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Aktivitas',
                style: titleOne.copyWith(color: neutral40),
              ),
              Icon(
                Icons.chevron_right,
                color: neutral40,
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        TextButton(
          onPressed: () {
            // Add your button's action here
          },
          style: TextButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            backgroundColor:
                Colors.white, // Background color similar to TextFormField
            shape: RoundedRectangleBorder(
              side: BorderSide(color: neutral20),
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Pakaian dan Tema',
                style: titleOne.copyWith(color: neutral40),
              ),
              Icon(
                Icons.chevron_right,
                color: neutral40,
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        const Spacer(),
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(backgroundColor: primaryBase),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text('Buat', style: titleOneMedium.copyWith(color: white)),
            ),
          ),
        ),
      ],
    );
  }
}
