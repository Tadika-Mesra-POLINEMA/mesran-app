import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:mesran_app/components/undo_button.dart';
import 'package:mesran_app/utils/icons.dart';
import 'package:mesran_app/utils/themes.dart';

class DetailUndangan1Page extends StatelessWidget {
  const DetailUndangan1Page({super.key});

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
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(12),
                    width: double.infinity,
                    // height: 73,
                    decoration: BoxDecoration(
                      color: neutral10,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [
                        Text(
                          'Undangan untuk:',
                          style: titleOneRegular.copyWith(color: neutral40),
                        ),
                        const Gap(8),
                        Text(
                          'Valentina Sherina',
                          style:
                              headingThreeSemiBold.copyWith(color: neutralBase),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                              style:
                                  titleOneMedium.copyWith(color: neutralBase),
                            ),
                            Divider(
                              color: neutral20,
                              height: 24,
                            ),
                            Row(
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
    );
  }
}
