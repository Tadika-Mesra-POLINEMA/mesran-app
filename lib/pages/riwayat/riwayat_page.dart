import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:mesran_app/utils/icons.dart';
import 'package:mesran_app/utils/themes.dart';

class RiwayatPage extends StatelessWidget {
  const RiwayatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: white,
        title: Padding(
          padding: const EdgeInsets.all(0),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Riyawat',
                  style: headingTwoSemiBold,
                ),
                InkWell(
                    onTap: () => context.push('/notifications'),
                    child: bell.copyWith(color: neutralBase))
              ]),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Center(
            child: Column(
              children: [
                const Gap(16),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(),
                  decoration: BoxDecoration(
                    color: white, // Warna latar belakang
                    borderRadius: BorderRadius.circular(12), // Radius sudut
                    border: Border.all(color: neutral20), // Border
                  ),
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start, // Menyusun konten di kiri
                    children: [
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Happy Birthday',
                                style: titleOneMedium.copyWith(
                                    color: neutralBase)),
                            const Gap(4),
                            Text('Sep 16, 2024',
                                style:
                                    titleTwoRegular.copyWith(color: neutral40)),
                            const Gap(4),
                            Text(
                                'Lorem ipsum dolor sit amet consectetur. Lorem ipsum dolor sit amet.',
                                style:
                                    titleTwoRegular.copyWith(color: neutral40)),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                            color: white,
                            borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(12),
                                bottomRight: Radius.circular(12)),
                            border: Border(
                                top: BorderSide(
                              color: neutral20,
                            ))),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: white,
                                border: Border.all(
                                  color: neutral20,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                children: [
                                  member.copyWith(
                                      color: neutralBase,
                                      width: 18,
                                      height: 18),
                                  const Gap(8),
                                  Text('16 Anggota',
                                      style: titleTwoMedium.copyWith(
                                          color: neutralBase))
                                ],
                              ),
                            ),
                            // Container(
                            //   width: 80,
                            //   child: Stack(
                            //     clipBehavior: Clip.none,
                            //     children: [
                            //       Positioned(
                            //         left:
                            //             0, // Menggeser gambar ketiga lebih ke kanan
                            //         child: SvgPicture.asset(
                            //           'assets/images/orang.jpg',
                            //           width: 28,
                            //           height: 28,
                            //         ),
                            //       ),
                            //       Positioned(
                            //         left:
                            //             20, // Menggeser gambar ketiga lebih ke kanan
                            //         child: SvgPicture.asset(
                            //           'assets/images/orang.jpg',
                            //           width: 28,
                            //           height: 28,
                            //         ),
                            //       ),
                            //       Positioned(
                            //           left:
                            //               40, // Menggeser gambar ketiga lebih ke kanan
                            //           child: SvgPicture.asset(
                            //             'assets/images/orang.jpg',
                            //             width: 20,
                            //             height: 20,
                            //           )),
                            //     ],
                            //   ),
                            // ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
