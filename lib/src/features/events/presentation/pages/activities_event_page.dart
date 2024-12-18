import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:mesran_app/src/config/injectors/injector.dart';
import 'package:mesran_app/src/config/styles/icons/custom.dart';
import 'package:mesran_app/src/config/styles/texts/regular.dart';
import 'package:mesran_app/src/config/styles/themes/colors/error.dart';
import 'package:mesran_app/src/config/styles/themes/colors/neutral.dart';
import 'package:mesran_app/src/config/styles/themes/colors/primary.dart';
import 'package:mesran_app/src/features/events/presentation/bloc/create_event_activity_bloc.dart';
import 'package:mesran_app/src/features/events/presentation/bloc/create_event_activity_event.dart';
import 'package:mesran_app/src/features/events/presentation/bloc/create_event_activity_state.dart';
import 'package:mesran_app/src/features/events/presentation/widgets/not_found_event_activities_page.dart';
import 'package:mesran_app/src/shared/presentation/widgets/custom_app_bar.dart';
import 'package:timeline_tile/timeline_tile.dart';

class ActivitiesEventPage extends StatelessWidget {
  const ActivitiesEventPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => getIt<CreateEventActivityBloc>(),
        child: const EventActivitiesContent());
  }
}

class EventActivitiesContent extends StatefulWidget {
  const EventActivitiesContent({super.key});

  @override
  State<EventActivitiesContent> createState() => _EventActivitiesContentState();
}

class _EventActivitiesContentState extends State<EventActivitiesContent> {
  @override
  void initState() {
    super.initState();
    if (mounted) {
      context.read<CreateEventActivityBloc>().add(LoadActivities());
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CreateEventActivityBloc, CreateEventActivityState>(
        listener: (_, state) {},
        builder: (context, state) {
          if (state.savedNames.isEmpty &&
              state.savedDescriptions.isEmpty &&
              state.savedTimeRanges.isEmpty) {
            return const NotFoundEventActivities();
          }

          final itemLength = state.savedNames.length;

          return Scaffold(
            appBar: CustomAppBar(
              leadingText: 'Aktivitas',
              onBack: () => context.go('/events/create'),
              endSection: GestureDetector(
                onTap: () => context.push('/events/activities/create'),
                child: Text(
                  'Tambah',
                  style: titleTwo.copyWith(color: primaryBase),
                ),
              ),
            ),
            backgroundColor: white,
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ListView.builder(
                itemCount: itemLength,
                itemBuilder: (BuildContext context, int index) {
                  return TimelineTile(
                    isFirst: index == 0,
                    isLast: index == itemLength - 1,
                    indicatorStyle: IndicatorStyle(
                      width: 12,
                      height: 12,
                      color: primaryBase,
                      indicatorXY: 0.25,
                    ),
                    afterLineStyle: LineStyle(
                      thickness: 2,
                      color: neutral20,
                    ),
                    beforeLineStyle: LineStyle(
                      thickness: 2,
                      color: neutral20,
                    ),
                    endChild: Padding(
                      padding: const EdgeInsets.only(left: 16),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      state.savedNames[index],
                                      style:
                                          titleOne.copyWith(color: neutralBase),
                                    ),
                                    const Spacer(),
                                    GestureDetector(
                                      onTap: () {
                                        context
                                            .read<CreateEventActivityBloc>()
                                            .add(
                                              RemoveActivity(index),
                                            );
                                      },
                                      child: trash.copyWith(color: errorBase),
                                    ),
                                  ],
                                ),
                                Gap(4),
                                Text(
                                  '${state.savedTimeRanges[index].startTime.hour.toString().padLeft(2, '0')}:${state.savedTimeRanges[index].startTime.minute.toString().padLeft(2, '0')} - ${state.savedTimeRanges[index].endTime.hour.toString().padLeft(2, '0')}:${state.savedTimeRanges[index].endTime.minute.toString().padLeft(2, '0')}',
                                  style: titleTwo.copyWith(color: neutral40),
                                ),
                                Gap(4),
                                Text(
                                  state.savedDescriptions[index],
                                  style: titleTwo.copyWith(color: neutral40),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        });
  }
}
