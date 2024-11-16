import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:mesran_app/components/common/button.dart';
import 'package:mesran_app/components/undo_button.dart';
import 'package:mesran_app/utils/buttons.dart';
import 'package:mesran_app/utils/icons.dart';
import 'package:mesran_app/utils/themes.dart';

class DetailUndanganPage extends StatelessWidget {
  const DetailUndanganPage({super.key});

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
              UndoButton(
                onPressed: () => context.pop(),
              ),
              Text(
                'Undangan',
                style: headingTwoSemiBold.copyWith(color: neutralBase),
              ),
              dot.copyWith(
                color: neutralBase,
                width: 24,
                height: 24,
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Ulang Tahun',
                        style: headingOneSemiBold.copyWith(color: neutralBase)),
                    const Gap(8),
                    Text(
                      'Jangan lupa datang di acara ulang tahunku ya! aku menanti kehadiran kalian semuanya. See you',
                      style: titleOneRegular.copyWith(color: neutral40),
                    ),
                    const Gap(8),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // SizedBox(height: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Tanggal',
                          style: titleOneRegular.copyWith(color: neutral40),
                        ),
                        const Gap(4),
                        Row(
                          children: [
                            date.copyWith(
                              color: neutralBase,
                              width: 20,
                              height: 20,
                            ),
                            const Gap(8),
                            Text('20/10/2024',
                                style: titleOneMedium.copyWith(
                                    color: neutralBase)),
                          ],
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Waktu',
                          style: titleOneRegular.copyWith(color: neutral40),
                        ),
                        const Gap(4),
                        Row(
                          children: [
                            date.copyWith(
                              color: neutralBase,
                              width: 20,
                              height: 20,
                            ),
                            const Gap(8),
                            Text('20/10/2024',
                                style: titleOneMedium.copyWith(
                                    color: neutralBase)),
                            // SizedBox(height: 16)
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
              Divider(
                color: neutral20,
                height: 44,
              ),
              Column(
                children: [
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
                      )
                    ],
                  ),
                  const Gap(8),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: white,
                      border: Border.all(
                        color: neutral20,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              Column(
                                children: [
                                  Image.asset(
                                    'assets/images/orang.jpg',
                                    width: 40,
                                    height: 40,
                                  ),
                                  Text(
                                    'Sherina',
                                    style: titleTwoMedium.copyWith(
                                        color: neutralBase),
                                  )
                                ],
                              ),
                              const Gap(12),
                              Column(
                                children: [
                                  Image.asset(
                                    'assets/images/orang.jpg',
                                    width: 40,
                                    height: 40,
                                  ),
                                  Text(
                                    'Sherina',
                                    style: titleTwoMedium.copyWith(
                                        color: neutralBase),
                                  )
                                ],
                              ),
                              const Gap(12),
                              Column(
                                children: [
                                  Image.asset(
                                    'assets/images/orang.jpg',
                                    width: 40,
                                    height: 40,
                                  ),
                                  Text(
                                    'Sherina',
                                    style: titleTwoMedium.copyWith(
                                        color: neutralBase),
                                  )
                                ],
                              ),
                              const Gap(12),
                              Column(
                                children: [
                                  Image.asset(
                                    'assets/images/orang.jpg',
                                    width: 40,
                                    height: 40,
                                  ),
                                  Text(
                                    'Sherina',
                                    style: titleTwoMedium.copyWith(
                                        color: neutralBase),
                                  )
                                ],
                              ),
                              const Gap(12),
                              Column(
                                children: [
                                  Image.asset(
                                    'assets/images/orang.jpg',
                                    width: 40,
                                    height: 40,
                                  ),
                                  Text(
                                    'Sherina',
                                    style: titleTwoMedium.copyWith(
                                        color: neutralBase),
                                  )
                                ],
                              ),
                              const Gap(12),
                              Column(
                                children: [
                                  Image.asset(
                                    'assets/images/orang.jpg',
                                    width: 40,
                                    height: 40,
                                  ),
                                  Text(
                                    'Sherina',
                                    style: titleTwoMedium.copyWith(
                                        color: neutralBase),
                                  )
                                ],
                              ),
                              const Gap(12),
                              Column(
                                children: [
                                  Image.asset(
                                    'assets/images/orang.jpg',
                                    width: 40,
                                    height: 40,
                                  ),
                                  Text(
                                    'Sherina',
                                    style: titleTwoMedium.copyWith(
                                        color: neutralBase),
                                  )
                                ],
                              ),
                              const Gap(12),
                              Column(
                                children: [
                                  Image.asset(
                                    'assets/images/orang.jpg',
                                    width: 40,
                                    height: 40,
                                  ),
                                  Text(
                                    'Sherina',
                                    style: titleTwoMedium.copyWith(
                                        color: neutralBase),
                                  )
                                ],
                              ),
                              const Gap(12),
                            ],
                          ),
                        ),
                        const Gap(16),
                        Button(
                          onPressed: () {},
                          style: buttonPrimaryBase,
                          child: Text('Lihat Semua',
                              style: titleOneSemiBold.copyWith(color: white)),
                        )
                      ],
                    ),
                  )
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),
                  Text(
                    'Alamat',
                    style: titleOneRegular.copyWith(
                      color: neutral40,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Jl. Soekarno Hatta No. 1, Malang, Jawa Timur, Indonesia',
                    style: titleOneMedium.copyWith(color: neutralBase),
                  ),
                  const SizedBox(height: 4),
                  Container(
                    width: double.infinity,
                    height: 180,
                    decoration: BoxDecoration(
                      color: neutral10,
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  // const SizedBox(height: 4),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),
                  Text(
                    'Tambahan',
                    style: titleOneMedium.copyWith(color: neutralBase),
                  ),
                  Column(
                    children: [
                      Column(
                        children: [
                          const SizedBox(height: 8),
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                                color: white,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: neutral20,
                                )),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Aktivitas',
                                      style: titleOneMedium.copyWith(
                                          color: neutralBase),
                                    ),
                                    Text(
                                      'Lihat Lainnya',
                                      style: titleTwoRegular.copyWith(
                                        color: primaryBase,
                                        decoration: TextDecoration.underline,
                                        decorationColor: primaryBase,
                                        decorationThickness: 1.0,
                                      ),
                                    ),
                                  ],
                                ),
                                Divider(
                                  color: neutral20,
                                  height: 16,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Lari dari kenyataan',
                                      style: titleOneMedium.copyWith(
                                          color: neutralBase),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      '07:00 - 08:00',
                                      style: titleTwoRegular.copyWith(
                                          color: neutral40),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      'Lorem ipsum dolor sit amet consectetur. Nullam t...',
                                      style: titleTwoRegular.copyWith(
                                          color: neutral40),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Column(
                            children: [
                              const SizedBox(height: 8),
                              Container(
                                width: double.infinity,
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                    color: white,
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                      color: neutral20,
                                    )),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Pakaian dan Tema',
                                      style: titleOneMedium.copyWith(
                                          color: neutralBase),
                                    ),
                                    Divider(
                                      color: neutral20,
                                      height: 24,
                                    ),
                                    Row(
                                      // mainAxisAlignment:
                                      // MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Tema',
                                                style: titleTwoRegular.copyWith(
                                                    color: neutral40),
                                              ),
                                              const SizedBox(height: 4),
                                              Text(
                                                'Formal',
                                                style: titleOneMedium.copyWith(
                                                    color: neutralBase),
                                              )
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Pakaian',
                                                style: titleTwoRegular.copyWith(
                                                    color: neutral40),
                                              ),
                                              const SizedBox(height: 4),
                                              Text(
                                                'Formal',
                                                style: titleOneMedium.copyWith(
                                                    color: neutralBase),
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        color: white,
        child: Row(
          children: [
            Expanded(
              child: Container(
                height: 43,
                decoration: BoxDecoration(
                    color: white,
                    borderRadius: BorderRadius.circular(64),
                    border: Border.all(
                      color: neutral20,
                    )),
                child: Center(
                  child: Text(
                    'Edit',
                    style: titleOneSemiBold.copyWith(color: neutralBase),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Container(
                height: 43,
                decoration: BoxDecoration(
                    color: neutral10, borderRadius: BorderRadius.circular(64)),
                child: Center(
                  child: Text(
                    'Absen',
                    style: titleOneSemiBold.copyWith(color: neutral40),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
