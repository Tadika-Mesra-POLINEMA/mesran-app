import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:mesran_app/src/config/injectors/injector.dart';
import 'package:mesran_app/src/config/styles/texts/medium.dart';
import 'package:mesran_app/src/config/styles/texts/regular.dart';
import 'package:mesran_app/src/config/styles/texts/semibold.dart';
import 'package:mesran_app/src/config/styles/themes/colors/neutral.dart';
import 'package:mesran_app/src/config/styles/themes/colors/primary.dart';
import 'package:mesran_app/src/features/notification/domain/entity/notification.dart';
import 'package:mesran_app/src/features/notification/presentation/bloc/notification_bloc.dart';
import 'package:mesran_app/src/features/notification/presentation/bloc/notification_event.dart';
import 'package:mesran_app/src/features/notification/presentation/bloc/notification_state.dart';
import 'package:mesran_app/src/features/notification/presentation/widgets/empty_notification.dart';
import 'package:mesran_app/src/shared/presentation/widgets/custom_app_bar.dart';
import 'package:mesran_app/src/shared/presentation/widgets/form/button.dart';
import 'package:skeletonizer/skeletonizer.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<NotificationBloc>(
      create: (_) => getIt<NotificationBloc>(),
      child: const NotificationContent(),
    );
  }
}

class NotificationContent extends StatefulWidget {
  const NotificationContent({super.key});

  @override
  State<NotificationContent> createState() => _NotificationContentState();
}

class _NotificationContentState extends State<NotificationContent> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      if (mounted) {
        BlocProvider.of<NotificationBloc>(context)
            .add(const NotificationLoadEvent());
      }
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (mounted) {
      BlocProvider.of<NotificationBloc>(context)
          .add(const NotificationLoadEvent());
    }
  }

  @override
  void dispose() {
    super.dispose();

    BlocProvider.of<NotificationBloc>(context).close();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NotificationBloc, NotificationState>(
      listener: (context, state) {
        if (state is NotificationError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
            ),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: CustomAppBar(
            leadingText: 'Notifikasi',
          ),
          backgroundColor: white,
          body: Skeletonizer(
            enabled: state is NotificationLoading,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: _buildNotificationContent(state),
            ),
          ),
        );
      },
    );
  }

  Widget _buildNotificationContent(NotificationState state) {
    if (state is NotificationLoading) {
      return Skeletonizer(
        child: ListView.builder(
          itemCount: 5,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 24,
                    backgroundColor: neutral10,
                  ),
                  Gap(12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(height: 16, width: 100, color: neutral10),
                        Gap(4),
                        Container(height: 14, width: 50, color: neutral10),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      );
    }

    if (state is NotificationLoaded) {
      return state.notifications.isEmpty
          ? const EmptyNotification()
          : ListView.builder(
              itemCount: state.notifications.length,
              itemBuilder: (context, index) {
                final notification = state.notifications[index];

                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 24,
                      child: Text(notification.sender.firstName[0]),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                notification.sender.firstName,
                                style: titleOneSemiBold.copyWith(
                                    color: primaryBase),
                              ),
                              Gap(4),
                              Text(
                                notification.content!,
                                style: titleOne.copyWith(color: neutralBase),
                              ),
                            ],
                          ),
                          Gap(6),
                          Text(
                            '02:12',
                            style: titleTwoMedium.copyWith(color: neutral40),
                          ),
                          Gap(8),
                          if (notification.type ==
                              NotificationType.confirmation)
                            SizedBox(
                              width: 200,
                              child: Row(
                                children: [
                                  Expanded(
                                      child: Button(
                                          onPressed: () {
                                            BlocProvider.of<NotificationBloc>(
                                                    context)
                                                .add(DeclineGuest(
                                                    notification.eventId,
                                                    notification.sender.id));
                                          },
                                          type: ButtonType.secondary,
                                          child: Text(
                                            'Tolak',
                                            style: titleThreeSemiBold.copyWith(
                                                color: neutralBase),
                                          ))),
                                  Gap(8),
                                  Expanded(
                                      child: Button(
                                          onPressed: () {
                                            BlocProvider.of<NotificationBloc>(
                                                    context)
                                                .add(AcceptGuest(
                                                    notification.eventId,
                                                    notification.sender.id));
                                          },
                                          type: ButtonType.primary,
                                          child: Text(
                                            'Terima',
                                            style: titleThreeSemiBold.copyWith(
                                                color: white),
                                          ))),
                                ],
                              ),
                            )
                        ],
                      ),
                    ),
                  ],
                );
              },
            );
    } else {
      return const EmptyNotification();
    }
  }
}
