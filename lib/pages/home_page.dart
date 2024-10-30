import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mesran_app/components/bottom_navigation.dart';
import 'package:mesran_app/components/card_template.dart';
import 'package:mesran_app/utils/icons.dart';
import 'package:mesran_app/utils/themes.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

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
                    'Halo, Selamat Datang!',
                    style: headingTwoSemiBold,
                  ),
                  bell.copyWith(color: neutralBase)
                ]),
          )),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              Center(
                child: DottedBorder(
                    color: neutral20,
                    borderType: BorderType.RRect,
                    radius: const Radius.circular(12),
                    strokeWidth: 1,
                    dashPattern: const [12, 12],
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 24),
                              child: Column(
                                children: [
                                  Image.asset(
                                    'assets/images/advertising.png',
                                    width: 200,
                                    height: 200,
                                  ),
                                  Text(
                                    'Buat acara Anda disini!',
                                    style: headingThreeSemiBold,
                                  ),
                                  Text(
                                    'Rencanakan acara Anda dengan mudah disini. Isi form dan kelola semuanya dalam satu tempat!',
                                    style: titleTwo,
                                    textAlign: TextAlign.center,
                                  )
                                ],
                              ),
                            ),
                            ElevatedButton(
                                onPressed: () => context.push('/events/create'),
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: primaryBase),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 18, vertical: 10),
                                  child: Text(
                                    'Buat Acara',
                                    style: titleOne.copyWith(color: white),
                                  ),
                                ))
                          ],
                        ),
                      ),
                    )),
              ),
              const SizedBox(height: 24),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Template',
                      style: headingThreeMedium.copyWith(color: neutralBase),
                      textAlign: TextAlign.start,
                    ),
                    const SizedBox(height: 12),
                    const SizedBox(
                      height: 250,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            CardTemplate(),
                            SizedBox(width: 12),
                            CardTemplate(),
                            SizedBox(width: 12),
                            CardTemplate(),
                            SizedBox(width: 12),
                            CardTemplate(),
                            SizedBox(width: 12),
                            CardTemplate(),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: white,
      bottomNavigationBar: const BottomNavigation(),
    );
  }
}
