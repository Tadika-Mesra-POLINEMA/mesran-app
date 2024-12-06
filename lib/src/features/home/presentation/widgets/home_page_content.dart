import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:mesran_app/src/config/styles/icons/custom.dart';
import 'package:mesran_app/src/config/styles/texts/medium.dart';
import 'package:mesran_app/src/config/styles/texts/semibold.dart';
import 'package:mesran_app/src/config/styles/themes/colors/neutral.dart';
import 'package:mesran_app/src/features/home/domain/entity/event.dart';
import 'package:mesran_app/src/features/home/presentation/bloc/home_page_bloc.dart';
import 'package:mesran_app/src/features/home/presentation/bloc/home_page_event.dart';
import 'package:mesran_app/src/features/home/presentation/bloc/home_page_state.dart';
import 'package:mesran_app/src/features/home/presentation/widgets/hero.dart';
import 'package:mesran_app/src/features/home/presentation/widgets/invitation_card_home.dart';
import 'package:mesran_app/src/shared/presentation/widgets/bottom_navigation.dart';

class HomePageContent extends StatefulWidget {
  const HomePageContent({super.key});

  @override
  State<HomePageContent> createState() => _HomePageContentState();
}

class _HomePageContentState extends State<HomePageContent> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      if (mounted) {
        context.read<HomePageBloc>().add(HomePageEventLoad());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomePageBloc, HomePageState>(
        listener: (_, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: white,
              title: const AppBarHomePage(),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Acara akan datang',
                      style: headingThreeMedium.copyWith(color: neutralBase),
                    ),
                    const Gap(12),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: min(state.items.length, 3),
                      itemBuilder: (context, index) {
                        final EventHome event = state.items[index];

                        return Column(
                          children: [
                            InvitationCardHome(
                              content: InvitationContentHome(
                                onTap: () {
                                  context.push('/account/invitation',
                                      extra: {'event_id': state.items[index]});
                                },
                                name: event.name,
                                date: event.date,
                                desc: event.description,
                              ),
                            ),
                            Gap(8)
                          ],
                        );
                      },
                    ),
                    const Gap(16),
                    const Center(child: HeroSection()),
                  ],
                ),
              ),
            ),
            backgroundColor: white,
            bottomNavigationBar: const BottomNavigation(
              path: BottomNavigationPath.home,
            ),
          );
        });
  }
}

class AppBarHomePage extends StatelessWidget {
  const AppBarHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
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
            child: bell.copyWith(color: neutralBase),
          ),
        ],
      ),
    );
  }
}
