import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:mesran_app/src/config/injectors/injector.dart';
import 'package:mesran_app/src/config/styles/icons/custom.dart';
import 'package:mesran_app/src/config/styles/texts/medium.dart';
import 'package:mesran_app/src/config/styles/texts/regular.dart';
import 'package:mesran_app/src/config/styles/texts/semibold.dart';
import 'package:mesran_app/src/config/styles/themes/colors/neutral.dart';
import 'package:mesran_app/src/features/history/presentation/bloc/history_bloc.dart';
import 'package:mesran_app/src/features/history/presentation/bloc/history_event.dart';
import 'package:mesran_app/src/features/history/presentation/bloc/history_state.dart';
import 'package:mesran_app/src/shared/presentation/widgets/bottom_navigation.dart';
import 'package:mesran_app/src/shared/presentation/widgets/loader.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<HistoryBloc>()..add(HistoryLoad()),
      child: const HistoryPageContent(),
    );
  }
}

class HistoryPageContent extends StatefulWidget {
  const HistoryPageContent({super.key});

  @override
  State<HistoryPageContent> createState() => _HistoryPageContentState();
}

class _HistoryPageContentState extends State<HistoryPageContent> {
  @override
  void dispose() {
    super.dispose();
    context.read<HistoryBloc>().close();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HistoryBloc, HistoryState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: white,
          appBar: _buildAppBar(),
          body: _buildBody(context, state),
          bottomNavigationBar: const BottomNavigation(
            path: BottomNavigationPath.history,
          ),
        );
      },
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: white,
      title: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Riwayat',
              style: headingTwoSemiBold,
            ),
            InkWell(
              onTap: () => context.push('/notifications'),
              child: bell.copyWith(color: neutralBase),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context, HistoryState state) {
    if (state is HistoryLoading) {
      return const Center(child: Loader());
    } else if (state is HistoryLoaded) {
      if (state.events.isEmpty) {
        return _buildEmptyState();
      } else {
        return RefreshIndicator(
          onRefresh: () async {
            context.read<HistoryBloc>().add(HistoryLoad());
          },
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: state.events.length,
            separatorBuilder: (context, index) => const Gap(12),
            itemBuilder: (context, index) {
              final event = state.events[index];
              return GestureDetector(
                onTap: () {
                  context.push('/events/${event.id}');
                },
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: neutral20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          event.name,
                          style: titleOneMedium.copyWith(color: neutralBase),
                        ),
                        const Gap(4),
                        Text(
                          DateFormat.yMMMMd('id_ID').format(event.date),
                          style: titleTwoRegular.copyWith(color: neutral40),
                        ),
                        const Gap(4),
                        Text(
                          event.description,
                          style: titleTwoRegular.copyWith(color: neutral40),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        );
      }
    } else if (state is HistoryError) {
      return Center(
        child: Text(
          'Gagal memuat data: ${state.message}',
          style: const TextStyle(color: Colors.red),
        ),
      );
    } else {
      return const Center(child: Text('Tidak ada data yang ditampilkan.'));
    }
  }

  Widget _buildEmptyState() {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Container(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/images/finding.png'),
                  const Gap(8),
                  const Text(
                    'Tidak ada riwayat',
                    // style: TextStyle(fontSize: 16, color: neutral40),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
