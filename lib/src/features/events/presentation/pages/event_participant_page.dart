import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:mesran_app/src/config/injectors/injector.dart';
import 'package:mesran_app/src/config/styles/icons/custom.dart';
import 'package:mesran_app/src/config/styles/texts/medium.dart';
import 'package:mesran_app/src/config/styles/texts/regular.dart';
import 'package:mesran_app/src/config/styles/texts/semibold.dart';
import 'package:mesran_app/src/config/styles/themes/colors/custom.dart';
import 'package:mesran_app/src/config/styles/themes/colors/neutral.dart';
import 'package:mesran_app/src/config/styles/themes/colors/primary.dart';
import 'package:mesran_app/src/config/styles/themes/colors/success.dart';
import 'package:mesran_app/src/features/events/presentation/bloc/event_participant_bloc.dart';
import 'package:mesran_app/src/features/events/presentation/bloc/event_participant_event.dart';
import 'package:mesran_app/src/features/events/presentation/bloc/event_participant_state.dart';
import 'package:mesran_app/src/shared/presentation/widgets/custom_app_bar.dart';
import 'package:mesran_app/src/shared/presentation/widgets/form/button.dart';

class EventParticipantPage extends StatelessWidget {
  final String eventId;
  final bool isEventStart;
  final bool isOwner;

  const EventParticipantPage({
    super.key,
    required this.eventId,
    required this.isEventStart,
    required this.isOwner,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<EventParticipantBloc>(),
      child: EventParticipantContent(
        eventId: eventId,
        isEventStart: isEventStart,
        isOwner: isOwner,
      ),
    );
  }
}

class EventParticipantContent extends StatefulWidget {
  final String eventId;
  final bool isEventStart;
  final bool isOwner;

  const EventParticipantContent({
    super.key,
    required this.eventId,
    required this.isEventStart,
    required this.isOwner,
  });

  @override
  State<EventParticipantContent> createState() =>
      _EventParticipantContentState();
}

class _EventParticipantContentState extends State<EventParticipantContent> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      if (mounted) {
        context
            .read<EventParticipantBloc>()
            .add(FetchEventParticipant(widget.eventId));
      }
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (mounted) {
      context
          .read<EventParticipantBloc>()
          .add(FetchEventParticipant(widget.eventId));
    }
  }

  @override
  void dispose() {
    super.dispose();
    context.read<EventParticipantBloc>().close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(leadingText: 'Tamu'),
      backgroundColor: white,
      body: BlocListener<EventParticipantBloc, EventParticipantState>(
        listener: (context, state) {
          if (state is AcceptAttendanceSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: successBase,
              ),
            );
            context
                .read<EventParticipantBloc>()
                .add(FetchEventParticipant(widget.eventId));
          } else if (state is EventParticipantError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        child: BlocBuilder<EventParticipantBloc, EventParticipantState>(
          builder: (context, state) {
            return DefaultTabController(
              length: 2,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TextField(
                      style: titleOneRegular,
                      decoration: InputDecoration(
                        hintText: 'Cari anggota',
                        hintStyle: titleOneRegular.copyWith(color: neutral40),
                        prefixIcon: magnifier,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(24),
                          borderSide: BorderSide(color: neutral20),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(24),
                          borderSide: BorderSide(color: primaryBase),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 12),
                      ),
                    ),
                    Gap(16),
                    TabBar(
                      indicatorColor: primaryBase,
                      labelColor: primaryBase,
                      indicatorSize: TabBarIndicatorSize.tab,
                      unselectedLabelColor: neutral40,
                      tabs: [
                        Tab(
                          child: Text("Belum Hadir", style: titleOneMedium),
                        ),
                        Tab(
                          child: Text("Hadir", style: titleOneMedium),
                        ),
                      ],
                    ),
                    Gap(16),
                    Expanded(
                      child: TabBarView(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: RefreshIndicator(
                              color: primaryBase,
                              backgroundColor: white,
                              onRefresh: () async {
                                context
                                    .read<EventParticipantBloc>()
                                    .add(FetchEventParticipant(widget.eventId));
                              },
                              child: state is EventParticipantSuccess &&
                                      state.attendance.notYetAttends.isNotEmpty
                                  ? ListView.builder(
                                      itemCount:
                                          state.attendance.notYetAttends.length,
                                      itemBuilder: (context, index) {
                                        var participant = state
                                            .attendance.notYetAttends[index];
                                        return Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 8.0),
                                          child: Row(
                                            children: [
                                              CircleAvatar(
                                                radius: 24,
                                                backgroundColor:
                                                    getRandomColor(),
                                                child: Text(
                                                  participant
                                                      .profile.firstname[0],
                                                  style: headingThreeSemiBold
                                                      .copyWith(color: white),
                                                ),
                                              ),
                                              Gap(12),
                                              Expanded(
                                                child: Text(
                                                  '${participant.profile.firstname} ${participant.profile.lastname}',
                                                  style: titleOneMedium,
                                                ),
                                              ),
                                              if (widget.isEventStart &&
                                                  widget.isOwner)
                                                GestureDetector(
                                                  onTap: () {
                                                    showModalBottomSheet(
                                                      backgroundColor: white,
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.only(
                                                          topLeft:
                                                              Radius.circular(
                                                                  24),
                                                          topRight:
                                                              Radius.circular(
                                                                  24),
                                                        ),
                                                      ),
                                                      context: context,
                                                      builder: (context) =>
                                                          BlocProvider(
                                                        create: (_) => getIt<
                                                            EventParticipantBloc>(),
                                                        child: SizedBox(
                                                          child: Padding(
                                                            padding:
                                                                EdgeInsets.all(
                                                                    16),
                                                            child:
                                                                SingleChildScrollView(
                                                              child:
                                                                  IntrinsicHeight(
                                                                child: Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    Center(
                                                                      child:
                                                                          Column(
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.center,
                                                                        children: [
                                                                          Container(
                                                                            width:
                                                                                60,
                                                                            height:
                                                                                6,
                                                                            decoration:
                                                                                BoxDecoration(
                                                                              color: neutral20,
                                                                              borderRadius: BorderRadius.circular(12),
                                                                            ),
                                                                          ),
                                                                          Gap(24),
                                                                          Image
                                                                              .asset(
                                                                            'assets/images/faq.png',
                                                                            width:
                                                                                230,
                                                                            height:
                                                                                230,
                                                                          ),
                                                                          Gap(24),
                                                                          Column(
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.center,
                                                                            children: [
                                                                              Text(
                                                                                'Klik untuk menyetujui!',
                                                                                style: headingThreeSemiBold.copyWith(color: neutralBase),
                                                                                textAlign: TextAlign.center,
                                                                              ),
                                                                              Gap(6),
                                                                              Text(
                                                                                'Apakah Anda yakin ingin melanjutkan dan memberikan konfirmasi atas kehadiran tamu tersebut?',
                                                                                style: titleTwo.copyWith(color: neutral40),
                                                                                textAlign: TextAlign.center,
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
                                                                            child:
                                                                                Button(
                                                                          onPressed:
                                                                              () {
                                                                            context.pop();
                                                                          },
                                                                          type:
                                                                              ButtonType.secondary,
                                                                          child: Text(
                                                                              'Tidak',
                                                                              style: titleOneSemiBold.copyWith(color: neutralBase)),
                                                                        )),
                                                                        Gap(10),
                                                                        BlocBuilder<
                                                                            EventParticipantBloc,
                                                                            EventParticipantState>(builder: (context, state) {
                                                                          return Expanded(
                                                                              child: Button(
                                                                            onPressed:
                                                                                () {
                                                                              context.read<EventParticipantBloc>().add(AcceptParticipant(widget.eventId, participant.id));
                                                                              context.pop();
                                                                            },
                                                                            child:
                                                                                Text('Iya', style: titleOneSemiBold.copyWith(color: white)),
                                                                          ));
                                                                        })
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
                                                  },
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                        color: primaryBase,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(64)),
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 10,
                                                              vertical: 4),
                                                      child: Text('Hadir',
                                                          style:
                                                              titleTwo.copyWith(
                                                                  color:
                                                                      white)),
                                                    ),
                                                  ),
                                                ),
                                            ],
                                          ),
                                        );
                                      },
                                    )
                                  : Center(
                                      child: Text("Belum ada tamu yang hadir")),
                            ),
                          ),
                          // Hadir Tab
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: RefreshIndicator(
                              onRefresh: () async {
                                context
                                    .read<EventParticipantBloc>()
                                    .add(FetchEventParticipant(widget.eventId));
                              },
                              child: state is EventParticipantSuccess &&
                                      state.attendance.attends.isNotEmpty
                                  ? ListView.builder(
                                      itemCount:
                                          state.attendance.attends.length,
                                      itemBuilder: (context, index) {
                                        var participant =
                                            state.attendance.attends[index];
                                        return Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 8.0),
                                          child: Row(
                                            children: [
                                              CircleAvatar(
                                                radius: 24,
                                                backgroundColor:
                                                    getRandomColor(),
                                                child: Text(
                                                  participant
                                                      .profile.firstname[0],
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white),
                                                ),
                                              ),
                                              Gap(12),
                                              Expanded(
                                                child: Text(
                                                  '${participant.profile.firstname} ${participant.profile.lastname}',
                                                  style: titleOneMedium,
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    )
                                  : Center(
                                      child: Text("Tidak ada tamu yang hadir")),
                            ),
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
  }
}
