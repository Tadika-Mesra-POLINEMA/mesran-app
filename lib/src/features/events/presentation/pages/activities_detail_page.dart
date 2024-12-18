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
import 'package:mesran_app/src/features/events/presentation/bloc/activity_detail_bloc.dart';
import 'package:mesran_app/src/features/events/presentation/bloc/activity_detail_event.dart';
import 'package:mesran_app/src/features/events/presentation/bloc/activity_detail_state.dart';
import 'package:mesran_app/src/shared/presentation/widgets/custom_app_bar.dart';
import 'package:timeline_tile/timeline_tile.dart';

class ActivitiesDetailPage extends StatelessWidget {
  final String eventId;
  final bool isOwner;

  const ActivitiesDetailPage(
      {super.key, required this.eventId, required this.isOwner});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => getIt<ActivityDetailBloc>(),
        child: EventActivitiesContent(
          eventId: eventId,
          isOwner: isOwner,
        ));
  }
}

class EventActivitiesContent extends StatefulWidget {
  final String eventId;
  final bool isOwner;

  const EventActivitiesContent(
      {super.key, required this.eventId, required this.isOwner});

  @override
  State<EventActivitiesContent> createState() => _EventActivitiesContentState();
}

class _EventActivitiesContentState extends State<EventActivitiesContent> {
  @override
  void initState() {
    super.initState();
    if (mounted) {
      context
          .read<ActivityDetailBloc>()
          .add(FetchActivityDetail(eventId: widget.eventId));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ActivityDetailBloc, ActivityDetailState>(
        buildWhen: (previous, current) =>
            previous.activities != current.activities,
        builder: (context, state) {
          final activities = state.activities;

          return Scaffold(
            appBar: CustomAppBar(
              leadingText: 'Aktivitas',
              onBack: () => context.go('/events/${widget.eventId}'),
              endSection: GestureDetector(
                onTap: () =>
                    context.push('/events/${widget.eventId}/activities/add'),
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
                itemCount: activities.length,
                itemBuilder: (BuildContext context, int index) {
                  return TimelineTile(
                    isFirst: index == 0,
                    isLast: index == 5 - 1,
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
                                      activities[index].name,
                                      style:
                                          titleOne.copyWith(color: neutralBase),
                                    ),
                                    const Spacer(),
                                    if (widget.isOwner)
                                      GestureDetector(
                                        onTap: () {
                                          context
                                              .read<ActivityDetailBloc>()
                                              .add(
                                                RemoveActivity(
                                                    eventId: widget.eventId,
                                                    activityId:
                                                        activities[index].id),
                                              );
                                        },
                                        child: trash.copyWith(color: errorBase),
                                      )
                                  ],
                                ),
                                Gap(4),
                                Text(
                                  '${activities[index].start.hour.toString().padLeft(2, '0')}:${activities[index].start.minute.toString().padLeft(2, '0')} - ${activities[index].end.hour.toString().padLeft(2, '0')}:${activities[index].end.minute.toString().padLeft(2, '0')}',
                                  style: titleTwo.copyWith(color: neutral40),
                                ),
                                Gap(4),
                                Text(
                                  activities[index].description,
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
