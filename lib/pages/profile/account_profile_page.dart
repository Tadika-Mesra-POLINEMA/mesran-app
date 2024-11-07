import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mesran_app/components/bottom_navigation.dart';
import 'package:mesran_app/components/card_template.dart';
import 'package:mesran_app/utils/icons.dart';
import 'package:mesran_app/utils/themes.dart';

class AccountProfilePage extends StatelessWidget {
  const AccountProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    'Profil',
                    style: headingTwoSemiBold,
                  ),
                  InkWell(
                      onTap: () => context.push('/notifications'),
                      child: bell.copyWith(color: neutralBase))
                ]),
          )),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          CircleAvatar(
            radius: 48, // Image radius
            backgroundImage: NetworkImage('assets/images/advertising.png'),
          ),
          Text(
            'Valentina Sherina',
            style: headingThreeSemiBold,
          ),
          Text(
            '+62 342-3435-0933',
            style: titleTwo.copyWith(color: neutral40),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 32),
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
                Row(
                  children: [
                    profile.copyWith(color: neutralBase),
                    const SizedBox(width: 12),
                    Text(
                      'Informasi Pribadi',
                      style: titleOne.copyWith(color: neutralBase),
                    ),
                  ],
                ),
                Icon(
                  Icons.chevron_right,
                  color: neutralBase,
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
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
                Row(
                  children: [
                    setting.copyWith(color: neutralBase),
                    const SizedBox(width: 12),
                    Text(
                      'Akun',
                      style: titleOne.copyWith(color: neutralBase),
                    ),
                  ],
                ),
                Icon(
                  Icons.chevron_right,
                  color: neutralBase,
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
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
                Row(
                  children: [
                    invite.copyWith(color: neutralBase),
                    const SizedBox(width: 12),
                    Text(
                      'Undanganku',
                      style: titleOne.copyWith(color: neutralBase),
                    ),
                  ],
                ),
                Icon(
                  Icons.chevron_right,
                  color: neutralBase,
                ),
              ],
            ),
          ),
          Spacer(
            flex: 12,
          ),
          TextButton(
            onPressed: () {
              showModalBottomSheet(
                backgroundColor: white,
                isDismissible: false,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(24),
                    topRight: Radius.circular(24),
                  ),
                ),
                context: context,
                builder: (context) => SizedBox(
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(height: 20),
                          Center(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'assets/images/advertising.png',
                                  width: 230,
                                  height: 230,
                                ),
                                SizedBox(height: 10),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Ingin keluar dari akun Anda?',
                                      style: TextStyle(
                                        color: neutralBase,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    SizedBox(height: 5),
                                    Text(
                                      'Semua perubahan yang belum disimpan akan hilang, dan Anda harus masuk kembali untuk mengakses fitur.',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: neutral40,
                                        fontWeight: FontWeight.w400,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: () =>
                                      context.push('/account/profile'),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(64),
                                    ),
                                    padding: EdgeInsets.symmetric(vertical: 12),
                                  ),
                                  child: Text(
                                    'TIDAK',
                                    style: TextStyle(
                                        fontSize: 16, color: neutralBase),
                                  ),
                                ),
                              ),
                              SizedBox(width: 10), // Spasi antar tombol
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: () => context.push('/login'),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: primaryBase,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(64),
                                    ),
                                    padding: EdgeInsets.symmetric(vertical: 12),
                                  ),
                                  child: Text(
                                    'IYA',
                                    style: TextStyle(
                                        fontSize: 16, color: Colors.white),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
            style: TextButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                side: BorderSide(color: primary10),
                borderRadius: BorderRadius.circular(64),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Keluar',
                  style: titleOne.copyWith(color: primaryBase),
                ),
              ],
            ),
          ),
        ]),
      ),
      backgroundColor: white,
      bottomNavigationBar: const BottomNavigation(),
    );
  }
}
