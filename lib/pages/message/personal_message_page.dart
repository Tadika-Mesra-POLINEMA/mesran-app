import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mesran_app/components/bottom_navigation.dart';
import 'package:go_router/go_router.dart';
import 'package:mesran_app/utils/icons.dart';
import 'package:mesran_app/utils/themes.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key}); // Menambahkan constructor dengan super.key

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // Jumlah tab
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          title: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Pesan',
                  style: headingTwoSemiBold,
                ),
                InkWell(
                  onTap: () => context.push('/notifications'),
                  child: bell.copyWith(color: neutralBase),
                ),
              ],
            ),
          ),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(80), // Sesuaikan tinggi tab
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    children: [
                      Expanded(
                        // Memungkinkan kotak pencarian untuk memanjang
                        child: InkWell(
                          onTap: () {
                            // Aksi ketika tombol pencarian ditekan
                            print('Tombol Cari ditekan!');
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 12, horizontal: 10),
                            decoration: BoxDecoration(
                              color: Colors.white, // Warna latar belakang
                              borderRadius:
                                  BorderRadius.circular(24), // Radius sudut
                              border: Border.all(
                                  color: Colors.grey[300]!), // Border
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.search,
                                  color: const Color.fromARGB(
                                      255, 0, 0, 0), // Warna ikon
                                ),
                                const SizedBox(
                                    width: 8), // Jarak antara ikon dan teks
                                Text(
                                  'Cari',
                                  style: TextStyle(
                                    fontFamily: 'SF-Pro-Display',
                                    color: neutral40, // Warna teks
                                    fontSize: 16, // Ukuran teks
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                TabBar(
                  indicatorColor: primaryBase, // Warna khusus #FE4F34
                  labelColor: primaryBase, // Warna teks yang dipilih
                  unselectedLabelColor:
                      neutral40, // Warna teks yang tidak aktif
                  tabs: const [
                    Tab(text: "Pribadi"),
                    Tab(text: "Grup"),
                  ],
                ),
              ],
            ),
          ),
        ),
        body: const TabBarView(
          children: [
            ChatTabContent(), // Konten untuk tab Pribadi
            Center(
                child:
                    Text("Tidak ada percakapan grup")), // Konten untuk tab Grup
          ],
        ),
        bottomNavigationBar:
            const BottomNavigation(), // Menambahkan Bottom Navigation
      ),
    );
  }
}

class ChatTabContent extends StatelessWidget {
  const ChatTabContent({super.key}); // Menambahkan constructor dengan super.key

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //Icon(Icons.search, color: Colors.grey[400]), // Ikon pencarian
            const SizedBox(height: 20),
            SvgPicture.asset(
              'assets/images/no-email.svg', // Gambar SVG jika tidak ada percakapan
              height: 150,
            ),
            const SizedBox(height: 20),
            Text(
              "Tidak ada percakapan", // Pesan tidak ada percakapan
              style: TextStyle(
                fontFamily: 'SF-Pro-Display',
                fontSize: 18, // Ukuran teks 20px
                fontWeight: FontWeight.w600, // Semibold
                height: 1.2, // Tinggi baris 24px (sekitar 1.2 kali ukuran font)
              ),
            ),
            const SizedBox(height: 10),
            Text(
              "Anda belum mempunyai aktivitas tambahan disini. Segera buat dan buat acara Anda makin luar biasa!",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'SF-Pro-Display',
                color: neutral40, // Warna teks
                fontSize: 14, // Ukuran teks 16px
                height: 1.5, // Tinggi baris dapat disesuaikan
              ),
            ),
          ],
        ),
      ),
    );
  }
}
