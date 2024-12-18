import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:go_router/go_router.dart';
import 'package:mesran_app/src/config/injectors/injector.dart';
import 'package:mesran_app/src/config/routes/event.route.dart';
import 'package:mesran_app/src/config/styles/icons/custom.dart';
import 'package:mesran_app/src/config/styles/texts/medium.dart';
import 'package:mesran_app/src/config/styles/texts/regular.dart';
import 'package:mesran_app/src/config/styles/texts/semibold.dart';
import 'package:mesran_app/src/config/styles/themes/colors/custom.dart';
import 'package:mesran_app/src/config/styles/themes/colors/error.dart';
import 'package:mesran_app/src/config/styles/themes/colors/neutral.dart';
import 'package:mesran_app/src/config/styles/themes/colors/primary.dart';
import 'package:mesran_app/src/features/events/presentation/bloc/event_detail_bloc.dart';
import 'package:mesran_app/src/features/events/presentation/bloc/event_detail_event.dart';
import 'package:mesran_app/src/features/events/presentation/bloc/event_detail_state.dart';
import 'package:mesran_app/src/features/events/presentation/widgets/event_detail_skeleton.dart';
import 'package:mesran_app/src/features/events/presentation/widgets/share_bottom_sheet_content.dart';
import 'package:mesran_app/src/shared/presentation/widgets/custom_app_bar.dart';
import 'package:mesran_app/src/shared/presentation/widgets/form/button.dart';
import 'package:skeletonizer/skeletonizer.dart';

class EventDetailPage extends StatelessWidget {
  final String eventId;

  const EventDetailPage({super.key, required this.eventId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<EventDetailBloc>()..add(EventDetailLoad(eventId)),
      child: _EventDetailContent(id: eventId),
    );
  }
}

class _EventDetailContent extends StatefulWidget {
  final String id;

  const _EventDetailContent({required this.id});

  @override
  State<_EventDetailContent> createState() => _EventDetailContentState();
}

class _EventDetailContentState extends State<_EventDetailContent> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      if (mounted) {
        context.read<EventDetailBloc>().add(EventDetailLoad(widget.id));
      }
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (mounted) {
      context.read<EventDetailBloc>().add(EventDetailLoad(widget.id));
    }
  }

  @override
  void dispose() {
    super.dispose();
    context.read<EventDetailBloc>().close();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EventDetailBloc, EventDetailState>(
      buildWhen: (previous, current) => previous.event != current.event,
      builder: (context, state) {
        if (state.isSuccess) {
          final event = state.event;

          final correctedEventStart = event?.start.subtract(Duration(hours: 7));
          final isEventStarted =
              correctedEventStart?.isBefore(DateTime.now()) ?? false;

          return Scaffold(
            appBar: CustomAppBar(
              middleText: 'Undangan',
              onBack: () {
                if (context.canPop()) {
                  context.pop();
                } else {
                  context.go('/home');
                }
              },
              dropdownItems: !state.event!.isCanceled
                  ? [
                      PopupItem(
                        onPressed: () {
                          showModalBottomSheet(
                              context: context,
                              backgroundColor: white,
                              builder: (context) =>
                                  ShareBottomSheetContent(event: event!));
                        },
                        icon: share,
                        label: 'Bagikan Acara',
                      ),
                      PopupItem(
                          onPressed: () {
                            if (context.mounted) {
                              showModalBottomSheet(
                                backgroundColor: white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(24),
                                    topRight: Radius.circular(24),
                                  ),
                                ),
                                context: context,
                                builder: (context) => BlocProvider(
                                  create: (_) => getIt<EventDetailBloc>(),
                                  child: SizedBox(
                                    child: Padding(
                                      padding: EdgeInsets.all(16),
                                      child: SingleChildScrollView(
                                        child: IntrinsicHeight(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Center(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Container(
                                                      width: 60,
                                                      height: 6,
                                                      decoration: BoxDecoration(
                                                        color: neutral20,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(12),
                                                      ),
                                                    ),
                                                    Gap(24),
                                                    Image.asset(
                                                      'assets/images/faq.png',
                                                      width: 230,
                                                      height: 230,
                                                    ),
                                                    Gap(24),
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Text(
                                                          'Ingin membatalkan acara?',
                                                          style: headingThreeSemiBold
                                                              .copyWith(
                                                                  color:
                                                                      neutralBase),
                                                          textAlign:
                                                              TextAlign.center,
                                                        ),
                                                        Gap(6),
                                                        Text(
                                                          'Sudah yakin dengan keputusan anda ingin sekali membatalkan acara yang meriah ini?',
                                                          style:
                                                              titleTwo.copyWith(
                                                                  color:
                                                                      neutral40),
                                                          textAlign:
                                                              TextAlign.center,
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Gap(24),
                                              Row(
                                                children: [
                                                  Expanded(
                                                      child: Button(
                                                    onPressed: () =>
                                                        context.pop(),
                                                    type: ButtonType.secondary,
                                                    child: Text('Tidak',
                                                        style: titleOneSemiBold
                                                            .copyWith(
                                                                color:
                                                                    neutralBase)),
                                                  )),
                                                  SizedBox(
                                                      width:
                                                          10), // Spasi antar tombol
                                                  BlocBuilder<EventDetailBloc,
                                                      EventDetailState>(
                                                    builder: (context, state) {
                                                      return Expanded(
                                                          child: Button(
                                                        onPressed: () {
                                                          context
                                                              .read<
                                                                  EventDetailBloc>()
                                                              .add(
                                                                  EventDetailCancel(
                                                                      event!
                                                                          .id));
                                                          context.pop();
                                                        },
                                                        child: Text('Iya',
                                                            style: titleOneSemiBold
                                                                .copyWith(
                                                                    color:
                                                                        white)),
                                                      ));
                                                    },
                                                  )
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }
                          },
                          icon: trash,
                          label: 'Batalkan Acara'),
                    ]
                  : [],
            ),
            body: RefreshIndicator(
              onRefresh: () async {
                context.read<EventDetailBloc>().add(EventDetailLoad(widget.id));
              },
              child: Skeletonizer(
                enabled: state.isLoading,
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (event!.isCanceled)
                          Container(
                            width: double.infinity,
                            height: 80,
                            decoration: BoxDecoration(
                              color: error10,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Center(
                              child: Text(
                                'Acara telah dibatalkan',
                                style:
                                    headingTwoSemiBold.copyWith(color: error40),
                              ),
                            ),
                          ),
                        Gap(16),
                        SizedBox(
                          width: double.infinity,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(event.name,
                                  style: headingOneSemiBold.copyWith(
                                      color: neutralBase)),
                              Gap(8),
                              Text(
                                event.description,
                                style:
                                    titleOneRegular.copyWith(color: neutral40),
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
                                    style: titleOneRegular.copyWith(
                                        color: neutral40),
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
                                      Text(DateFormat.yMd().format(event.date),
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
                                    style: titleOneRegular.copyWith(
                                        color: neutral40),
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
                                      Text(DateFormat.yMd().format(event.start),
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
                                  style: titleOneMedium.copyWith(
                                      color: neutralBase),
                                ),
                                Text(
                                  '${event.memberCount.toString()} Hadir',
                                  style: titleTwoRegular.copyWith(
                                      color: neutral40),
                                )
                              ],
                            ),
                            const Gap(8),
                            if (event.participants.isNotEmpty)
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Row(
                                          children: List.generate(
                                        event.participants.length,
                                        (index) {
                                          if (index <
                                              event.participants.length) {
                                            return Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 4),
                                              child: Column(
                                                children: [
                                                  CircleAvatar(
                                                    radius: 24,
                                                    backgroundColor:
                                                        getRandomColor(),
                                                    child: Text(
                                                      event.participants[index]
                                                          .profile.firstname[0],
                                                      style:
                                                          headingOne.copyWith(
                                                              color: white),
                                                    ),
                                                  ),
                                                  Gap(4),
                                                  Text(
                                                    event.participants[index]
                                                        .profile.firstname,
                                                    style: titleTwo.copyWith(
                                                        color: neutralBase),
                                                  ),
                                                ],
                                              ),
                                            );
                                          }
                                          return SizedBox
                                              .shrink(); // Skip invalid indices
                                        },
                                      )),
                                    ),
                                    Gap(16),
                                    Button(
                                      onPressed: () {
                                        context.push(
                                            '/events/${event.id}/participants',
                                            extra: EventExtra(
                                                isEventStart: isEventStarted,
                                                isOwner: event.isOwner));
                                      },
                                      type: ButtonType.secondary,
                                      child: Text(
                                        'Lihat Semua',
                                        style: titleOneSemiBold.copyWith(
                                            color: neutralBase),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                          ],
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
                              event.location,
                              style:
                                  titleOneMedium.copyWith(color: neutralBase),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Gap(16),
                            Text(
                              'Tambahan',
                              style:
                                  titleOneMedium.copyWith(color: neutralBase),
                            ),
                            Column(
                              children: [
                                Column(
                                  children: [
                                    Gap(8),
                                    Container(
                                      width: double.infinity,
                                      padding: const EdgeInsets.all(12),
                                      decoration: BoxDecoration(
                                          color: white,
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          border: Border.all(
                                            color: neutral20,
                                          )),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
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
                                              if (!event.isCanceled ||
                                                  event.isDone)
                                                GestureDetector(
                                                  onTap: () {
                                                    if (event.activities
                                                        .isNotEmpty) {
                                                      context.push(
                                                          '/events/${event.id}/activities',
                                                          extra: EventExtra(
                                                              isEventStart:
                                                                  isEventStarted,
                                                              isOwner: event
                                                                  .isOwner));
                                                    } else {
                                                      context.push(
                                                          '/events/${event.id}/activities/add');
                                                    }
                                                  },
                                                  child: Text(
                                                    event.activities.isNotEmpty
                                                        ? 'Lihat Lainnya'
                                                        : 'Tambah',
                                                    style: titleTwoRegular
                                                        .copyWith(
                                                      color: primaryBase,
                                                      decoration: TextDecoration
                                                          .underline,
                                                      decorationColor:
                                                          primaryBase,
                                                      decorationThickness: 1.0,
                                                    ),
                                                  ),
                                                ),
                                            ],
                                          ),
                                          if (event.activities.isNotEmpty)
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Divider(
                                                  color: neutral20,
                                                  height: 24,
                                                ),
                                                Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                          event.activities[0]
                                                              .name,
                                                          style: titleOneMedium
                                                              .copyWith(
                                                                  color:
                                                                      neutralBase)),
                                                      Gap(4),
                                                      Text(
                                                        '${event.activities[0].start.hour.toString().padLeft(2, '0')}00 : ${event.activities[0].end.hour.toString().padLeft(2, '0')}:00',
                                                        style: titleTwoRegular
                                                            .copyWith(
                                                          color: neutral40,
                                                        ),
                                                      ),
                                                      Gap(4),
                                                      Text(
                                                          event.activities[0]
                                                              .description,
                                                          style: titleTwoRegular
                                                              .copyWith(
                                                                  color:
                                                                      neutral40)),
                                                    ]),
                                              ],
                                            )
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
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              border: Border.all(
                                                color: neutral20,
                                              )),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
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
                                                children: [
                                                  Expanded(
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          'Tema',
                                                          style: titleTwoRegular
                                                              .copyWith(
                                                                  color:
                                                                      neutral40),
                                                        ),
                                                        Gap(4),
                                                        Text(
                                                          event.theme,
                                                          style: titleOneMedium
                                                              .copyWith(
                                                                  color:
                                                                      neutralBase),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          'Pakaian',
                                                          style: titleTwoRegular
                                                              .copyWith(
                                                                  color:
                                                                      neutral40),
                                                        ),
                                                        Gap(4),
                                                        Text(
                                                          event.dresscode,
                                                          style: titleOneMedium
                                                              .copyWith(
                                                                  color:
                                                                      neutralBase),
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
              ),
            ),
            bottomNavigationBar: state.event!.isOwner
                ? !state.event!.isCanceled || state.event!.isDone
                    ? BottomAppBar(
                        color: white,
                        child: Row(
                          children: [
                            Expanded(
                              child: Button(
                                onPressed: () {
                                  context.push('/events/${event.id}/edit');
                                },
                                type: ButtonType.secondary,
                                child: Text('Edit',
                                    style: titleOneSemiBold.copyWith(
                                        color: neutralBase)),
                              ),
                            ),
                            Gap(8),
                            Expanded(
                              child: Button(
                                onPressed: () {
                                  if (isEventStarted) {
                                    context.push(
                                        '/events/${event.id}/participants/validate');
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        backgroundColor: neutral10,
                                        content: Row(
                                          children: [
                                            Icon(
                                              Icons.info,
                                              color: neutral40,
                                            ),
                                            Gap(8),
                                            Text(
                                              'Acara belum dimulai, tunggu hingga acara dimulai',
                                              style: titleTwo.copyWith(
                                                  color: neutralBase),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  }
                                },
                                type: isEventStarted
                                    ? ButtonType.primary
                                    : ButtonType.secondaryFill,
                                child: Text(
                                  'Mulai',
                                  style: titleOneSemiBold.copyWith(
                                    color: isEventStarted
                                        ? Colors.white
                                        : neutral40,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    : null
                : null,
            backgroundColor: white,
          );
        }

        return EventDetailSkeleton();
      },
    );
  }
}
