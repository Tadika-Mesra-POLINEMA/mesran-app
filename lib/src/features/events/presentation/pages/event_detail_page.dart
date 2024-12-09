import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:go_router/go_router.dart';
import 'package:mesran_app/src/config/injector.dart';
import 'package:mesran_app/src/config/styles/icons/custom.dart';
import 'package:mesran_app/src/config/styles/texts/medium.dart';
import 'package:mesran_app/src/config/styles/texts/regular.dart';
import 'package:mesran_app/src/config/styles/texts/semibold.dart';
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

class EventDetailPage extends StatefulWidget {
  final String eventId;

  const EventDetailPage({super.key, required this.eventId});

  @override
  State<EventDetailPage> createState() => _EventDetailPageState();
}

class _EventDetailPageState extends State<EventDetailPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      if (mounted) {
        context.read<EventDetailBloc>().add(EventDetailLoad(widget.eventId));
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          getIt<EventDetailBloc>()..add(EventDetailLoad(widget.eventId)),
      child: _EventDetailContent(id: widget.eventId),
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
  Widget build(BuildContext context) {
    return BlocBuilder<EventDetailBloc, EventDetailState>(
      builder: (context, state) {
        if (state.isSuccess) {
          final event = state.event;
          print('event id ${event!.id}');
          final isEventStarted = event.start.isBefore(DateTime.now());

          return Scaffold(
            appBar: CustomAppBar(
              middleText: 'Undangan',
              dropdownItems: [
                PopupItem(
                  onPressed: () {
                    showModalBottomSheet(
                        context: context,
                        backgroundColor: white,
                        builder: (context) =>
                            ShareBottomSheetContent(eventId: event.id));
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
                          builder: (context) => SizedBox(
                            child: Padding(
                              padding: EdgeInsets.all(16),
                              child: SingleChildScrollView(
                                child: IntrinsicHeight(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      SizedBox(height: 20),
                                      Center(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Image.asset(
                                              'assets/images/advertising.png',
                                              width: 230,
                                              height: 230,
                                            ),
                                            SizedBox(height: 10),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Text(
                                                  'Ingin keluar dari akun Anda?',
                                                  style: TextStyle(
                                                    color: neutralBase,
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                  textAlign: TextAlign.center,
                                                ),
                                                SizedBox(height: 5),
                                                Text(
                                                  'Semua perubahan yang belum disimpan akan hilang, dan Anda harus masuk kembali untuk mengakses fitur.',
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
                                                style:
                                                    titleOneSemiBold.copyWith(
                                                        color: neutralBase)),
                                          )),
                                          SizedBox(
                                              width: 10), // Spasi antar tombol
                                          Expanded(
                                              child: Button(
                                            onPressed: () =>
                                                context.replace('/login'),
                                            child: Text('Iya',
                                                style: titleOneSemiBold
                                                    .copyWith(color: white)),
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
                      }
                    },
                    icon: trash,
                    label: 'Batalkan Acara'),
              ],
            ),
            body: Skeletonizer(
              enabled: state.isLoading,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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
                                style:
                                    titleOneMedium.copyWith(color: neutralBase),
                              ),
                              Text(
                                event.memberCount.toString(),
                                style:
                                    titleTwoRegular.copyWith(color: neutral40),
                              )
                            ],
                          ),
                          const Gap(8),
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
                              children: [
                                SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Column(
                                        children: [
                                          Image.asset(
                                            'assets/images/orang.jpg',
                                            width: 40,
                                            height: 40,
                                          ),
                                          Text(
                                            'Sherina',
                                            style: titleTwoMedium.copyWith(
                                                color: neutralBase),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                const Gap(16),
                                // Button(
                                //   onPressed: () {},
                                //   style: buttonSecondaryBase,
                                //   child: Text('Lihat Semua',
                                //       style: titleOneSemiBold.copyWith(
                                //           color: neutralBase)),
                                // )
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
                            style: titleOneMedium.copyWith(color: neutralBase),
                          ),
                          Gap(4),
                          // Container(
                          //   width: double.infinity,
                          //   height: 180,
                          //   decoration: BoxDecoration(
                          //     color: neutral10,
                          //     borderRadius: BorderRadius.circular(12),
                          //   ),
                          // ),
                          // // Gap(4),
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
                                            Text(
                                              'Lihat Lainnya',
                                              style: titleTwoRegular.copyWith(
                                                color: primaryBase,
                                                decoration:
                                                    TextDecoration.underline,
                                                decorationColor: primaryBase,
                                                decorationThickness: 1.0,
                                              ),
                                            ),
                                          ],
                                        ),
                                        // Divider(
                                        //   color: neutral20,
                                        //   height: 16,
                                        // ),
                                        // Column(
                                        //   crossAxisAlignment:
                                        //       CrossAxisAlignment.start,
                                        //   children: [
                                        //     Text(
                                        //       'Lari dari kenyataan',
                                        //       style: titleOneMedium.copyWith(
                                        //           color: neutralBase),
                                        //     ),
                                        //     Gap(4),
                                        //     Text(
                                        //       '07:00 - 08:00',
                                        //       style: titleTwoRegular.copyWith(
                                        //           color: neutral40),
                                        //     ),
                                        //     Gap(4),
                                        //     Text(
                                        //       'Lorem ipsum dolor sit amet consectetur. Nullam t...',
                                        //       style: titleTwoRegular.copyWith(
                                        //           color: neutral40),
                                        //     ),
                                        //   ],
                                        // ),
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
                                              // mainAxisAlignment:
                                              // MainAxisAlignment.spaceBetween,
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
            bottomNavigationBar: state.event!.isOwner
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
                              context.push(
                                  '/events/${event.id}/participants/validate');
                              if (isEventStarted) {}
                            },
                            type: isEventStarted
                                ? ButtonType.primary
                                : ButtonType.secondaryFill,
                            child: Text('Mulai',
                                style: titleOneSemiBold.copyWith(
                                    color: isEventStarted ? white : neutral40)),
                          ),
                        ),
                      ],
                    ),
                  )
                : null,
            backgroundColor: white,
          );
        }

        return EventDetailSkeleton();
      },
    );
  }
}
