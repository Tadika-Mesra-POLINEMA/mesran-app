import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:mesran_app/src/config/styles/themes/colors/primary.dart';
import 'package:skeletonizer/skeletonizer.dart';
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
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (mounted) {
      context.read<HomePageBloc>().add(HomePageEventLoad());
    }
  }

  @override
  void dispose() {
    super.dispose();
    context.read<HomePageBloc>().close();
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
          body: RefreshIndicator(
            onRefresh: () async {
              context.read<HomePageBloc>().add(HomePageEventLoad());
            },
            color: primaryBase,
            backgroundColor: white,
            child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
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
                    Column(
                      children: [
                        if (state.items.isNotEmpty)
                          SizedBox(
                            height: 180,
                            child: Skeletonizer(
                              enabled: state.isLoading,
                              child: PageView.builder(
                                itemCount: state.items.length,
                                controller:
                                    PageController(viewportFraction: 1.012),
                                itemBuilder: (context, index) {
                                  final EventHome event = state.items[index];

                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: InvitationCardHome(
                                      content: InvitationContentHome(
                                        onTap: () {
                                          context.push('/events/${event.id}');
                                        },
                                        name: event.name,
                                        date: event.date,
                                        desc: event.description,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        if (state.items.isEmpty)
                          Skeletonizer(
                            enabled: state.isLoading,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: neutral10,
                              ),
                              height: 160,
                              child: Center(
                                child: Text(
                                  'Tidak ada acara yang akan datang',
                                  style:
                                      titleOneMedium.copyWith(color: neutral40),
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                    const Gap(16),
                    const Center(child: HeroSection()),
                    Gap(12),
                  ],
                ),
              ),
            ),
          ),
          backgroundColor: white,
          bottomNavigationBar: const BottomNavigation(
            path: BottomNavigationPath.home,
          ),
        );
      },
    );
  }
}

class AppBarHomePage extends StatelessWidget {
  const AppBarHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomePageBloc, HomePageState>(
        buildWhen: (previous, current) => previous.user != current.user,
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Halo ${state.user?.firstName}, Selamat Datang!',
                  style: headingTwoSemiBold,
                ),
                InkWell(
                  onTap: () => context.push('/notifications'),
                  child: bell.copyWith(color: neutralBase),
                ),
              ],
            ),
          );
        });
  }
}
