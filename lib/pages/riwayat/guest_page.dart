import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mesran_app/components/bottom_navigation.dart';
import 'package:mesran_app/components/card_template.dart';
import 'package:mesran_app/components/undo_button.dart';
import 'package:mesran_app/pages/message/chat_detail_grup_page.dart';
import 'package:mesran_app/utils/icons.dart';
import 'package:mesran_app/utils/themes.dart';

class GuestPage extends StatelessWidget {
  const GuestPage({super.key});
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: AppBar(
            leading: Padding(
              padding: const EdgeInsets.only(top: 8),
              child: UndoButton(
                onPressed: () => context.pop(),
                label: 'Tamu',
              ),
            ),
            leadingWidth: double.infinity,
            backgroundColor: white,
            automaticallyImplyLeading: false,
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: TextField(
                    style: titleOneRegular,
                    decoration: InputDecoration(
                      hintText: 'Cari anggota...',
                      hintStyle: titleOneRegular.copyWith(color: neutral40),
                      prefixIcon: Icon(Icons.search, color: neutralBase),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(vertical: 15),
                    ),
                  ),
                ),
                SizedBox(height: 16),
                TabBar(
                  indicatorColor: primaryBase,
                  labelColor: primaryBase,
                  unselectedLabelColor: neutral40,
                  tabs: [
                    Tab(
                      child: Text(
                        "Belum Hadir",
                        style: titleOneMedium,
                      ),
                    ),
                    Tab(
                      child: Text(
                        "Hadir",
                        style: titleOneMedium,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Tamu',
                      style: titleOneMedium.copyWith(color: neutralBase),
                    ),
                    Text(
                      '120 hadir',
                      style: titleTwoRegular.copyWith(color: neutral40),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Expanded(
                  child: TabBarView(
                    children: [
                      ListView.builder(
                        itemCount: 5,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Row(
                              children: [
                                CircleAvatar(
                                  radius: 24,
                                  backgroundImage:
                                      AssetImage('assets/images/avatar.jpeg'),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Text(
                                    'Nama Tamu $index',
                                    style: titleOneMedium,
                                  ),
                                ),
                                IconButton(
                                  icon: Icon(Icons.chat_bubble_outline,
                                      color: primaryBase),
                                  onPressed: () {
                                    // Navigasi ke halaman chat pribadi
                                  },
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                      ListView.builder(
                        itemCount: 10,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Row(
                              children: [
                                CircleAvatar(
                                  radius: 24,
                                  backgroundImage:
                                      AssetImage('assets/images/avatar.jpeg'),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Text(
                                    'Nama Tamu $index',
                                    style: titleOneMedium,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                IconButton(
                                  icon: Icon(Icons.chat_bubble_outline,
                                      color: primaryBase),
                                  onPressed: () {},
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () => context.push('/detailMessageGroup'),
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 12),
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(color: neutral20),
                      borderRadius: BorderRadius.circular(64),
                    ),
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(
                        'Kirim Pesan Group',
                        style: titleOneMedium.copyWith(color: neutralBase),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          backgroundColor: white),
    );
  }
}
