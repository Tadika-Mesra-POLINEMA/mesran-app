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
          backgroundColor: white,
          title: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Halo, Selamat Datang!',
                    style: headingTwoSemiBold,
                  ),
                  InkWell(
                      onTap: () => context.push('/notifications'),
                      child: bell.copyWith(color: neutralBase))
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
                                    scale: 2,
                                  ),
                                  Text(
                                    'Buat acara Anda disini!',
                                    style: headingThreeSemiBold,
                                  ),
                                  Text(
                                    'Rencanakan acara Anda dengan mudah disini. Isi form dan kelola semuanya dalam satu tempat!',
                                    style: titleTwoRegular.copyWith(
                                        color: neutral40),
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
                                    style:
                                        titleOneSemiBold.copyWith(color: white),
                                  ),
                                ))
                          ],
                        ),
                      ),
                    )),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
      backgroundColor: white,
      bottomNavigationBar: const BottomNavigation(),
    );
  }
}
