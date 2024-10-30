import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mesran_app/components/event/not_found_event_activities.dart';
import 'package:mesran_app/components/undo_button.dart';
import 'package:mesran_app/models/activity.dart';
import 'package:mesran_app/utils/themes.dart';

class EventActivitiesPage extends StatelessWidget {
  final int itemCount;

  const EventActivitiesPage({super.key, required this.itemCount});

  @override
  Widget build(BuildContext context) {
    // Example of dummy content

    // TODO: Implement query from REST API instead of using array like this
    final List<Activity> items = <Activity>[
      // Activity(
      //   title: 'Lari dari kenyataan',
      //   activityStart: DateTime(2024, 10, 29, 7, 0),
      //   activityEnd: DateTime(2024, 10, 29, 8, 0),
      //   description: 'Lorem lah pokoknya',
      // ),
      // Activity(
      //   title: 'Lari dari kenyataan',
      //   activityStart: DateTime(2024, 10, 29, 8, 0),
      //   activityEnd: DateTime(2024, 10, 29, 9, 0),
      //   description: 'Lorem lah pokoknya',
      // ),
      // Activity(
      //   title: 'Lari dari kenyataan',
      //   activityStart: DateTime(2024, 10, 29, 8, 0),
      //   activityEnd: DateTime(2024, 10, 29, 9, 0),
      //   description: 'Lorem lah pokoknya',
      // ),
    ];

    return Scaffold(
      appBar: AppBar(
        leading: UndoButton(
          onPressed: () => context.pop(),
          label: 'Activity',
          rightSection: GestureDetector(
            onTap: () => context.push('/events/activities/create'),
            child: Text(
              'Tambah',
              style: paragraphOne.copyWith(
                  color: primaryBase,
                  decoration: TextDecoration.underline,
                  decorationColor: primaryBase),
            ),
          ),
        ),
        leadingWidth: double.infinity,
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: items.isEmpty
            ? const NotFoundEventActivities()
            : ListView.builder(
                itemCount: items.length,
                itemBuilder: (BuildContext context, int index) {
                  final item = items[index];
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(right: 16),
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 2,
                            ),
                            Container(
                              width: 20,
                              height: 20,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: primaryBase,
                              ),
                            ),
                            if (index != items.length - 1)
                              Container(
                                width: 2,
                                height: 65,
                                color: neutral20,
                              ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item.title,
                                    style: titleOneMedium.copyWith(
                                        color: neutralBase),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    '${item.activityStart.hour.toString().padLeft(2, '0')}:${item.activityStart.minute.toString().padLeft(2, '0')} - ${item.activityEnd.hour.toString().padLeft(2, '0')}:${item.activityEnd.minute.toString().padLeft(2, '0')}',
                                    style: titleTwo.copyWith(color: neutral40),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    item.description,
                                    style: titleTwo.copyWith(color: neutral40),
                                  ),
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                context.push('/events/edit',
                                    extra: items[index]);
                              },
                              child: Text(
                                'Edit',
                                style: paragraphOne.copyWith(
                                    color: primaryBase,
                                    decoration: TextDecoration.underline,
                                    decorationColor: primaryBase),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
      ),
      backgroundColor: white,
    );
  }
}
