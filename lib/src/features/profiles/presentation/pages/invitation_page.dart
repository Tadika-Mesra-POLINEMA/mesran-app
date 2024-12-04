import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:mesran_app/src/config/styles/icons/custom.dart';
import 'package:mesran_app/src/config/styles/texts/medium.dart';
import 'package:mesran_app/src/config/styles/texts/regular.dart';
import 'package:mesran_app/src/config/styles/texts/semibold.dart';
import 'package:mesran_app/src/config/styles/themes/colors/error.dart';
import 'package:mesran_app/src/config/styles/themes/colors/neutral.dart';
import 'package:mesran_app/src/config/styles/themes/colors/primary.dart';
import 'package:mesran_app/src/shared/presentation/widgets/custom_app_bar.dart';
import 'package:mesran_app/src/shared/presentation/widgets/form/button.dart';

class InvitationPage extends StatelessWidget {
  const InvitationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: CustomAppBar(
        middleText: 'Undangan',
        endSection: GestureDetector(
          onTap: () {
            showModalBottomSheet(
              backgroundColor: white,
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
                    child: IntrinsicHeight(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(height: 20),
                          Center(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'assets/images/faq.png',
                                  width: 230,
                                  height: 230,
                                ),
                                SizedBox(height: 10),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Ingin menghapus undangan?',
                                      style: TextStyle(
                                        color: neutralBase,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    SizedBox(height: 5),
                                    Text(
                                      'Sudah yakin dengan keputusan anda ingin sekali menghapus undangan ini?',
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
                                  child: Button(
                                onPressed: () => context.pop(),
                                type: ButtonType.secondary,
                                child: Text('Tidak',
                                    style: titleOneSemiBold.copyWith(
                                        color: neutralBase)),
                              )),
                              SizedBox(width: 10),
                              Expanded(
                                  child: Button(
                                onPressed: () {},
                                child: Text('Iya',
                                    style: titleOneSemiBold.copyWith(
                                        color: white)),
                              )),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
          child: trash.copyWith(color: errorBase),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: neutral10,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Undangan untuk:',
                        style: titleOne.copyWith(color: neutral40),
                      ),
                      Gap(8),
                      Text(
                        'Valentina Sherina',
                        style: headingThree.copyWith(color: neutralBase),
                      ),
                    ],
                  ),
                ),
              ),
              Gap(16),
              SizedBox(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Ulang Tahun',
                        style: headingOneSemiBold.copyWith(color: neutralBase)),
                    Gap(8),
                    Text(
                      'Jangan lupa datang di acara ulang tahunku ya! aku menanti kehadiran kalian semuanya. See you',
                      style: titleOneRegular.copyWith(color: neutral40),
                    ),
                    Gap(8),
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
                        Gap(4),
                        Row(
                          children: [
                            date.copyWith(
                              color: neutralBase,
                              width: 20,
                              height: 20,
                            ),
                            Gap(8),
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
                        Gap(4),
                        Row(
                          children: [
                            date.copyWith(
                              color: neutralBase,
                              width: 20,
                              height: 20,
                            ),
                            Gap(8),
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Gap(16),
                  Text(
                    'Alamat',
                    style: titleOneRegular.copyWith(
                      color: neutral40,
                    ),
                  ),
                  Gap(4),
                  Text(
                    'Jl. Soekarno Hatta No. 1, Malang, Jawa Timur, Indonesia',
                    style: titleOneMedium.copyWith(color: neutralBase),
                  ),
                  Gap(4),
                  Container(
                    width: double.infinity,
                    height: 180,
                    decoration: BoxDecoration(
                      color: neutral10,
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  // Gap(4),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Gap(16),
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
                                    Gap(4),
                                    Text(
                                      '07:00 - 08:00',
                                      style: titleTwoRegular.copyWith(
                                          color: neutral40),
                                    ),
                                    Gap(4),
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
                                              Gap(4),
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
                                              Gap(4),
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
              Gap(16),
            ],
          ),
        ),
      ),
    );
  }
}
