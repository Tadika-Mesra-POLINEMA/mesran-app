import 'package:flutter/material.dart';
import 'package:mesran_app/utils/themes.dart';
import 'package:go_router/go_router.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SuccessPage(),
    );
  }
}

class SuccessPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Mengatur warna latar belakang Scaffold
      body: SingleChildScrollView(
        // Menambahkan SingleChildScrollView
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start, // Posisi awal
            children: [
              const SizedBox(height: 170), // Menambahkan jarak di atas
              // Gambar ilustrasi
              Image.asset(
                'assets/images/finding.png',
                height: 200,
              ),
              const SizedBox(height: 24),
              // Teks judul
              Text(
                'Anda sudah membuat acara terbaru!',
                style: headingThreeSemiBold,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              // Teks deskripsi
              Text(
                'Acara terbaru Anda sudah berhasil dibuat!\nBagikan dan nikmati acaranya.',
                style: titleTwoRegular,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              // Tombol Lihat Acara Saya
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryBase, // Warna latar belakang tombol
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  onPressed: () {
                    context.go('/my-events'); // Navigasi ke halaman acara saya
                  },
                  child: Text(
                    'Lihat Acara Saya',
                    style: titleTwoSemiBold.copyWith(
                        color: Colors.white), // Pastikan warna putih
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // Tombol Kembali ke Beranda
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    side: BorderSide(color: neutral20), // Warna border tombol
                  ),
                  onPressed: () {
                    context.go('/home'); // Navigasi kembali ke beranda
                  },
                  child: Text(
                    'Kembali ke Beranda',
                    style: titleTwoSemiBold.copyWith(color: neutralBase),
                  ),
                ),
              ),
              const SizedBox(height: 24), // Jarak di bawah
            ],
          ),
        ),
      ),
    );
  }
}
