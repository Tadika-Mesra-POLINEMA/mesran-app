import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mesran_app/components/undo_button.dart';
import 'package:mesran_app/utils/themes.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: RundownActivitiesPage(),
    );
  }
}

class RundownActivitiesPage extends StatelessWidget {
  final List<Activity> activities = [
    Activity(
      title: 'Lari dari kenyataan',
      time: '07:00 - 08:00',
      description: 'Lorem ipsum dolor sit amet consectetur. Nullam...',
    ),
    Activity(
      title: 'Lari dari kenyataan',
      time: '07:00 - 08:00',
      description: 'Lorem ipsum dolor sit amet consectetur. Nullam...',
    ),
    Activity(
      title: 'Menjadi diri sendiri',
      time: '08:00 - 09:00',
      description:
          'Pergi ke tempat yang belum pernah dikunjungi. Temukan keindahan di sana.',
    ),
  ];

  RundownActivitiesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: white,
        title: Padding(
          padding: const EdgeInsets.all(0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              UndoButton(
                onPressed: () => context.go('/detailUndangan'),
                label: 'Aktifitas',
              ),
              TextButton(
                onPressed: () {
                  // Handle add new activity action
                },
                child: Text(
                  'Tambah',
                  style: TextStyle(color: primaryBase),
                ),
              ),
            ],
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: activities.length,
        itemBuilder: (context, index) {
          final activity = activities[index];
          return Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Dot and Line integrated directly here
                Column(
                  children: [
                    Container(
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                        color: primaryBase,
                        shape: BoxShape.circle,
                      ),
                    ),
                    Container(
                      width: 2,
                      height: 100, // Adjust line height as needed
                      color: neutral20,
                    ),
                  ],
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        activity.title,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      SizedBox(height: 4),
                      Text(activity.time,
                          style: TextStyle(color: neutral40, fontSize: 14)),
                      SizedBox(height: 4),
                      Text(activity.description,
                          style: TextStyle(color: neutral40, fontSize: 14)),
                    ],
                  ),
                ),
                SizedBox(width: 12),
                TextButton(
                  onPressed: () {
                    // Handle edit action
                  },
                  child: Text('Edit', style: TextStyle(color: primaryBase)),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class Activity {
  final String title;
  final String time;
  final String description;

  Activity({
    required this.title,
    required this.time,
    required this.description,
  });
}
